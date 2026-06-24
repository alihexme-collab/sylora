from .bus import bus
from telegram import Message, InlineKeyboardButton, InlineKeyboardMarkup
from .loader import *

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


    async def edit(
        self, 
        *, 
        sent_message: Message = None, 
        chat_id: int = None, 
        message_id: int = None, 
        text: str = "", 
        buttons = None, 
        parse_mode = None, 
        **kwargs
    ):
        reply_markup = self._build_keyboard(buttons)

        # حالت اول: شیء پیام ارسال شده است
        if sent_message:
            return await sent_message.edit_text(
                text=text,
                reply_markup=reply_markup,
                parse_mode=parse_mode,
                
            )
        
        # حالت دوم: شناسه پیام و شناسه چت ارسال شده‌اند
        elif chat_id and message_id:
            # فرض بر این است که self.bot یا self.context.bot در کلاس شما در دسترس است
            return await app.bot.edit_message_text(
                chat_id=chat_id,
                message_id=message_id,
                text=text,
                reply_markup=reply_markup,
                parse_mode=parse_mode,
            )
        
        else:
            # اگر اطلاعات کافی برای ویرایش وجود نداشت
            raise ValueError("شما باید یا sent_message یا هر دو مقدار chat_id و message_id را پاس بدهید.")



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
                        callback_data=b.get("callback")
                    )
                ])

        return InlineKeyboardMarkup(rows)


sender = Sender()

bus.listen("SEND", sender.send)
bus.listen("EDIT", sender.edit)
