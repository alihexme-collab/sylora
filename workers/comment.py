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
            plr = result.scalar_one_or_none()
            if plr:
                plr.current_work = "commenting"
                await session.commit()

        await bus.emit(
            "SEND",
            text="✍️ <b>ثبت نظرات و پیشنهادات</b>\n\n"
                 "ماجراجوی گرامی، لطفاً نظرات، انتقادات یا پیشنهادات خود را در قالب یک پیام متنی بنویسید و ارسال کنید. "
                 "نظرات شما مستقیماً توسط تیم توسعه بررسی خواهد شد.",
            message=message,
            player_id=chat_id,
            chat_id=chat_id
        )

    async def comment(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")

        async with get_db() as session:
            result = await session.execute(select(Player).where(Player.telegram_id == chat_id))
            plr = result.scalar_one_or_none()
            if plr:
                plr.current_work = ""
                await session.commit()

        path = Path("comment.json")
        comments = {}

        # ۱. خواندن ایمن کامنت‌های قبلی در صورت وجود فایل
        if path.exists():
            try:
                with open(path, "r", encoding="utf-8") as file:
                    content = file.read().strip()
                    comments = json.loads(content) if content else {}
            except (json.JSONDecodeError, OSError):
                comments = {}

        # ۲. اضافه کردن کامنت جدید به دیکشنری
        comments[str(chat_id)] = {
            "text": message.text,
            "date": datetime.now().isoformat()
        }

        # ۳. ذخیره‌سازی مجدد و ایمن کل دیکشنری در فایل
        try:
            with open(path, "w", encoding="utf-8") as file:
                json.dump(comments, file, ensure_ascii=False, indent=4)
        except OSError as exc:
            print(f"Error saving comment to file: {exc}")
            await bus.emit(
                "SEND",
                text="❌ <b>خطایی در ثبت موقت نظر رخ داد.</b>\n\nلطفاً کمی بعد مجدداً تلاش کنید.",
                message=message,
                chat_id=chat_id,
                player_id=chat_id
            )
            return

        await bus.emit(
            "SEND",
            text="✅ <b>بازخورد شما با موفقیت ثبت شد!</b>\n\n"
                 "از اینکه برای بهبود دنیای بازی وقت گذاشتید صمیمانه سپاسگزاریم. "
                 "پیشنهاد شما به زودی توسط مدیریت بررسی خواهد شد.",
            message=message,
            chat_id=chat_id,
            player_id=chat_id,
            parse_mode="HTML"
        )


cment = Comment()
bus.listen("COMMENTING", cment.commenting)
bus.listen("COMMENT", cment.comment)
