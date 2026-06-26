from .bus import bus
from database.model import *
from ai import *
import random


class Generator:

    def _describe_option(self, option):
        choices = {
            "Hard Fight": [
                "با خشونت و قدرت کامل یورش برد",
                "بی‌پروا حمله‌ای سنگین انجام داد",
                "با تمام توان ضربه زد",
            ],
            "Normal Fight": [
                "با تمرکز حمله‌ای متعادل انجام داد",
                "با ریتمی کنترل‌شده پیشروی کرد",
                "حمله‌ای حساب‌شده انجام داد",
            ],
            "Dodge": [
                "سبک‌پا حرکت کرد و آماده‌ی جاخالی بود",
                "با سرعت جابه‌جا شد و از درگیری مستقیم پرهیز کرد",
                "با احتیاط وارد حمله شد و مسیر ضربه را تغییر داد",
            ],
            "Defend": [
                "موضع دفاعی گرفت و به‌دنبال فرصت ماند",
                "سپر دفاعی خود را حفظ کرد و ضدحمله زد",
                "محافظه‌کارانه جلو آمد و ضربه‌ای کنترل‌شده وارد کرد",
            ],
        }
        return random.choice(choices.get(option, ["حرکت کرد"]))

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
    def _describe_attack_result(self, attacker_name, defender_name, attack_data):
        if not attack_data["hit"]:
            return f"{attacker_name} حمله کرد اما {defender_name} به‌موقع جاخالی داد."

        parts = []

        if attack_data.get("critical"):
            parts.append(f"ضربه‌ی {attacker_name} به شکل بحرانی فرود آمد")
        else:
            parts.append(f"حمله‌ی {attacker_name} به هدف برخورد کرد")

        if attack_data.get("blocked"):
            parts.append(f"اما {defender_name} بخش زیادی از آن را مهار کرد")

        damage = round(attack_data.get("hp_damage", 0), 1)
        parts.append(f"و {damage} آسیب وارد شد")

        return "، ".join(parts) + "."



    async def generate_combat_story(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")
        details = data.get("details") or {}
        location = data.get("location")
        hero_stats = data.get("hero_stats")
        enemy_stats = data.get("enemy_stats")
        hero = data.get("hro")
        enemy = data.get("emy")
        count = data.get("enemy_count", 1)

        options = details.get("options", {})
        attacks = details.get("attacks", {})

        hero_option = options.get("hero", "Normal Fight")
        enemy_option = options.get("enemy", "Normal Fight")

        hero_attack = attacks.get("hero", {})
        enemy_attack = attacks.get("enemy", {})

        intro_parts = []
        if location:
            intro_parts.append(f"در {location}")
        intro_parts.append(f"{hero} با {enemy}")
        if count and count > 1:
            intro_parts[-1] += f" x{count}"
        intro_parts.append("رو‌به‌رو شد")

        intro = " ".join(intro_parts) + "."

        hero_action_text = self._describe_option(hero_option)
        enemy_action_text = self._describe_option(enemy_option)

        hero_result_text = self._describe_attack_result(hero, enemy, hero_attack)
        enemy_result_text = self._describe_attack_result(enemy, hero, enemy_attack)

        status_text = (
            f"وضعیت فعلی — "
            f"{hero}: HP={round(hero_stats.hp, 1)} | Energy={round(hero_stats.energy, 1)} | Mana={round(hero_stats.mana, 1)}\n"
            f"{enemy}: HP={round(enemy_stats.hp, 1)} | Energy={round(enemy_stats.energy, 1)} | Mana={round(enemy_stats.mana, 1)}"
        )

        text = (
            f"{intro}\n\n"
            f"{hero} {hero_action_text}.\n"
            f"{hero_result_text}\n\n"
            f"{enemy} {enemy_action_text}.\n"
            f"{enemy_result_text}\n\n"
            f"{status_text}"
        )

        sent_message = await bus.emit(
            "SEND",
            player_id=chat_id,
            chat_id=chat_id,
            message=message,
            text=text
        )

        return sent_message


        

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

    async def generate_fight_action(self, **data):
        enemy_id = data.get("enemy_id")
        message = data.get("message")
        chat_id = data.get("chat_id") or getattr(player, "telegram_id", None)
        enemy_type = data.get("enemy_type", "npc")
        enemy_count = data.get("enemy_count", 1)
        character_id= data.get("character_id")
        player_id = data.get("player_id")
        enemy_option=data.get("enemy_option")
        character_option=data.get("character_option")
        emy=data.get("emy")

        text = ""

        options = [
            "Hard Fight",
            "Normal Fight",
            "Dodge",
            "Defend"
        ]
        if enemy_option == options[0]:
            text += f"{emy.name} دارد یک فرم خاص به خود میگیرد چه میکنید؟"
        elif enemy_option == options[1]:
            text += f"{emy.name}دارد فاصله خودش را با شما کم می کند، چه میکنید؟"
        elif enemy_option == options[2]:
            text += f"{emy.name} حرکات شما را زیر نظر گرفته است، چه میکنید؟"
        elif enemy_option == options[3]:
            text += f"{emy.name} فاصله خودش را دارد با شما زیاد میکند، چه میکنید؟"


        text+="""
1) اجرای حمله سنگین
2) اجرای حملات عادی
3) آماده برای جاخالیی داردن
4) گارد گرفتن
"""
        buttons = [
            {
                "text": "1",
                "callback" : f"combat:{enemy_id}:{enemy_option}:{enemy_type}:{enemy_count}|{character_id}:{options[0]}"
            },
            {
                "text": "2",
                "callback" : f"combat:{enemy_id}:{enemy_option}:{enemy_type}:{enemy_count}|{character_id}:{options[1]}"
            },
            {
                "text": "3",
                "callback" : f"combat:{enemy_id}:{enemy_option}:{enemy_type}:{enemy_count}|{character_id}:{options[2]}"
            },
            {
                "text": "4",
                "callback" : f"combat:{enemy_id}:{enemy_option}:{enemy_type}:{enemy_count}|{character_id}:{options[3]}"
            },
        ]

        await bus.emit(
            "SEND",
            player_id=player_id,
            text=text,
            buttons=buttons,
            message=message
        )



gen = Generator()

bus.listen("GENERATE_START", gen.generate_start)
bus.listen("GENERATE_COMBAT_STORY", gen.generate_combat_story)
bus.listen("GENERATE_COMBAT_REWARDS", gen.generate_combat_rewards)
bus.listen("SHOW_UPGADE_COSTS", gen.generate_upgrade_choices)
bus.listen("GENERATE_UPDATE", gen.generate_update)
bus.listen("GENERATE_MOVE_CHOICES", gen.generate_move_choices)
bus.listen("GENERATE_WELCOME_LOCATION", gen.generate_welcome_location)
bus.listen("GENERATE_CHOOSE_ACTION", gen.generate_fight_action)