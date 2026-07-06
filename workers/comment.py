from .bus import bus
from database.db_manager import get_db
from database.model import *
from sqlalchemy import select, func
from datetime import datetime
import random as rnd
import uuid
from pathlib import Path
import json

class Comment:
    async def commenting(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")
        
        async with get_db() as session:
            result = await session.execute(select(Player).where(Player.telegram_id == chat_id))
            plr: Player = result.scalar_one_or_none()
            plr.current_work = "commenting"

        await bus.emit(
            "SEND",
            text="لطفا نظرات و پیشنهادات خود را وارد کنید",
            message=message,
            player_id=chat_id,
            chat_id=chat_id
        )

    async def comment(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")

        async with get_db() as session:
            result = await session.execute(select(Player).where(Player.telegram_id == chat_id))
            plr: Player = result.scalar_one_or_none()
            plr.current_work = ""

        path = Path(
            "comment.json"
        )
        if path.exists():
            with open("comment.json", "r") as file:
                comments = json.load(file)

        else:
            comments = {
                str(chat_id) : {
                    "text": message.text,
                    "date": datetime.now()
                }
            }

        with open("comment.json", "w") as file:
            json.dump(comments, file)

        await bus.emit(
            "SEND",
            text="نظر شما با موفقیت ثبت شد، بزودی به آن رسیدگی خواهد شد",
            message=message,
            chat_id=chat_id,
            player_id=chat_id
        )

cment = Comment()
bus.listen("COMMENTING", cment.commenting)
bus.listen("COMMENT", cment.comment)