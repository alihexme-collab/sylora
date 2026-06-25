from sqlalchemy import select
from database.db_manager import get_db
from database.model import *
from .bus import bus

class Sleep:
    async def get(self, **data):
        self.chat_id = data.get("chat_id")
        self.message = data.get("message")



move = Sleep()

bus.listen("SLEEP", move.get)