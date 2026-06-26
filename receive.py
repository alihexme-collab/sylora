from telegram import *
from workers.loader import *
from telegram.ext import *
from workers import *


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

        chat_id = query.message.chat_id
        data = query.data

        if not data.startswith("cb|"):
            await query.answer("داده‌ی مبارزه نامعتبر است.", show_alert=True)
            return

        try:
            _, emy_id, emy_opt_code, emy_type, emy_count, char_id, char_opt_code = data.split("|")
        except ValueError:
            await query.answer("فرمت داده‌ی مبارزه خراب است.", show_alert=True)
            return

        option_map = {
            "hf": "Hard Fight",
            "nf": "Normal Fight",
            "dg": "Dodge",
            "df": "Defend",
        }

        enemy_option = option_map.get(emy_opt_code)
        character_option = option_map.get(char_opt_code)

        if not enemy_option or not character_option:
            await query.answer("گزینه‌ی مبارزه نامعتبر است.", show_alert=True)
            return

        try:
            enemy_count = int(emy_count)
        except (TypeError, ValueError):
            enemy_count = 1

        await bus.emit(
            "COMBAT",
            player_id=chat_id,
            chat_id=chat_id,
            message=query.message,
            enemy_id=emy_id,
            enemy_option=enemy_option,
            enemy_type=emy_type,
            enemy_count=enemy_count,
            character_id=char_id,
            character_option=character_option
        )

    


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
        pattern="^combat:"
    )
)