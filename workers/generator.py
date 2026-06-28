from .bus import bus
from database.model import *
from ai import *
import random
from combat_cache import get_combat_session, create_combat_session

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

    def _describe_combat_stance(self, name, option):
        choices = {
            "Hard Fight": [
                f"{name} بی‌پروا جلو کشید و همه‌چیز را روی یک ضربه‌ی سنگین گذاشت",
                f"{name} با خشونت حمله را آغاز کرد و دفاع خود را کمی باز گذاشت",
                f"{name} با تمام نیرو فشار آورد و قصد داشت مبارزه را سریع تمام کند",
            ],
            "Normal Fight": [
                f"{name} با ریتمی کنترل‌شده وارد درگیری شد",
                f"{name} فاصله را سنجید و حمله‌ای متعادل را آماده کرد",
                f"{name} بدون عجله، اما با تمرکز کامل پیشروی کرد",
            ],
            "Dodge": [
                f"{name} سبک‌پا حرکت کرد و بیشتر روی جاخالی دادن تمرکز داشت",
                f"{name} فاصله را حفظ کرد و منتظر اشتباه حریف ماند",
                f"{name} مدام زاویه عوض کرد تا هدف سخت‌تری باشد",
            ],
            "Defend": [
                f"{name} گارد گرفت و آماده شد ضربه‌ی حریف را مهار کند",
                f"{name} موضع دفاعی گرفت و به‌دنبال فرصت ضدحمله ماند",
                f"{name} عقب ننشست، اما اولویت را به حفظ جان و کنترل ضربه داد",
            ],
        }

        return random.choice(choices.get(option, [f"{name} آماده‌ی ادامه‌ی مبارزه شد"]))
    def _describe_attack_result(self, attacker_name, defender_name, attack_data, attacker_option=None, defender_option=None):
        damage = round(attack_data.get("hp_damage", 0), 1)

        if not attack_data.get("hit"):
            if defender_option == "Dodge":
                return random.choice([
                    f"{attacker_name} برای ضربه زدن جلو آمد، اما {defender_name} با یک جابه‌جایی سریع از مسیر حمله بیرون رفت.",
                    f"ضربه‌ی {attacker_name} به هدف نرسید؛ {defender_name} دقیقاً در لحظه‌ی مناسب جاخالی داد.",
                    f"{attacker_name} فرصت حمله پیدا کرد، اما حرکت سریع {defender_name} ضربه را بی‌اثر کرد.",
                ])

            if defender_option == "Defend":
                return random.choice([
                    f"{attacker_name} حمله کرد، اما گارد محکم {defender_name} مسیر ضربه را بست.",
                    f"ضربه‌ی {attacker_name} به دفاع {defender_name} برخورد کرد و اثر جدی نگذاشت.",
                    f"{defender_name} با تمرکز بالا ضربه‌ی {attacker_name} را خواند و آن را خنثی کرد.",
                ])

            return random.choice([
                f"{attacker_name} حمله کرد، اما ضربه‌اش از کنار {defender_name} گذشت.",
                f"{attacker_name} ضربه زد، اما دقت کافی نداشت و حمله بی‌نتیجه ماند.",
                f"{defender_name} در آخرین لحظه از مسیر حمله‌ی {attacker_name} خارج شد.",
            ])

        parts = []

        if attack_data.get("critical"):
            parts.append(random.choice([
                f"ضربه‌ی {attacker_name} سنگین و دقیق فرود آمد",
                f"{attacker_name} نقطه‌ی ضعف {defender_name} را پیدا کرد",
                f"حمله‌ی {attacker_name} با شدت زیادی به هدف خورد",
            ]))
        else:
            parts.append(random.choice([
                f"حمله‌ی {attacker_name} به {defender_name} برخورد کرد",
                f"{attacker_name} توانست ضربه‌اش را به هدف برساند",
                f"ضربه‌ی {attacker_name} از دفاع {defender_name} عبور کرد",
            ]))

        if attack_data.get("blocked"):
            parts.append(random.choice([
                f"اما {defender_name} بخشی از آسیب را مهار کرد",
                f"ولی گارد {defender_name} شدت ضربه را کاهش داد",
                f"با این حال، دفاع {defender_name} نگذاشت ضربه کامل بنشیند",
            ]))

        parts.append(f"{damage} آسیب وارد شد")

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

        hero_stance_text = self._describe_combat_stance(hero, hero_option)
        enemy_stance_text = self._describe_combat_stance(enemy, enemy_option)

        hero_result_text = self._describe_attack_result(
            hero,
            enemy,
            hero_attack,
            attacker_option=hero_option,
            defender_option=enemy_option,
        )

        enemy_result_text = self._describe_attack_result(
            enemy,
            hero,
            enemy_attack,
            attacker_option=enemy_option,
            defender_option=hero_option,
        )


        status_text = (
            "وضعیت پس از این تبادل:\n"
            f"{hero}: ❤️ {round(hero_stats.hp, 1)} | ⚡ {round(hero_stats.energy, 1)} | 🔮 {round(hero_stats.mana, 1)}\n"
            f"{enemy}: ❤️ {round(enemy_stats.hp, 1)} | ⚡ {round(enemy_stats.energy, 1)} | 🔮 {round(enemy_stats.mana, 1)}"
        )


        text = (
            f"{intro}\n\n"
            f"{hero_stance_text}.\n"
            f"{enemy_stance_text}.\n\n"
            f"{hero_result_text}\n"
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
        enemy_name=payload.get("enemy_name")
        you_win = payload.get("you_win")
        level_up=payload.get("level_up")
        args=payload.get("args")
        message=payload.get("message")
        chat_id=payload.get("chat_id")
        if xp <= 0 and not level_up:
            text = "⚔️ از این مبارزه تجربه خاصی به دست نیاوردی."
        elif xp > 0 and not level_up:
            text = f"""{f"شما پیروز شدید و {enemy_name} را شکست دادید!" if you_win else f"شما بازنده شدید و از {enemy_name} شکست خوردید"}
    🏆 دستاورد مبارزه

    تو از این نبرد
    ✨ {xp} تجربه به دست آوردی.

    منابع باقیمانده:
    سلامتی: {stats.hp}
    انرژی: {stats.energy}
    مانا: {stats.mana}
    """
        elif xp == 0 and level_up:
            text = f"""{f"شما پیروز شدید و {enemy_name} را شکست دادید!" if you_win else f"شما بازنده شدید و از {enemy_name} شکست خوردید"}
    🏆 ارتقای سطح

    شما به سطح {args["level"]} رسیدید

    تمام خصیصه های آماری اصلی شما ارتقا یافتند:
    قدرت: {stats.strength} -> {args["strength"]}
    سرعت: {stats.speed} -> {args["speed"]}
    استقامت: {stats.defense} -> {args["defense"]}
    هوش: {stats.intelligence} -> {args["intelligence"]}
    شانس: {stats.luck} -> {args["luck"]}
    سلامتی: {stats.hp} -> {args["hp"]}
    انرژی: {stats.energy} -> {args["energy"]}
    مانا: {stats.mana} -> {args["mana"]}
    """
        buttons = [
            {
                "text": "خانه",
                "callback": "home"
            }
        ]

        await bus.emit(
            "SEND",
            text=text,
            chat_id=chat_id,
            message=message,
            buttons=buttons
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
            buttons.append({"text": "💪", "callback": f"upgrade:strength-{costs['strength']}"})

        if costs.get("speed"):
            text += f"""
🏃 سرعت: {stats.speed}  | هزینه ارتقا: {costs["speed"]} XP"""
            buttons.append({"text": "🏃", "callback": f"upgrade:speed-{costs['speed']}"})

        if costs.get("defense"):
            text += f"""
🛡 استقامت: {stats.defense}   | هزینه ارتقا: {costs["defense"]} XP"""
            buttons.append({"text": "🛡", "callback": f"upgrade:defense-{costs['defense']}"})

        if costs.get("intelligence"):
            text += f"""
🧠 هوش: {stats.intelligence}    | هزینه ارتقا: {costs["intelligence"]} XP"""
            buttons.append({"text": "🧠", "callback": f"upgrade:intelligence-{costs['intelligence']}"})

        if costs.get("luck"):
            text += f"""
🍀 شانس: {stats.luck}    | هزینه ارتقا: {costs["luck"]} XP"""
            buttons.append({"text": "🍀", "callback": f"upgrade:luck-{costs['luck']}"})

        if costs.get("hp"):
            text += f"""
❤️ جان: {stats.luck}    | هزینه ارتقا: {costs["luck"]} XP"""
            buttons.append({"text": "❤️", "callback": f"upgrade:hp-{costs['hp']}"})
        if costs.get("energy"):
            text += f"""
⚡ انرژی: {stats.luck}    | هزینه ارتقا: {costs["energy"]} XP"""
            buttons.append({"text": "⚡", "callback": f"upgrade:energy-{costs['energy']}"})
        if costs.get("mana"):
            text += f"""
🔮 مانا: {stats.luck}    | هزینه ارتقا: {costs["mana"]} XP"""
            buttons.append({"text": "🔮", "callback": f"upgrade:mana-{costs['mana']}"})
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
        name=data.get("name")
        username=data.get("username")
        text = f"""✅ ارتقا با موفقیت انجام شد!

ویژگی «{stat_name}» با موفقیت افزایش یافت.
{price} XP از حساب شما کسر شد.
به پیشرفت ادامه بده!

{stat_name} فعلی:
{curr}
"""
        buttons = [
            {
                "text": "خانه",
                "callback": "home"
            }
        ]
        await bus.emit(
            "EDIT",
            player_id=chat_id,
            message_id=int(message),
            text=text,
            chat_id=chat_id,
            buttons=buttons
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
        buttons = [
            {
                "text": "خانه",
                "callback": "home"
            }
        ]
        await bus.emit(
            "SEND",
            player_id=chat_id,
            chat_id=chat_id,
            message=message,
            text=text,
            buttons=buttons
        )
        

    async def generate_fight_action(self, **data):
        enemy_id = data.get("enemy_id")
        message = data.get("message")
        enemy_type = data.get("enemy_type", "npc")
        enemy_count = data.get("enemy_count", 1)
        character_id = data.get("character_id")
        player_id = data.get("player_id")
        enemy_option = data.get("enemy_option")
        emy = data.get("emy")

        option_codes = {
            "Hard Fight": "hf",
            "Normal Fight": "nf",
            "Dodge": "dg",
            "Defend": "df",
        }

        action_labels = {
            "Hard Fight": "حمله سنگین",
            "Normal Fight": "حمله عادی",
            "Dodge": "جاخالی",
            "Defend": "دفاع",
        }

        enemy_name = getattr(emy, "name", "دشمن")

        enemy_option_texts = {
            "Hard Fight": [
                f"{enemy_name} نفسش را حبس می‌کند و نیرویی سنگین در بدنش جمع می‌شود.",
                f"{enemy_name} با خشونت قدمی جلو می‌گذارد؛ ضربه‌ی بعدی‌اش احتمالاً سنگین خواهد بود.",
                f"عضلات {enemy_name} منقبض می‌شود و نگاهش مستقیم روی نقطه‌ی ضعف شما قفل می‌کند.",
            ],
            "Normal Fight": [
                f"{enemy_name} با ریتمی ثابت به سمت شما حرکت می‌کند و آماده‌ی یک حمله‌ی مستقیم است.",
                f"{enemy_name} فاصله را کم می‌کند؛ نه شتاب‌زده، نه کند. یک حمله‌ی حساب‌شده در راه است.",
                f"{enemy_name} جای پایش را تنظیم می‌کند و برای درگیری نزدیک آماده می‌شود.",
            ],
            "Dodge": [
                f"{enemy_name} بدنش را سبک می‌کند و حرکات شما را با دقت زیر نظر می‌گیرد.",
                f"{enemy_name} کمی عقب می‌نشیند؛ انگار منتظر است شما اول حمله کنید.",
                f"نگاه {enemy_name} روی دست‌ها و شانه‌های شما می‌چرخد. احتمالاً آماده‌ی جاخالی دادن است.",
            ],
            "Defend": [
                f"{enemy_name} گاردش را بالا می‌آورد و وزنش را روی پای عقب می‌اندازد.",
                f"{enemy_name} حالت دفاعی می‌گیرد و مسیرهای حمله‌ی مستقیم را می‌بندد.",
                f"{enemy_name} فاصله را حفظ می‌کند و آماده است ضربه‌ی شما را جذب یا منحرف کند.",
            ],
        }

        if enemy_option not in option_codes:
            enemy_option = random.choice(list(option_codes.keys()))

        enemy_action_text = random.choice(enemy_option_texts[enemy_option])

        try:
            enemy_count_value = int(enemy_count)
        except (TypeError, ValueError):
            enemy_count_value = 1

        if enemy_count_value > 1:
            count_text = f"\nتعداد دشمنان درگیر: {enemy_count_value}"
        else:
            count_text = ""

        text = (
            f"{enemy_action_text}"
            f"{count_text}\n\n"
            "حرکت بعدی شما چیست؟\n\n"
            "1) اجرای حمله سنگین\n"
            "   ریسک بیشتر، آسیب بیشتر. اگر دشمن آماده‌ی جاخالی یا دفاع باشد، ممکن است به ضررتان تمام شود.\n\n"
            "2) اجرای حمله عادی\n"
            "   انتخابی متعادل برای حفظ فشار و کنترل جریان مبارزه.\n\n"
            "3) آماده‌ی جاخالی\n"
            "   مناسب وقتی حس می‌کنید ضربه‌ی سنگینی در راه است.\n\n"
            "4) گارد گرفتن\n"
            "   کاهش ریسک و آماده شدن برای تحمل یا خنثی کردن ضربه‌ی دشمن."
        )

        enemy_code = option_codes.get(enemy_option, "nf")

        session_payload = {
            "enemy_id": enemy_id,
            "enemy_option": enemy_option,
            "enemy_option_code": enemy_code,
            "enemy_type": enemy_type,
            "enemy_count": enemy_count_value,
            "character_id": character_id,
            "player_id": player_id,
            "owner_chat_id": player_id,
        }

        session_id = create_combat_session(session_payload)

        buttons = [
            {"text": "حمله سنگین", "callback": f"cb|{session_id}|hf"},
            {"text": "حمله عادی", "callback": f"cb|{session_id}|nf"},
            {"text": "جاخالی", "callback": f"cb|{session_id}|dg"},
            {"text": "دفاع", "callback": f"cb|{session_id}|df"},
        ]

        await bus.emit(
            "SEND",
            player_id=player_id,
            text=text,
            buttons=buttons,
            message=message,
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