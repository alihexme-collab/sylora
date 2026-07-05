from sqlalchemy import select
from database.db_manager import get_db
from database.model import *
from .bus import bus
from sqlalchemy.ext.asyncio import AsyncSession

class Sleep:
    async def get(self, **data):
        self.chat_id = data.get("chat_id")
        self.message = data.get("message")
        async with get_db() as self.session:
            await self._sleep()
    async def tick(self, **data):
        async with get_db() as session:
            session: AsyncSession

            query = (
                select(Character, CharacterStats)
                .join(CharacterStats, Character.character_id == CharacterStats.character_id)
                .where(Character.is_alive == True)
            )

            results = await session.execute(query)

            for char, stats in results.all():
                # HP
                stats.hp = min(stats.hp + 10, stats.base_hp)

                # Mana
                stats.mana = min(stats.mana + 1, stats.base_mana)

                # Energy
                stats.energy = min(stats.energy + 5, stats.base_energy)

            query = select(EnemyStats)

            results = await session.execute(query)

            for stats in results.all():
                # HP
                stats.hp = min(stats.hp + 10, stats.base_hp)

                # Mana
                stats.mana = min(stats.mana + 1, stats.base_mana)

                # Energy
                stats.energy = min(stats.energy + 5, stats.base_energy)

            query = select(NpcStats)

            results = await session.execute(query)

            for stats in results.all():
                # HP
                stats.hp = min(stats.hp + 10, stats.base_hp)

                # Mana
                stats.mana = min(stats.mana + 1, stats.base_mana)

                # Energy
                stats.energy = min(stats.energy + 5, stats.base_energy)

            await session.commit()                  
                   

    async def _sleep(self):
        await self.get_character()
        hp = abs(self.stats.base_hp - self.stats.hp)
        mana = abs(self.stats.base_mana - self.stats.mana)
        energy = abs(self.stats.base_energy - self.stats.energy)
        exp_cost = int(
             hp * .5 + 
             mana * 2 +
             energy
        )
        if self.stats.exp >= exp_cost:
            self.stats.exp -= exp_cost
            self.stats.hp = self.stats.base_hp
            self.stats.mana = self.stats.base_mana
            self.stats.energy = self.stats.base_energy
            self.session.commit()
            await bus.emit(
                 "SEND",
                 player_id=self.chat_id,
                 message=self.message,
                 text=f"""
از شما {exp_cost} واحد تجربه کاسته شد

وضیت فعلی منابع شما:
سلامتی: {self.stats.hp}
انرژی: {self.stats.energy}
مانا: {self.stats.mana}
"""
            )
        else:
             await bus.emit(
                 "SEND",
                 player_id=self.chat_id,
                 message=self.message,
                 text="شما تجربه کافی برای درمان زخم هایتان ندارید، لطفا حداقل 100 واحد تجربه بدست آورید"
            )


    async def get_character(self):
            player = await self.session.execute(
                select(Player).where(Player.telegram_id == self.chat_id)
            )
            self.player = player.scalar_one_or_none()

            character =await self.session.execute(
                select(Character).where(Character.player_id == self.player.player_id)
            )
            self.character = character.scalar_one_or_none()

            stats = await self.session.execute(
                select(CharacterStats).where(CharacterStats.character_id == self.character.character_id)
            )
            self.stats = stats.scalar_one_or_none()


move = Sleep()

bus.listen("SLEEP", move.get)
bus.listen("TICK", move.tick)