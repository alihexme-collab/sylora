from sqlalchemy import select
from database.db_manager import get_db
from database.model import *
from .bus import bus
from sqlalchemy.ext.asyncio import AsyncSession

class Sleep:
    async def get(self, **data):
        self.chat_id = data.get("chat_id")
        self.message = data.get("message")
        # استفاده از get_db به عنوان Context Manager برای تراکنش فعال
        async with get_db() as session:
            self.session = session
            await self._sleep()

    async def tick(self, **data):
        async with get_db() as session:
            session: AsyncSession

            # ۱. گرفتن کاراکترها و استت‌ها به صورت همزمان برای زنده بودن کاراکتر
            query = (
                select(Character, CharacterStats)
                .join(CharacterStats, Character.character_id == CharacterStats.character_id)
                .where(Character.is_alive == True)
            )
            results = await session.execute(query)
            
            # خروجی execute برای چند کلاس ORM به صورت Rowهای چندتایی (Tuple) بازمی‌گردد
            for char, stats in results.all():
                stats.hp = min(stats.hp + 10, stats.base_hp)
                stats.mana = min(stats.mana + 1, stats.base_mana)
                stats.energy = min(stats.energy + 5, stats.base_energy)

            # ۲. بروزرسانی منابع EnemyStats
            query = select(EnemyStats)
            results = await session.execute(query)
            for stats in results.scalars().all():
                stats.hp = min(stats.hp + 10, stats.base_hp)
                stats.mana = min(stats.mana + 1, stats.base_mana)
                stats.energy = min(stats.energy + 5, stats.base_energy)

            # ۳. بروزرسانی منابع NpcStats
            query = select(NpcStats)
            results = await session.execute(query)
            for stats in results.scalars().all():
                stats.hp = min(stats.hp + 10, stats.base_hp)
                stats.mana = min(stats.mana + 1, stats.base_mana)
                stats.energy = min(stats.energy + 5, stats.base_energy)

            await session.commit()                  

    async def _sleep(self):
        await self.get_character()
        
        # در صورتی که کاراکتر یا استت‌های وی وجود نداشته باشند
        if not self.stats:
            return

        hp_diff = abs(self.stats.base_hp - self.stats.hp)
        mana_diff = abs(self.stats.base_mana - self.stats.mana)
        energy_diff = abs(self.stats.base_energy - self.stats.energy)
        
        # محاسبه هزینه تجربه بر اساس میزان آسیب دیدگی
        exp_cost = int(
             hp_diff * 0.5 + 
             mana_diff * 2 +
             energy_diff
        )
        
        if self.stats.exp >= exp_cost:
            self.stats.exp -= exp_cost
            self.stats.hp = self.stats.base_hp
            self.stats.mana = self.stats.base_mana
            self.stats.energy = self.stats.base_energy
            
            await self.session.commit()
            
            text = (
                f"💤 <b>فرآیند تجدید قوا و استراحت با موفقیت انجام شد.</b>\n\n"
                f"✨ شما با پرداخت <code>{exp_cost}</code> واحد تجربه، جراحات خود را التیام بخشیدید.\n\n"
                f"📊 <b>وضعیت نهایی منابع شما:</b>\n"
                f"❤️ <b>سلامتی:</b> <code>{self.stats.hp}/{self.stats.base_hp}</code>\n"
                f"⚡ <b>انرژی:</b> <code>{self.stats.energy}/{self.stats.base_energy}</code>\n"
                f"🔮 <b>مانا:</b> <code>{self.stats.mana}/{self.stats.base_mana}</code>\n"
            )
            
            await bus.emit(
                 "SEND",
                 player_id=self.chat_id,
                 message=self.message,
                 text=text
            )
        else:
             await bus.emit(
                 "SEND",
                 player_id=self.chat_id,
                 message=self.message,
                 text="❌ <b>تجربه کافی برای درمان زخم‌های خود ندارید.</b>\n\n"
                      "برای بازسازی کامل منابع از این طریق، به تجربه (XP) بیشتری نیاز دارید. "
                      "لطفاً در نبردها و ماجراجویی‌های بعدی تجربه لازم را کسب کنید."
            )

    async def get_character(self):
        player_query = await self.session.execute(
            select(Player).where(Player.telegram_id == self.chat_id)
        )
        self.player = player_query.scalar_one_or_none()

        if not self.player:
            self.character = None
            self.stats = None
            return

        char_query = await self.session.execute(
            select(Character).where(Character.player_id == self.player.player_id)
        )
        self.character = char_query.scalar_one_or_none()

        if not self.character:
            self.stats = None
            return

        stats_query = await self.session.execute(
            select(CharacterStats).where(CharacterStats.character_id == self.character.character_id)
        )
        self.stats = stats_query.scalar_one_or_none()


sleep = Sleep()

bus.listen("SLEEP", sleep.get)
bus.listen("TICK", sleep.tick)
