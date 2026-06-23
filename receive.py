from telegram import *
from loader import *
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

    async def upgrade(self, update: Update, context: ContextTypes.DEFAULT_TYPE):
        query = update.callback_query
        await query.answer()

        chat_id = query.message.chat_id

        await bus.emit(
            "UPGRADE",
            player_id=chat_id,
            chat_id=chat_id,
            message=query.message
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
        pattern="^مبارزه با یک حریف$"
    )
)

app.add_handler(
    CallbackQueryHandler(
        receive.upgrade,
        pattern="^ارتقای آمار$"
    )
)