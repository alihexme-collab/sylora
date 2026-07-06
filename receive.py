import json
from pathlib import Path
from telegram import Update
from telegram.ext import ContextTypes, CommandHandler, CallbackQueryHandler, MessageHandler, filters
from workers.loader import app, bus
from workers.callback_store import callback_store
from combat_cache import get_combat_session, delete_combat_session
from urllib.parse import quote
from telegram import InlineKeyboardButton, InlineKeyboardMarkup

class Receive:

    async def start(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        chat_id = update.message.chat_id

        await bus.emit(
            "COMMAND",
            player_id=chat_id,
            text=update.message.text,
            chat_id=chat_id,
            username=update.message.from_user.username,
            name=update.message.from_user.full_name,
            message=update.message
        )

    async def fight(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()

        chat_id = query.message.chat.id

        await bus.emit(
            "FIGHT",
            player_id=chat_id,
            chat_id=chat_id,
            message=query.message
        )

    async def upgrade_request(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()

        chat_id = query.message.chat.id

        await bus.emit(
            "UPGRADE",
            player_id=chat_id,
            chat_id=chat_id,
            message=query.message
        )

    async def update(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()
        chat_id = query.message.chat.id

        await bus.emit(
            "UPDATE",
            player_id=chat_id,
            chat_id=chat_id,
            query=query
        )

    async def choose_enemy(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()
        chat_id = query.message.chat.id
        _, cid = query.data.split(":")

        data = callback_store.get(cid)
        if not data:
            await query.answer("⌛ این گزینه منقضی شده است. لطفا دوباره تلاش کنید.", show_alert=True)
            return

        enemy_type = data["enemy_type"]
        enemy_id = data["enemy_id"]
        hero_id = data["hero_id"]
        await bus.emit(
            "START_COMBAT",
            player_id=chat_id,
            chat_id=chat_id,
            enemy_id=enemy_id,
            enemy_type=enemy_type,
            enemy_count=1,
            message=query.message,
            character_id=hero_id,
            turn=0,
            details={}
        )

    async def move(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()

        chat_id = query.message.chat.id

        await bus.emit(
            "MOVE",
            player_id=chat_id,
            chat_id=chat_id,
            message=query.message
        )

    async def move_to(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()

        chat_id = query.message.chat.id

        await bus.emit(
            "MOVE_TO",
            player_id=chat_id,
            chat_id=chat_id,
            message=query.message,
            data=query.data
        )

    async def sleep(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()

        chat_id = query.message.chat.id

        await bus.emit(
            "SLEEP",
            player_id=chat_id,
            chat_id=chat_id,
            message=query.message
        )

    async def combat(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()

        OPTION_CODE_MAP = {
            "hf": "Hard Fight",
            "nf": "Normal Fight",
            "dg": "Dodge",
            "df": "Defend",
        }

        data = query.data
        chat_id = query.message.chat_id

        if not data or not data.startswith("cb|"):
            await query.answer("⚠️ داده‌ی ارسالی نامعتبر است.", show_alert=True)
            return

        parts = data.split("|")

        if len(parts) != 3:
            await query.answer("⚠️ فرمت درخواست نامعتبر است.", show_alert=True)
            return

        _, session_id, char_opt_code = parts

        character_option = OPTION_CODE_MAP.get(char_opt_code)

        if character_option is None:
            await query.answer("⚔️ تصمیم انتخاب‌شده معتبر نیست.", show_alert=True)
            return

        session = get_combat_session(session_id)

        if not session:
            await query.answer("⌛ نوبت مبارزه منقضی شده است. لطفا دوباره اقدام کنید.", show_alert=True)
            return

        if session.get("owner_chat_id") is not None and session.get("owner_chat_id") != chat_id:
            await query.answer("🛡 این نبرد متعلق به شما نیست.", show_alert=True)
            return

        try:
            enemy_count = int(session.get("enemy_count", 1))
        except ValueError:
            enemy_count = 1

        await bus.emit(
            "COMBAT",
            player_id=session.get("player_id") or chat_id,
            chat_id=chat_id,
            message=query.message,
            enemy_id=session["enemy_id"],
            enemy_option=session["enemy_option"],
            enemy_type=session.get("enemy_type", "npc"),
            enemy_count=enemy_count,
            character_id=session["character_id"],
            character_option=character_option,
            turn=session['turn'],
            details=session['details']
        )

        delete_combat_session(session_id)

    async def home(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()
        chat_id = query.message.chat.id

        await bus.emit(
            "COMMAND",
            text=f"/start {chat_id}",
            player_id=chat_id,
            chat_id=chat_id,
            username=query.from_user.username,
            name=query.from_user.full_name,
            message=query.message
        )

    async def get_comment(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()
        chat_id = query.message.chat.id
        path = Path("comment.json")

        comments = {}
        if path.exists():
            try:
                with open(path, "r", encoding="utf-8") as file:
                    content = file.read().strip()
                    comments = json.loads(content) if content else {}
            except (json.JSONDecodeError, OSError):
                comments = {}

        if not comments.get(str(chat_id)):
            await bus.emit(
                "COMMENTING",
                player_id=chat_id,
                chat_id=chat_id,
                message=query.message
            )
        else:
            await query.message.reply_text("💬 نظر ارزشمند شما قبلاً ثبت شده است و نیازی به ارسال مجدد نیست.")

    async def comment(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        chat_id = update.message.chat_id
        path = Path("comment.json")

        comments = {}
        if path.exists():
            try:
                with open(path, "r", encoding="utf-8") as file:
                    content = file.read().strip()
                    comments = json.loads(content) if content else {}
            except (json.JSONDecodeError, OSError):
                comments = {}

        if not comments.get(str(chat_id)):
            await bus.emit(
                "COMMENT",
                message=update.message,
                chat_id=chat_id
            )
        else:
            await update.message.reply_text("💬 نظر ارزشمند شما قبلاً ثبت شده است.")

    async def show_comments(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()
        ADMIN_IDS = {7606015504}
        user_id = query.from_user.id
        if user_id not in ADMIN_IDS:
            await query.answer("🚫 دسترسی به این بخش تنها برای مدیریت امکان‌پذیر است.", show_alert=True)
            return

        path = Path("comment.json")

        if not path.exists():
            await query.message.reply_text("📂 در حال حاضر هیچ نظری ثبت نشده است.")
            return

        try:
            with open(path, "r", encoding="utf-8") as file:
                content = file.read().strip()
                comments = json.loads(content) if content else {}
        except (json.JSONDecodeError, OSError):
            await query.message.reply_text("❌ فایل نظرات خوانا نیست یا آسیب دیده است.")
            return

        if not comments:
            await query.message.reply_text("📂 لیست نظرات خالی است.")
            return

        messages = []
        current_chunk = "📥 <b>لیست نظرات ثبت شده کاربران:</b>\n\n"

        for chat_id, data in comments.items():
            block = (
                f"👤 <b>کاربر:</b> <code>{chat_id}</code>\n"
                f"📅 <b>تاریخ ثبت:</b> {data.get('date', 'نامشخص')}\n"
                f"📝 <b>متن نظر:</b>\n{data.get('text', '')}\n"
                f"{'—' * 20}\n"
            )

            if len(current_chunk) + len(block) > 3500:
                if current_chunk.strip():
                    messages.append(current_chunk)
                current_chunk = block
            else:
                current_chunk += block

        if current_chunk.strip():
            messages.append(current_chunk)

        try:
            for chunk in messages:
                await query.message.reply_text(chunk, parse_mode="HTML")
        except Exception as exc:
            print(f"show_comments send error: {exc}")
            await query.message.reply_text("❌ خطایی در ارسال گزارش نظرات رخ داد. داده‌ها پاک نشدند.")
            return

        try:
            with open(path, "w", encoding="utf-8") as file:
                json.dump({}, file, ensure_ascii=False, indent=4)
        except OSError as exc:
            print(f"show_comments clear error: {exc}")
            await query.message.reply_text("✅ نظرات ارسال شدند، اما خالی کردن موقت فایل با خطا مواجه شد.")
            return

        await query.message.reply_text("🧹 همه نظرات با موفقیت بررسی و لیست بایگانی تخلیه شد.")


    async def reffral(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        BOT_USERNAME = "playleisbot"
        query = update.callback_query
        await query.answer()
        user_id = query.from_user.id

        # لینک دعوت اختصاصی
        ref_link = f"https://t.me/{BOT_USERNAME}?start=ref_{user_id}"

        # اگر این مقادیر را در کلاس تعریف نکرده‌ای، اینجا مستقیم بگذار
        upgrade_points = getattr(self, "REFERRAL_UPGRADE_POINTS", 1)
        stat_points = getattr(self, "REFERRAL_STAT_POINTS", 1)
        referral_reward_points = getattr(self, "REFERRAL_REWARD_POINTS", 1)

        # متن دعوت با پاداش امتیازی
        text = (
            "⚔️ <b>اتحاد ماجراجویان | سیستم دعوت</b>\n\n"
            "ماجراجوی گرامی! با دعوت هم‌رزمان خود به این دنیای پرمخاطره، ارتش خود را نیرومندتر کنید.\n\n"
            "🎁 <b>پاداش دعوت:</b>\n"
            f"به ازای هر بازیکن جدیدی که با لینک شما وارد بازی شود و برای اولین‌بار سفر خود را آغاز کند،\n"
            f"<b>+{upgrade_points} upgrade points</b>\n"
            f"<b>+{stat_points} stat points</b>\n"
            f"<b>+{referral_reward_points} referral reward points</b>\n"
            "به عنوان پاداش دریافت خواهید کرد.\n\n"
            "🔗 <b>لینک دعوت اختصاصی شما:</b>\n"
            f"<code>{ref_link}</code>\n\n"
            "<i>روی لینک بالا بزنید تا کپی شود، سپس آن را برای دوستان خود بفرستید.</i>"
        )

        # دکمه اشتراک‌گذاری
        share_text = quote("به دنیای رازآلود این بازی نقش‌آفرینی بپیوندید! ⚔️")
        share_url = quote(ref_link, safe="")
        keyboard = [
            [
                InlineKeyboardButton(
                    "📢 اشتراک‌گذاری با دوستان",
                    url=f"https://t.me/share/url?url={share_url}&text={share_text}"
                )
            ]
        ]
        reply_markup = InlineKeyboardMarkup(keyboard)

        await query.message.reply_text(
            text=text,
            parse_mode="HTML",
            reply_markup=reply_markup
        )






receive = Receive()


app.add_handler(CommandHandler("start", receive.start))
app.add_handler(CallbackQueryHandler(receive.fight, pattern="^نبرد$"))
app.add_handler(CallbackQueryHandler(receive.upgrade_request, pattern="^ارتقا$"))
app.add_handler(CallbackQueryHandler(receive.update, pattern="^upgrade:"))
app.add_handler(CallbackQueryHandler(receive.choose_enemy, pattern="^fight:"))
app.add_handler(CallbackQueryHandler(receive.move, pattern="^حرکت$"))
app.add_handler(CallbackQueryHandler(receive.sleep, pattern="^استراحت$"))
app.add_handler(CallbackQueryHandler(receive.move_to, pattern="^move_to:"))
app.add_handler(CallbackQueryHandler(receive.combat, pattern=r"^cb\|"))
app.add_handler(CallbackQueryHandler(receive.home, pattern="^home$"))
app.add_handler(CallbackQueryHandler(receive.get_comment, pattern="^ثبت نظر$"))
app.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, callback=receive.comment))
app.add_handler(CallbackQueryHandler(receive.show_comments, pattern="^نمایش نظرات$"))
app.add_handler(CallbackQueryHandler(receive.reffral, pattern="^معرفی به دوستان$"))