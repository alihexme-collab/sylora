from .bus import bus
from database.db_manager import get_db
from database.model import *
from sqlalchemy import select, func
from datetime import datetime

class StartCombat:
    async def make(self, **data):
        pass

start_combat = StartCombat()
bus.listen("START_COMBAT", start_combat.make)