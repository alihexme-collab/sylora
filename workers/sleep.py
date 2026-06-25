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
            self.stats.hp += 2000
            self.stats.mana += 500
            self.stats.energy += 50
            self.session.commit()
            await bus.emit(
                 "SEND",
                 player_id=self.chat_id,
                 message=self.message,
                 text="100 تجربه از شما کاسته شد و 5000 سلامتی به شما اضافه گشت"
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
                select(Character).where(Character.player_id == player.player_id)
            )
            self.character = character.scalar_one_or_none()

            stats = await self.session.execute(
                select(CharacterStats).where(CharacterStats.character_id == character.character_id)
            )
            self.stats = stats.scalar_one_or_none()


    



move = Sleep()

bus.listen("SLEEP", move.get)