from sqlalchemy import select
from database.db_manager import get_db
from database.model import *
from .bus import bus

class Sleep:
    async def get(self, **data):
        self.chat_id = data.get("chat_id")
        self.message = data.get("message")
        async with get_db() as self.session:
            await self._sleep()

    async def _sleep(self):
        await self.get_character()
        if self.stats.exp >= 100:
            self.stats.exp -= 100
            self.stats.hp = self.stats.base_hp
            self.stats.mana = self.stats.base_mana
            self.stats.energy = self.stats.base_energy
            self.session.commit()
            await bus.emit(
                 "SEND",
                 player_id=self.chat_id,
                 message=self.message,
                 text=f"""
از شما 100 واحد تجربه کاسته شد

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