from .bus import bus
from telegram import Message, InlineKeyboardButton, InlineKeyboardMarkup


class Sender:

    async def send(self, *, message: Message=None, text:str="", buttons=None, parse_mode=None, **kwargs):

        if not message:
            return None

        reply_markup = self._build_keyboard(buttons)

        sent = await message.reply_text(
            text=text,
            reply_markup=reply_markup,
            parse_mode=parse_mode
        )

        return sent


    async def edit(self, *, sent_message:Message=None, text:str="", buttons=None, parse_mode=None, **kwargs):

        if not sent_message:
            return None

        reply_markup = self._build_keyboard(buttons)

        return await sent_message.edit_text(
            text=text,
            reply_markup=reply_markup,
            parse_mode=parse_mode
        )


    def _build_keyboard(self, buttons):

        if not buttons:
            return None

        rows = []

        for b in buttons:

            if isinstance(b,str):
                rows.append([
                    InlineKeyboardButton(
                        text=b,
                        callback_data=b
                    )
                ])

            elif isinstance(b,dict):
                rows.append([
                    InlineKeyboardButton(
                        text=b.get("text"),
                        callback_data=b.get("callback_data")
                    )
                ])

        return InlineKeyboardMarkup(rows)


sender = Sender()

bus.listen("SEND", sender.send)
bus.listen("EDIT", sender.edit)
