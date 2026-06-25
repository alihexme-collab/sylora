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
            "COMBAT",
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
        receive.choose_enemy,
        pattern="^move_to:"
    )
)