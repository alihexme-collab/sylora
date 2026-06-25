from .bus import bus
from database.db_manager import get_db
from database.model import *
from sqlalchemy import select, func
from datetime import datetime
import random as rnd
import uuid


class Command:

    async def receive(self, **data):

        chat_id = data["chat_id"]
        text = data["text"]
        username = data["username"]
        name = data.get("name")
        message = data.get("message")

        cmd = text.split()[0].lower()

        match cmd:

            case "/start":
                await self.start(chat_id, username, name, message)

    async def start(self, chat_id, username, name, message):
        # ۱. بررسی وجود بازیکن با استفاده از chat_id (عددی)
        player_id_in_db = await self.check_exists(int(chat_id))

        if player_id_in_db:
            # اگر بازیکن وجود داشت، اطلاعاتش را لود می‌کنیم
            async with get_db() as session:
                hero = await session.scalar(
                    select(Character).where(Character.player_id == player_id_in_db)
                )
                stats = await session.scalar(
                    select(CharacterStats).where(CharacterStats.character_id == hero.character_id)
                )
        else:
            # ۲. بازیکن جدید: تولید UUID برای آیدی‌های متنی
            new_player_uuid = str(uuid.uuid4()) # تولید یک رشته طولانی و یکتا
            new_character_uuid = str(uuid.uuid4())

            async with get_db() as session:
                try:
                    # انتخاب لوکیشن و NPC پایه
                    loc = await session.scalar(select(Location).order_by(func.random()).limit(1))
                    npc = await session.scalar(select(NpcStats).order_by(func.random()).limit(1))

                    # الف) ساخت رکورد بازیکن
                    new_player = Player(
                        player_id=new_player_uuid,
                        telegram_id=int(chat_id), # ستون عددی
                        username=username,
                        created_at=datetime.now(),
                        role="user",
                        is_banned=False
                    )
                    session.add(new_player)
                    await session.flush() 

                    # ب) ساخت رکورد کاراکتر
                    hero = Character(
                        character_id=new_character_uuid,
                        player_id=new_player_uuid,
                        created_at=datetime.now(),
                        is_alive=True,
                        name=name,
                        race="انسان",
                        character_path=loc.location_id if loc else "loc_abyss_000",
                        age=20
                    )
                    session.add(hero)
                    await session.flush() 

                    # ج) ساخت رکورد استت‌ها
                    stats = CharacterStats(
                        character_id=new_character_uuid,
                        strength=int(npc.strength * rnd.uniform(0.9, 1.1)),
                        speed=int(npc.speed * rnd.uniform(0.9, 1.1)),
                        defense=int(npc.defense * rnd.uniform(0.9, 1.1)),
                        intelligence=int(npc.intelligence * rnd.uniform(0.9, 1.1)),
                        luck=max(1, int(npc.luck * rnd.uniform(0.9, 1.1))),
                        energy=npc.energy,
                        mana=int(npc.mana * rnd.uniform(0.9, 1.1)),
                        hp=int(npc.hp * rnd.uniform(0.9, 1.1)),
                        exp=0,
                        level=1,
                        hunting_points=0,
                        gold=100 # مقدار اولیه ثابت یا رندوم
                    )
                    session.add(stats)
                    await session.flush() 

                    # ذخیره نهایی در دیتابیس
                    await session.commit()
                    player_id_in_db = new_player_uuid

                except Exception as e:
                    await session.rollback()
                    print(f"Error creating profile with UUID: {e}")
                    return

        # ۳. ارسال به خروجی
        await bus.emit(
            "GENERATE_START",
            player_id=player_id_in_db,
            chat_id=chat_id,
            username=username,
            character=hero,
            stats=stats,
            message=message,
            loc=loc.name
        )

    async def check_exists(self,chat_id):

        async with get_db() as session:

            return await session.scalar(
                select(Player.player_id)
                .where(Player.telegram_id==chat_id)
            )


cmd=Command()

bus.listen("COMMAND",cmd.receive)
