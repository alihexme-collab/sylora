from .bus import bus
from database.db_manager import get_db
from database.model import *
from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession as Session

class UpdateStats:
    async def get(self, **data):
        self.chat_id = data.get("chat_id")
        self.query = data.get("query")
        await self.update()

    async def update(self):
        data:str = self.query.data.replace("upgrade:", "")
        if data.find("?••?/") == -1:
            return
        print(data)
        data, message = data.split("?••?/")
        stat, price = data.split("-")
        async with get_db() as session:
            session: Session

            query = select(Player).where(Player.telegram_id == self.chat_id)
            result = await session.execute(query)
            plr = result.scalar_one_or_none()

            query = select(Character).where(Character.player_id == plr.player_id)
            result = await session.execute(query)
            chr = result.scalar_one_or_none()

            query = select(CharacterStats).where(CharacterStats.character_id == chr.character_id)
            result = await session.execute(query)
            stats = result.scalar_one_or_none()
            if stats.exp - int(price) > 0:
                curr = getattr(stats, stat)
                setattr(stats, stat, curr + 1)
                stats.exp -= int(price)
                await bus.emit(
                    "GENERATE_UPDATE",
                    player_id=self.chat_id,
                    chat_id=self.chat_id,
                    message=message,
                    stat_name=stat,
                    price=price,
                    curr=getattr(stats, stat),
                    name=chr.name,
                    username=plr.username
                )
            else:
                await bus.emit(
                    "SEND",
                    player_id=self.chat_id,
                    chat_id=self.chat_id,
                    text="تجربه شما کافی نمی باشد",
                    message=message,
                )


upt = UpdateStats()
bus.listen("UPDATE", upt.get)