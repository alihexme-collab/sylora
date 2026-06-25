from .bus import bus
from database.model import *
from ai import *
import asyncio, time

class Generator:
    async def generate_start(self, **data):

        chat_id = data.get("chat_id")
        character = data.get("character")
        stats = data.get("stats")
        message = data.get("message")
        loc_name=data.get("loc")
        stats_text = (
            f"نام:   {character.name:<10} | سن: {character.age}\n"
            f"سطح:   {stats.level:<10} | پول: {stats.gold}\n"
            f"قدرت:  {stats.strength:<10} | سرعت: {stats.speed}\n"
            f"استقامت: {stats.defense:<10} | جان: {stats.hp}\n"
            f"هوش:   {stats.intelligence:<10} | شانس: {stats.luck}\n"
            f"انرژی:  {stats.energy:<10} | مانا: {stats.mana}\n"
            f"امتیاز شکار: {stats.hunting_points:<10} | تجربه: {stats.exp}"
        )

        text = (
            f"درود {character.name} جوان!\n"
            f"دوست داری چیکار کنی؟ میخوای یک رقیب برات پیدا کنم تا باهاش مبارزه کنی؟\n\n"
            f"<b>اطلاعات فعلی شما:</b>\n"
            f"<code>{stats_text}</code>\n"
            f"<b>مکان فعلی شما: {loc_name}</b>"
        )

        buttons = ["نبرد", "ارتقا", "حرکت", "استراحت"]
        print("GENERATE_START reached")
        print("message =", data.get("message"))

        await bus.emit(
            "SEND",
            player_id=chat_id,
            chat_id=chat_id,
            text=text,
            buttons=buttons,
            parse_mode="HTML",
            message=message
        )

    async def generate_combat_story(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")
        winner = data.get("winner")
        loser = data.get("loser")
        details = data.get("details")
        location = data.get("location")
        hero_stats=data.get("hero_stats")
        enemy_stats=data.get("enemy_stats")
        hero = data.get("hro")
        enemy = data.get("emy")
        count = data.get("enemy_count")
        sent_message = await bus.emit(
            "SEND",
            player_id=chat_id,
            chat_id=chat_id,
            message=message,
            text="نبرد آغاز شد..."
        )

        full_text = ""
        last_edit_time = 0
        async for part in narrate(
            "combat",
            winner=winner,
            loser=loser,
            data=details,
            location=location,
            hero_stats=hero_stats,
            enemy_stats=enemy_stats,
            hero=hero,
            enemy=enemy,
            enemy_count=count
        ):
            full_text += part

            now = time.monotonic()

            if now - last_edit_time >= 0.8:
                await bus.emit(
                    "EDIT",
                    player_id=chat_id,
                    chat_id=chat_id,
                    sent_message=sent_message,
                    text=full_text
                )

                last_edit_time = now

        await bus.emit(
            "EDIT",
            player_id=chat_id,
            chat_id=chat_id,
            sent_message=sent_message,
            text=full_text
        )

    async def generate_combat_rewards(self, **payload):
        xp = payload.get("xp", 0)
        player = payload.get("player")
        stats: CharacterStats = payload.get("stats")
        if xp <= 0:
            text = "⚔️ از این مبارزه تجربه خاصی به دست نیاوردی."
        else:
            text = f"""
    🏆 دستاورد مبارزه

    تو از این نبرد
    ✨ {xp} تجربه به دست آوردی.

    منابع باقیمانده:
    سلامتی: {stats.hp}
    انرژی: {stats.energy}
    مانا: {stats.mana}
    """

        await bus.emit(
            "SEND",
            text=text,
            chat_id=payload.get("chat_id"),
            message=payload.get("message")
        )

    async def generate_upgrade_choices(self, **data):
        chat_id=data.get("chat_id")
        message=data.get("message")
        costs=data.get("costs")
        stats: CharacterStats=data.get("stats")
        total_stats=data.get("total_stats")
        reqire_level=data.get("reqire_level")
        buttons = []
        text = f"""
📊 ارتقای آمار

تجربه فعلی: {stats.exp}
سطح: {stats.level}
مجموع آمار: {total_stats} / {reqire_level}
"""
        if costs.get("strength"):
            text += f"""
💪 قدرت: {stats.strength}  | هزینه ارتقا: {costs["strength"]} XP"""
            buttons.append({"text": "💪", "callback": f"upgrade:strength-{costs["strength"]}"})

        if costs.get("speed"):
            text += f"""
🏃 سرعت: {stats.speed}  | هزینه ارتقا: {costs["speed"]} XP"""
            buttons.append({"text": "🏃", "callback": f"upgrade:speed-{costs["speed"]}"})

        if costs.get("defense"):
            text += f"""
🛡 استقامت: {stats.defense}   | هزینه ارتقا: {costs["defense"]} XP"""
            buttons.append({"text": "🛡", "callback": f"upgrade:defense-{costs["defense"]}"})

        if costs.get("intelligence"):
            text += f"""
🧠 هوش: {stats.intelligence}    | هزینه ارتقا: {costs["intelligence"]} XP"""
            buttons.append({"text": "🧠", "callback": f"upgrade:intelligence-{costs["intelligence"]}"})

        if costs.get("luck"):
            text += f"""
🍀 شانس: {stats.luck}    | هزینه ارتقا: {costs["luck"]} XP"""
            buttons.append({"text": "🍀", "callback": f"upgrade:luck-{costs["luck"]}"})
        print("SEND:::")
        sent = await bus.emit(
            "SEND",
            text=text,
            buttons=buttons,
            message=message,
            player_id=chat_id
        )
        for btn in buttons:
            btn["callback"] += f"?••?/{sent.message_id}"

        await bus.emit(
            "EDIT",
            text=text,
            buttons=buttons,
            sent_message=sent,
            player_id=chat_id
        )

    async def generate_update(self, **data):
        chat_id=data.get("chat_id")
        message=data.get("message")
        stat_name=data.get("stat_name").replace("strength", "قدرت").replace("speed", "سرعت").replace("defense", "استقامت").replace("intelligence", "هوش").replace("luck", "شانس")
        price=data.get("price")
        curr=data.get("curr")

        text = f"""✅ ارتقا با موفقیت انجام شد!

ویژگی «{stat_name}» با موفقیت افزایش یافت.
{price} XP از حساب شما کسر شد.
به پیشرفت ادامه بده!

{stat_name} فعلی:
{curr}
"""
        await bus.emit(
            "EDIT",
            player_id=chat_id,
            message_id=int(message),
            text=text,
            chat_id=chat_id
        )
        
    async def generate_move_choices(self, **data):
        chat_id=data.get("chat_id")
        message=data.get("message")
        buttons=data.get("buttons")

        text="مقصد خود را انتخاب کنید"
        await bus.emit(
            "SEND",
            player_id=chat_id,
            chat_id=chat_id,
            text=text,
            buttons=buttons,
            parse_mode="HTML",
            message=message
        )

    async def generate_welcome_location(self, **data):
        chat_id=data.get("chat_id")
        message=data.get("message")
        loc: Location=data.get("loc")
        char=data.get("char")
        text=f"""
خوش آمدید {char.name} به {loc.name}

سطح خطر: {loc.danger_level}

توضیحات این منطقه:
{loc.description}
"""
        await bus.emit(
            "SEND",
            player_id=chat_id,
            chat_id=chat_id,
            message=message,
            text=text
        )



gen = Generator()

bus.listen("GENERATE_START", gen.generate_start)
bus.listen("GENERATE_COMBAT_STORY", gen.generate_combat_story)
bus.listen("GENERATE_COMBAT_REWARDS", gen.generate_combat_rewards)
bus.listen("SHOW_UPGADE_COSTS", gen.generate_upgrade_choices)
bus.listen("GENERATE_UPDATE", gen.generate_update)
bus.listen("GENERATE_MOVE_CHOICES", gen.generate_move_choices)
bus.listen("GENERATE_WELCOME_LOCATION", gen.generate_welcome_location)