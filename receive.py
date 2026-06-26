from telegram import *
from workers.loader import *
from telegram.ext import *
from workers import *
from combat_cache import get_combat_session, delete_combat_session


class Receive:

    async def start(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        print("Received")

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

        chat_id = query.message.chat_id

        await bus.emit(
            "FIGHT",
            player_id=chat_id,
            chat_id=chat_id,
            message=query.message
        )

    async def upgrade_request(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()

        chat_id = query.message.chat_id

        await bus.emit(
            "UPGRADE",
            player_id=chat_id,
            chat_id=chat_id,
            message=query.message
        )

    async def update(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()
        chat_id = query.message.chat_id

        await bus.emit(
            "UPDATE",
            player_id=chat_id,
            chat_id=chat_id,
            query=query
        )

    async def choose_enemy(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()
        chat_id = query.message.chat_id
        data = query.data.split(':')
        _, enemy_type, enemy_id, character_id = data
        await bus.emit(
            "START_COMBAT",
            player_id=chat_id,
            chat_id=chat_id,
            enemy_id=enemy_id,
            enemy_type=enemy_type,
            enemy_count=1,
            message=query.message,
            character_id=character_id
        )

    async def move(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()

        chat_id = query.message.chat_id

        await bus.emit(
            "MOVE",
            player_id=chat_id,
            chat_id=chat_id,
            message=query.message
        )

    async def move_to(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()

        chat_id = query.message.chat_id

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

        chat_id = query.message.chat_id

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
            await query.answer("داده‌ی نامعتبر.", show_alert=True)
            return

        parts = data.split("|")

        if len(parts) != 3:
            await query.answer("فرمت داده نامعتبر است.", show_alert=True)
            return

        _, session_id, char_opt_code = parts

        character_option = OPTION_CODE_MAP.get(char_opt_code)

        if character_option is None:
            await query.answer("اکشن انتخاب‌شده معتبر نیست.", show_alert=True)
            return

        session = get_combat_session(session_id)

        if not session:
            await query.answer("این اکشن منقضی شده است. دوباره تلاش کنید.", show_alert=True)
            return

        if session.get("owner_chat_id") is not None and session.get("owner_chat_id") != chat_id:
            await query.answer("این دکمه متعلق به شما نیست.", show_alert=True)
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
        )

        delete_combat_session(session_id)



    


receive = Receive()


app.add_handler(
    CommandHandler(
        "start",
        receive.start,
    )
)


app.add_handler(
    CallbackQueryHandler(
        receive.fight,
        pattern="^نبرد$"
    )
)

app.add_handler(
    CallbackQueryHandler(
        receive.upgrade_request,
        pattern="^ارتقا$"
    )
)

app.add_handler(
    CallbackQueryHandler(
        receive.update,
        pattern="^upgrade:"
    )
)

app.add_handler(
    CallbackQueryHandler(
        receive.choose_enemy,
        pattern="^fight:"
    )
)

app.add_handler(
    CallbackQueryHandler(
        receive.move,
        pattern="^حرکت$"
    )
)

app.add_handler(
    CallbackQueryHandler(
        receive.sleep,
        pattern="^استراحت$"
    )
)

app.add_handler(
    CallbackQueryHandler(
        receive.move_to,
        pattern="^move_to:"
    )
)

app.add_handler(
    CallbackQueryHandler(
        receive.combat,
        pattern="^cb|"
    )
)