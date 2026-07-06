from database.db_manager import get_db
from database.model import *
from sqlalchemy import select, func
from datetime import datetime
import uuid
from mtranslate import translate
from .bus import bus


class Command:

    # تنظیمات جوایز سیستم ارجاع
    REWARDS = {
        "upgrade_points": 1,         # امتیاز ارتقای عمومی
        "stat_points": 3,            # امتیاز ویژگی‌های آماری (Strength, Speed, ...)
        "referral_reward_points": 5  # امتیازهای ویژه معرف
    }

    async def receive(self, **data):
        chat_id = data["chat_id"]
        text = data["text"]
        username = data["username"]
        name = data.get("name")
        message = data.get("message")

        parts = text.strip().split(maxsplit=1)
        cmd = parts[0].lower()
        payload = parts[1].strip() if len(parts) > 1 else None

        match cmd:
            case "/start":
                name = translate(name, "fa")
                await self.start(chat_id, username, name, message, payload)

    def extract_referrer_id(self, payload: str | None):
        if not payload:
            return None

        if not payload.startswith("ref_"):
            return None

        try:
            return int(payload.removeprefix("ref_"))
        except ValueError:
            return None

    async def start(self, chat_id, username, name, message, payload=None):
        chat_id = int(chat_id)
        referrer_tg_id = self.extract_referrer_id(payload)

        # ۱. آیا بازیکن از قبل وجود دارد؟
        player_id_in_db = await self.check_exists(chat_id)

        if player_id_in_db:
            # بازیکن قبلاً ثبت‌نام کرده است
            async with get_db() as session:
                hero = await session.scalar(
                    select(Character).where(Character.player_id == player_id_in_db)
                )
                stats = await session.scalar(
                    select(CharacterStats).where(CharacterStats.character_id == hero.character_id)
                )
                loc = await session.scalar(
                    select(Location).where(Location.location_id == hero.character_path)
                )

        else:
            # ۲. ایجاد بازیکن جدید
            new_player_uuid = str(uuid.uuid4())
            new_character_uuid = str(uuid.uuid4())

            async with get_db() as session:
                try:
                    loc = await session.scalar(
                        select(Location).order_by(func.random()).limit(1)
                    )
                    
                    new_player = Player(
                        player_id=new_player_uuid,
                        telegram_id=chat_id,
                        username=username,
                        created_at=datetime.now(),
                        role="user",
                        is_banned=False
                    )
                    session.add(new_player)
                    await session.flush()

                    hero = Character(
                        character_id=new_character_uuid,
                        player_id=new_player_uuid,
                        created_at=datetime.now(),
                        is_alive=True,
                        name=name,
                        race="انسان",
                        character_path=loc.location_id if loc else "loc_abyss_000",
                        age=10
                    )
                    session.add(hero)
                    await session.flush()

                    # ایجاد استت اولیه کاربر جدید
                    stats = CharacterStats(
                        character_id=new_character_uuid,
                        strength=1,
                        speed=1,
                        defense=1,
                        intelligence=1,
                        luck=1,
                        energy=50,
                        mana=10,
                        hp=100,
                        exp=25,
                        level=1,
                        hunting_points=0,
                        gold=100,
                        base_energy=50,
                        base_mana=10,
                        base_hp=100
                    )
                    session.add(stats)
                    await session.flush()

                    # ۳. اعمال پاداش دعوت به معرف (در صورتی که شرایط برقرار باشد)
                    if referrer_tg_id and referrer_tg_id != chat_id:
                        await self.apply_referral_reward(
                            session=session,
                            referrer_tg_id=referrer_tg_id,
                            new_player_tg_id=chat_id
                        )

                    await session.commit()
                    player_id_in_db = new_player_uuid

                except Exception as e:
                    await session.rollback()
                    print(f"Error creating profile with UUID: {e}")
                    return

        # ۴. ارسال رویداد خوش‌آمدگویی و شروع بازی
        await bus.emit(
            "GENERATE_START",
            player_id=player_id_in_db,
            chat_id=chat_id,
            username=username,
            character=hero,
            stats=stats,
            message=message,
            loc=loc.name if loc else "نامشخص"
        )

    async def apply_referral_reward(self, session, referrer_tg_id: int, new_player_tg_id: int):
        """
        پاداش ارجاع را پردازش کرده و بر روی امتیازهای تعریف‌شده اعمال می‌کند.
        """
        if referrer_tg_id == new_player_tg_id:
            return

        referrer_player = await session.scalar(
            select(Player).where(Player.telegram_id == referrer_tg_id)
        )
        if not referrer_player:
            return

        referrer_hero = await session.scalar(
            select(Character).where(Character.player_id == referrer_player.player_id)
        )
        if not referrer_hero:
            return

        referrer_stats = await session.scalar(
            select(CharacterStats).where(CharacterStats.character_id == referrer_hero.character_id)
        )
        if not referrer_stats:
            return

        # اعمال جوایز امتیازی به صورت ایمن
        reward_details = []
        
        # ۱. امتیاز ارتقا (Upgrade Points)
        if hasattr(referrer_stats, "upgrade_points"):
            current_val = referrer_stats.upgrade_points or 0
            referrer_stats.upgrade_points = current_val + self.REWARDS["upgrade_points"]
            reward_details.append(f"🔹 <b>امتیاز ارتقا:</b> +{self.REWARDS['upgrade_points']}")

        # ۲. امتیاز ویژگی‌ها (Stat Points)
        if hasattr(referrer_stats, "stat_points"):
            current_val = referrer_stats.stat_points or 0
            referrer_stats.stat_points = current_val + self.REWARDS["stat_points"]
            reward_details.append(f"🔹 <b>امتیاز مشخصات (Stat):</b> +{self.REWARDS['stat_points']}")

        # ۳. امتیاز دعوت (Referral Points)
        if hasattr(referrer_stats, "referral_reward_points"):
            current_val = referrer_stats.referral_reward_points or 0
            referrer_stats.referral_reward_points = current_val + self.REWARDS["referral_reward_points"]
            reward_details.append(f"🔹 <b>نشان دعوت (Referral Points):</b> +{self.REWARDS['referral_reward_points']}")

        # اگر هیچ‌کدام از ستون‌ها در دیتابیس پیاده‌سازی نشده بودند، به عنوان فال‌بک EXP اضافه شود
        if not reward_details:
            referrer_stats.exp = (referrer_stats.exp or 0) + 50
            reward_details.append("🔹 <b>تجربه (XP):</b> +50")

        await session.flush()

        # ارسال پیام اطلاع‌رسانی به معرف به صورت قالب‌بندی شده و RPG
        reward_text = "\n".join(reward_details)
        try:
            await bus.emit(
                "SEND",
                player_id=referrer_tg_id,
                chat_id=referrer_tg_id,
                text=(
                    "📜 <b>پیمان دعوت با موفقیت بسته شد!</b>\n\n"
                    "قهرمان، یکی از یاران فراخوانده شده توسط شما قدم به این دنیا گذاشت. "
                    "به پاس این وفاداری، پاداش‌های زیر در صندوقچه توانایی‌های شما قرار گرفت:\n\n"
                    f"{reward_text}\n\n"
                    "اکنون می‌توانید از این امتیازها برای ارتقای قدرت یا ویژگی‌های خود استفاده کنید."
                ),
                parse_mode="HTML"
            )
        except Exception as e:
            print(f"Referral notification failed: {e}")

    async def check_exists(self, chat_id):
        async with get_db() as session:
            return await session.scalar(
                select(Player.player_id).where(Player.telegram_id == chat_id)
            )


cmd = Command()
bus.listen("COMMAND", cmd.receive)
