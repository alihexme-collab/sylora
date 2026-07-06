from .bus import bus
from database.model import *
from ai import *
import random
from combat_cache import get_combat_session, create_combat_session
from html import escape


class Generator:
    # -----------------------------
    # Utility Methods
    # -----------------------------

    def _num(self, value, default=0):
        try:
            if value is None:
                return default
            if isinstance(value, float):
                return round(value, 1)
            return value
        except Exception:
            return default

    def _progress_exp(self, stats):
        required_exp = 100 + (stats.level - 1) * 40
        return f"{stats.exp}/{required_exp}"

    def _stat_line(self, icon, title, value):
        return f"{icon} {title:<12}: {value}"

    # -----------------------------
    # Start / Home Screen
    # -----------------------------

    async def generate_start(self, **data):
        chat_id = data.get("chat_id")
        character = data.get("character")
        stats = data.get("stats")
        message = data.get("message")
        loc_name = data.get("loc") or "نامشخص"

        char_name = escape(str(character.name))
        loc_name = escape(str(loc_name))

        stats_text = (
            f"نام          : {character.name}\n"
            f"سن           : {character.age}\n"
            f"سطح          : {stats.level}\n"
            f"تجربه        : {self._progress_exp(stats)}\n"
            f"دارایی       : {stats.gold} سکه\n"
            f"━━━━━━━━━━━━━━━━━━━━\n"
            f"قدرت         : {stats.strength}\n"
            f"سرعت         : {stats.speed}\n"
            f"استقامت      : {stats.defense}\n"
            f"هوش          : {stats.intelligence}\n"
            f"شانس         : {stats.luck}\n"
            f"━━━━━━━━━━━━━━━━━━━━\n"
            f"جان          : {self._num(stats.hp)}\n"
            f"انرژی        : {self._num(stats.energy)}\n"
            f"مانا         : {self._num(stats.mana)}\n"
            f"امتیاز شکار  : {stats.hunting_points}"
        )

        text = (
            f"⚜️ <b>بازگشت به مسیر ماجراجویی</b>\n\n"
            f"درود بر تو، <b>{char_name}</b>.\n"
            f"جهان هنوز آرام نگرفته و سرنوشتت در انتظار تصمیم بعدی توست.\n\n"
            f"📍 <b>مکان فعلی:</b> {loc_name}\n\n"
            f"📜 <b>وضعیت فعلی شخصیت</b>\n"
            f"<code>{stats_text}</code>\n\n"
            f"اکنون چه تصمیمی می‌گیری؟"
        )

        buttons = ["نبرد", "ارتقا", "حرکت", "استراحت", "ثبت نظر"]

        if chat_id == 7606015504:
            buttons.append("نمایش نظرات")

        await bus.emit(
            "SEND",
            player_id=chat_id,
            chat_id=chat_id,
            text=text,
            buttons=buttons,
            parse_mode="HTML",
            message=message
        )

    # -----------------------------
    # Combat Text Generators
    # -----------------------------

    def _describe_combat_stance(self, name, option):
        choices = {
            "Hard Fight": [
                f"{name} بی‌درنگ پیشروی می‌کند؛ تمام نیرو در یک ضربه‌ی سنگین جمع شده است.",
                f"{name} با خشونتی کنترل‌نشده به میدان فشار می‌آورد و دفاع خود را برای قدرت بیشتر قربانی می‌کند.",
                f"{name} همه چیز را روی یک حمله‌ی کوبنده می‌گذارد؛ ضربه‌ای که اگر بنشیند، جریان نبرد را تغییر می‌دهد.",
                f"{name} با گامی سنگین وارد محدوده‌ی درگیری می‌شود؛ نیت او پایان دادن سریع به مبارزه است.",
            ],
            "Normal Fight": [
                f"{name} با تمرکزی آرام و حساب‌شده موضع می‌گیرد؛ نه شتاب‌زده، نه منفعل.",
                f"{name} فاصله را می‌سنجد و با ریتمی متعادل آماده‌ی حمله می‌شود.",
                f"{name} با کنترل کامل پیشروی می‌کند و به‌دنبال فرصتی مطمئن برای ضربه زدن است.",
                f"{name} حرکات حریف را می‌خواند و حمله‌ای متوازن را در ذهن آماده می‌کند.",
            ],
            "Dodge": [
                f"{name} سبک‌پا جابه‌جا می‌شود و تمام تمرکز خود را روی پیش‌بینی مسیر حمله می‌گذارد.",
                f"{name} فاصله را حفظ می‌کند؛ انگار منتظر کوچک‌ترین اشتباه حریف است.",
                f"{name} زاویه‌ی بدنش را تغییر می‌دهد تا هدفی سخت‌تر و لغزنده‌تر باشد.",
                f"{name} با چشمانی دقیق میدان را می‌خواند و آماده است در لحظه‌ی مناسب از مسیر ضربه خارج شود.",
            ],
            "Defend": [
                f"{name} گارد خود را محکم می‌کند و آماده‌ی جذب یا منحرف کردن ضربه می‌شود.",
                f"{name} موضعی دفاعی می‌گیرد؛ صبور، حساب‌گر و آماده برای ضدحمله.",
                f"{name} عقب نمی‌نشیند، اما اولویت را به حفظ جان و کنترل شدت ضربه می‌دهد.",
                f"{name} پاهایش را ثابت می‌کند و دفاعی منظم در برابر حمله‌ی احتمالی می‌سازد.",
            ],
        }

        return random.choice(
            choices.get(option, [f"{name} خود را برای ادامه‌ی نبرد آماده می‌کند."])
        )

    def _describe_attack_result(
        self,
        attacker_name,
        defender_name,
        attack_data,
        attacker_option=None,
        defender_option=None
    ):
        damage = round(attack_data.get("hp_damage", 0), 1)

        if not attack_data.get("hit"):
            if defender_option == "Dodge":
                return random.choice([
                    f"{attacker_name} برای ضربه پیش می‌آید، اما {defender_name} با جابه‌جایی‌ای دقیق از مسیر حمله خارج می‌شود.",
                    f"ضربه‌ی {attacker_name} هوا را می‌شکافد؛ {defender_name} درست در آخرین لحظه جاخالی می‌دهد.",
                    f"{attacker_name} فرصت حمله را پیدا می‌کند، اما واکنش سریع {defender_name} نتیجه را بی‌اثر می‌کند.",
                    f"{defender_name} حرکت {attacker_name} را زودتر می‌خواند و پیش از فرود ضربه، از محدوده‌ی خطر بیرون می‌رود.",
                ])

            if defender_option == "Defend":
                return random.choice([
                    f"{attacker_name} حمله می‌کند، اما گارد محکم {defender_name} مسیر ضربه را می‌بندد.",
                    f"ضربه‌ی {attacker_name} به دفاع {defender_name} برخورد می‌کند و اثر جدی بر جا نمی‌گذارد.",
                    f"{defender_name} با تمرکز بالا حمله‌ی {attacker_name} را می‌خواند و آن را خنثی می‌کند.",
                    f"حمله‌ی {attacker_name} با سد دفاعی {defender_name} روبه‌رو می‌شود و پیش از اثرگذاری متوقف می‌گردد.",
                ])

            return random.choice([
                f"{attacker_name} حمله می‌کند، اما ضربه‌اش از کنار {defender_name} عبور می‌کند.",
                f"{attacker_name} ضربه می‌زند، ولی دقت کافی ندارد و حمله بی‌نتیجه می‌ماند.",
                f"{defender_name} در آخرین لحظه از مسیر حمله‌ی {attacker_name} خارج می‌شود.",
                f"حمله‌ی {attacker_name} آغاز خوبی دارد، اما در لحظه‌ی نهایی از هدف منحرف می‌شود.",
            ])

        parts = []

        if attack_data.get("critical"):
            parts.append(random.choice([
                f"ضربه‌ی {attacker_name} با دقتی مرگبار فرود می‌آید",
                f"{attacker_name} نقطه‌ی ضعف {defender_name} را پیدا می‌کند",
                f"حمله‌ی {attacker_name} با شدتی سهمگین به هدف می‌نشیند",
                f"{attacker_name} ضربه‌ای تعیین‌کننده وارد می‌کند که تعادل {defender_name} را بر هم می‌زند",
            ]))
        else:
            parts.append(random.choice([
                f"حمله‌ی {attacker_name} به {defender_name} برخورد می‌کند",
                f"{attacker_name} موفق می‌شود ضربه‌اش را به هدف برساند",
                f"ضربه‌ی {attacker_name} از دفاع {defender_name} عبور می‌کند",
                f"{attacker_name} با حرکتی حساب‌شده به {defender_name} آسیب می‌زند",
            ]))

        if attack_data.get("blocked"):
            parts.append(random.choice([
                f"اما {defender_name} بخشی از آسیب را مهار می‌کند",
                f"ولی گارد {defender_name} شدت ضربه را کاهش می‌دهد",
                f"با این حال، دفاع {defender_name} مانع از اثر کامل ضربه می‌شود",
                f"اما آمادگی دفاعی {defender_name} اجازه نمی‌دهد تمام قدرت ضربه وارد شود",
            ]))

        parts.append(f"میزان آسیب: {damage}")

        return "؛ ".join(parts) + "."

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

        location_text = f"در حوالی {location}، " if location else ""

        enemy_count_text = ""
        try:
            if int(count) > 1:
                enemy_count_text = f" گروهی {count} نفره از"
        except Exception:
            pass

        intro = (
            f"⚔️ <b>گزارش نبرد</b>\n\n"
            f"{location_text}{hero} با{enemy_count_text} {enemy} روبه‌رو می‌شود.\n"
            f"هوا سنگین است و هر تصمیم می‌تواند مسیر مبارزه را تغییر دهد."
        )

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
            f"📊 <b>وضعیت پس از این تبادل</b>\n"
            f"🧍 {hero}\n"
            f"❤️ جان: {round(hero_stats.hp, 1)} | ⚡ انرژی: {round(hero_stats.energy, 1)} | 🔮 مانا: {round(hero_stats.mana, 1)}\n\n"
            f"👹 {enemy}\n"
            f"❤️ جان: {round(enemy_stats.hp, 1)} | ⚡ انرژی: {round(enemy_stats.energy, 1)} | 🔮 مانا: {round(enemy_stats.mana, 1)}"
        )

        text = (
            f"{intro}\n\n"
            f"🧭 <b>آرایش مبارزه</b>\n"
            f"• {hero_stance_text}\n"
            f"• {enemy_stance_text}\n\n"
            f"💥 <b>نتیجه تبادل ضربات</b>\n"
            f"• {hero_result_text}\n"
            f"• {enemy_result_text}\n\n"
            f"{status_text}"
        )

        sent_message = await bus.emit(
            "SEND",
            player_id=chat_id,
            chat_id=chat_id,
            message=message,
            text=text,
            parse_mode="HTML"
        )

        return sent_message

    # -----------------------------
    # Combat Rewards
    # -----------------------------

    async def generate_combat_rewards(self, **payload):
        xp = payload.get("xp", 0)
        player = payload.get("player")
        stats: CharacterStats = payload.get("stats")
        enemy_name = payload.get("enemy_name") or "دشمن"
        you_win = payload.get("you_win")
        level_up = payload.get("level_up")
        args = payload.get("args") or {}
        message = payload.get("message")
        chat_id = payload.get("chat_id")

        result_title = (
            f"🏆 پیروزی در نبرد"
            if you_win
            else f"💀 شکست در نبرد"
        )

        result_desc = (
            f"تو موفق شدی {enemy_name} را شکست دهی."
            if you_win
            else f"{enemy_name} این بار بر تو غلبه کرد؛ اما هر شکست می‌تواند شروعی برای قدرت بیشتر باشد."
        )

        if xp <= 0 and not level_up:
            text = (
                f"{result_title}\n\n"
                f"{result_desc}\n\n"
                f"⚔️ از این مبارزه تجربه‌ی قابل توجهی به دست نیامد.\n\n"
                f"📌 وضعیت فعلی:\n"
                f"❤️ جان: {int(stats.hp)}\n"
                f"⚡ انرژی: {int(stats.energy)}\n"
                f"🔮 مانا: {int(stats.mana)}"
            )

        elif xp > 0 and not level_up:
            text = (
                f"{result_title}\n\n"
                f"{result_desc}\n\n"
                f"✨ پاداش نبرد:\n"
                f"تو از این مبارزه <b>{xp}</b> تجربه به دست آوردی.\n\n"
                f"📌 منابع باقی‌مانده:\n"
                f"❤️ جان: {int(stats.hp)}\n"
                f"⚡ انرژی: {int(stats.energy)}\n"
                f"🔮 مانا: {int(stats.mana)}"
            )

        elif level_up:
            text = (
                f"{result_title}\n\n"
                f"{result_desc}\n\n"
                f"🌟 <b>ارتقای سطح!</b>\n"
                f"تو اکنون به سطح <b>{args.get('level')}</b> رسیده‌ای.\n\n"
                f"📈 آمار اصلی تو ارتقا یافت:\n"
                f"💪 قدرت: {stats.strength} → {args.get('strength')}\n"
                f"🏃 سرعت: {stats.speed} → {args.get('speed')}\n"
                f"🛡 استقامت: {stats.defense} → {args.get('defense')}\n"
                f"🧠 هوش: {stats.intelligence} → {args.get('intelligence')}\n"
                f"🍀 شانس: {stats.luck} → {args.get('luck')}\n\n"
                f"❤️ جان: {int(stats.hp)} → {args.get('hp')}\n"
                f"⚡ انرژی: {int(stats.energy)} → {args.get('energy')}\n"
                f"🔮 مانا: {int(stats.mana)} → {args.get('mana')}"
            )

            if xp > 0:
                text += f"\n\n✨ تجربه به‌دست‌آمده از نبرد: <b>{xp}</b>"

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
            buttons=buttons,
            parse_mode="HTML"
        )

    # -----------------------------
    # Upgrade Choices
    # -----------------------------

    async def generate_upgrade_choices(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")
        costs = data.get("costs")
        stats: CharacterStats = data.get("stats")
        total_stats = data.get("total_stats")
        reqire_level = data.get("reqire_level")

        buttons = []

        text = (
            f"📊 <b>مرکز ارتقای شخصیت</b>\n\n"
            f"در این بخش می‌توانی با مصرف تجربه، توانایی‌های اصلی خود را افزایش دهی.\n\n"
            f"🎖 سطح فعلی: <b>{stats.level}</b>\n"
            f"✨ تجربه موجود: <b>{stats.exp}</b>\n"
            f"📌 مجموع آمار: <b>{total_stats}</b>\n\n"
            f"━━━━━━━━━━━━━━━━━━━━\n"
            f"<b>گزینه‌های قابل ارتقا</b>\n"
        )

        upgrade_items = [
            ("strength", "💪", "قدرت", stats.strength),
            ("speed", "🏃", "سرعت", stats.speed),
            ("defense", "🛡", "استقامت", stats.defense),
            ("intelligence", "🧠", "هوش", stats.intelligence),
            ("luck", "🍀", "شانس", stats.luck),
            ("base_hp", "❤️", "جان پایه", stats.base_hp),
            ("base_energy", "⚡", "انرژی پایه", stats.base_energy),
            ("base_mana", "🔮", "مانای پایه", stats.base_mana),
        ]

        callback_names = {
            "strength": "strength",
            "speed": "speed",
            "defense": "defense",
            "intelligence": "intelligence",
            "luck": "luck",
            "base_hp": "hp",
            "base_energy": "energy",
            "base_mana": "mana",
        }

        for key, icon, label, value in upgrade_items:
            price, can_upgrade = costs[key]

            status = "قابل ارتقا" if can_upgrade else "نیازمند XP بیشتر"

            text += (
                f"\n{icon} <b>{label}</b>\n"
                f"مقدار فعلی: <code>{value}</code>\n"
                f"هزینه ارتقا: <code>{price} XP</code>\n"
                f"وضعیت: {status}\n"
            )

            if can_upgrade:
                buttons.append({
                    "text": icon,
                    "callback": f"upgrade:{callback_names[key]}-{price}"
                })

        if not buttons:
            text += (
                f"\n━━━━━━━━━━━━━━━━━━━━\n"
                f"در حال حاضر تجربه کافی برای ارتقای هیچ ویژگی‌ای نداری.\n"
                f"با شرکت در نبردها می‌توانی تجربه بیشتری به دست بیاوری."
            )
        else:
            text += (
                f"\n━━━━━━━━━━━━━━━━━━━━\n"
                f"برای ارتقای هر ویژگی، دکمه مربوط به آن را انتخاب کن."
            )

        sent = await bus.emit(
            "SEND",
            text=text,
            buttons=buttons,
            message=message,
            player_id=chat_id,
            parse_mode="HTML"
        )

        for btn in buttons:
            btn["callback"] += f"?••?/{sent.message_id}"

        await bus.emit(
            "EDIT",
            text=text,
            buttons=buttons,
            sent_message=sent,
            player_id=chat_id,
            parse_mode="HTML"
        )

    # -----------------------------
    # Upgrade Result
    # -----------------------------

    async def generate_update(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")

        stat_name = (
            data.get("stat_name")
            .replace("strength", "قدرت")
            .replace("speed", "سرعت")
            .replace("defense", "استقامت")
            .replace("intelligence", "هوش")
            .replace("luck", "شانس")
            .replace("hp", "جان")
            .replace("mana", "مانا")
            .replace("energy", "انرژی")
        )

        price = data.get("price")
        curr = data.get("curr")

        text = (
            f"✅ <b>ارتقا با موفقیت انجام شد</b>\n\n"
            f"ویژگی <b>{stat_name}</b> افزایش یافت.\n"
            f"برای این ارتقا، <b>{price} XP</b> از تجربه تو کسر شد.\n\n"
            f"📈 مقدار فعلی {stat_name}:\n"
            f"<code>{curr}</code>\n\n"
            f"هر ارتقا تو را یک قدم به تبدیل شدن به قهرمانی قدرتمندتر نزدیک‌تر می‌کند."
        )

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
            buttons=buttons,
            parse_mode="HTML"
        )

    # -----------------------------
    # Movement
    # -----------------------------

    async def generate_move_choices(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")
        buttons = data.get("buttons")

        text = (
            f"🧭 <b>انتخاب مسیر</b>\n\n"
            f"مسیر پیش روی تو می‌تواند امن، خطرناک یا سرشار از فرصت باشد.\n"
            f"مقصد بعدی خود را انتخاب کن."
        )

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
        chat_id = data.get("chat_id")
        message = data.get("message")
        loc: Location = data.get("loc")
        char = data.get("char")

        danger_level = getattr(loc, "danger_level", "نامشخص")
        description = getattr(loc, "description", "توضیحی برای این منطقه ثبت نشده است.")

        text = (
            f"📍 <b>ورود به منطقه جدید</b>\n\n"
            f"{char.name} وارد <b>{loc.name}</b> شد.\n\n"
            f"⚠️ سطح خطر منطقه: <b>{danger_level}</b>\n\n"
            f"📜 <b>شرح منطقه</b>\n"
            f"{description}\n\n"
            f"اکنون باید تصمیم بگیری که در این مکان چه کاری انجام دهی."
        )

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
            buttons=buttons,
            parse_mode="HTML"
        )

    # -----------------------------
    # Fight Action Selection
    # -----------------------------

    async def generate_fight_action(self, **data):
        enemy_id = data.get("enemy_id")
        message = data.get("message")
        enemy_type = data.get("enemy_type", "npc")
        enemy_count = data.get("enemy_count", 1)
        character_id = data.get("character_id")
        player_id = data.get("player_id")
        enemy_option = data.get("enemy_option")
        emy = data.get("emy")
        turn = data.get("turn")
        details = data.get("details")

        option_codes = {
            "Hard Fight": "hf",
            "Normal Fight": "nf",
            "Dodge": "dg",
            "Defend": "df",
        }

        enemy_name = getattr(emy, "name", "دشمن")

        enemy_option_texts = {
            "Hard Fight": [
                f"{enemy_name} نفسش را در سینه حبس می‌کند و نیرویی سنگین در بدنش جمع می‌شود.",
                f"{enemy_name} با خشونت قدمی جلو می‌گذارد؛ نشانه‌ها از یک ضربه‌ی سنگین خبر می‌دهند.",
                f"عضلات {enemy_name} منقبض می‌شود و نگاهش مستقیم روی نقطه‌ی ضعف تو قفل می‌ماند.",
                f"{enemy_name} بی‌پروا فشار می‌آورد؛ اگر این حمله بنشیند، دردناک خواهد بود.",
            ],
            "Normal Fight": [
                f"{enemy_name} با ریتمی ثابت به سمت تو حرکت می‌کند و آماده‌ی یک حمله‌ی مستقیم است.",
                f"{enemy_name} فاصله را کم می‌کند؛ نه شتاب‌زده، نه کند. یک حمله‌ی حساب‌شده در راه است.",
                f"{enemy_name} جای پایش را تنظیم می‌کند و برای درگیری نزدیک آماده می‌شود.",
                f"{enemy_name} با تمرکز جلو می‌آید؛ حرکتی متعادل و قابل پیش‌بینی، اما همچنان خطرناک.",
            ],
            "Dodge": [
                f"{enemy_name} بدنش را سبک می‌کند و حرکات تو را با دقت زیر نظر می‌گیرد.",
                f"{enemy_name} کمی عقب می‌نشیند؛ انگار منتظر است تو اول حمله کنی.",
                f"نگاه {enemy_name} روی دست‌ها و شانه‌های تو می‌چرخد. احتمالاً آماده‌ی جاخالی دادن است.",
                f"{enemy_name} پیوسته زاویه عوض می‌کند و هدف گرفتنش دشوارتر می‌شود.",
            ],
            "Defend": [
                f"{enemy_name} گاردش را بالا می‌آورد و وزنش را روی پای عقب می‌اندازد.",
                f"{enemy_name} حالت دفاعی می‌گیرد و مسیرهای حمله‌ی مستقیم را می‌بندد.",
                f"{enemy_name} فاصله را حفظ می‌کند و آماده است ضربه‌ی تو را جذب یا منحرف کند.",
                f"{enemy_name} به جای پیشروی، موضعی محکم می‌سازد؛ عبور از این دفاع ساده نخواهد بود.",
            ],
        }

        if enemy_option not in option_codes:
            enemy_option = random.choice(list(option_codes.keys()))

        enemy_action_text = random.choice(enemy_option_texts[enemy_option])

        try:
            enemy_count_value = int(enemy_count)
        except (TypeError, ValueError):
            enemy_count_value = 1

        count_text = ""
        if enemy_count_value > 1:
            count_text = f"\n👥 تعداد دشمنان درگیر: <b>{enemy_count_value}</b>"

        text = (
            f"⚔️ <b>نوبت تصمیم‌گیری</b>\n\n"
            f"{enemy_action_text}"
            f"{count_text}\n\n"
            f"اکنون باید حرکت بعدی خود را انتخاب کنی. هر تصمیم می‌تواند نتیجه‌ی این تبادل را تغییر دهد.\n\n"
            f"━━━━━━━━━━━━━━━━━━━━\n"
            f"🟥 <b>حمله سنگین</b>\n"
            f"ریسک بیشتر، آسیب بیشتر. اگر دشمن جاخالی دهد یا دفاع کند، ممکن است فرصت را از دست بدهی.\n\n"
            f"🟧 <b>حمله عادی</b>\n"
            f"انتخابی متعادل برای حفظ فشار، کنترل مبارزه و کاهش ریسک.\n\n"
            f"🟦 <b>جاخالی</b>\n"
            f"مناسب زمانی که احتمال می‌دهی ضربه‌ی سنگینی در راه است.\n\n"
            f"🟩 <b>دفاع</b>\n"
            f"کاهش آسیب احتمالی و آماده شدن برای ادامه‌ی نبرد.\n\n"
            f"حرکت تو چیست؟"
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
            "turn": turn,
            "details": details
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
            parse_mode="HTML"
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
