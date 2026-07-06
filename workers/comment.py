from .bus import bus
from database.db_manager import get_db
from database.model import *
from sqlalchemy import select
from datetime import datetime
from pathlib import Path
import json

class Comment:
    async def commenting(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")
        
        async with get_db() as session:
            result = await session.execute(select(Player).where(Player.telegram_id == chat_id))
            plr: Player = result.scalar_one_or_none()
            if plr:
                plr.current_work = "commenting"
                await session.commit()  # اضافه کردن commit برای ذخیره تغییرات وضعیت بازیکن

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
            if plr:
                plr.current_work = ""
                await session.commit()  # اضافه کردن commit برای ذخیره تغییرات وضعیت بازیکن

        path = Path("comment.json")
        comments = {}

        # ۱. خواندن کامنت‌های قبلی در صورت وجود فایل
        if path.exists():
            try:
                with open("comment.json", "r", encoding="utf-8") as file:
                    content = file.read().strip()
                    comments = json.loads(content) if content else {}
            except (json.JSONDecodeError, OSError):
                comments = {}

        # ۲. اضافه کردن کامنت جدید به دیکشنری (با تبدیل datetime به رشته)
        comments[str(chat_id)] = {
            "text": message.text,
            "date": datetime.now().isoformat()  # رفع خطای عدم امکان سریالایز کردن datetime
        }

        # ۳. ذخیره‌سازی مجدد کل دیکشنری
        with open("comment.json", "w", encoding="utf-8") as file:
            json.dump(comments, file, ensure_ascii=False, indent=4)

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