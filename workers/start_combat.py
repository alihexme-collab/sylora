from .bus import bus
from database.db_manager import get_db
from database.model import *
from sqlalchemy import select, func
import random as rnd

class StartCombat:
    async def get(self, **data):
        enemy_id = data.get("enemy_id")
        message = data.get("message")
        chat_id = data.get("chat_id") or getattr(player, "telegram_id", None)
        enemy_type = data.get("enemy_type", "npc")
        enemy_count = data.get("enemy_count", 1)
        character_id= data.get("character_id")
        player_id = data.get("player_id")
        enemy_option=data.get("enemy_option"),
        character_option=data.get("character_option")

        async with get_db() as session:
            query=select(Character).where(Character.character_id == self.character_id)
            result = await session.execute(query)
            hero= result.scalar_one_or_none()

            if self.enemy_type == 'npc':
                query=select(Npc).where(Npc.npc_id == self.enemy_id)
            elif self.enemy_type == "enemy":
                query=select(Enemy).where(Enemy.enemy_id == self.enemy_id)
            else:
                query=select(Character).where(Character.character_id == self.enemy_id)
            result = await session.execute(query)
            emy = result.scalar_one_or_none()
        if not enemy_option:
            options = [
                "Hard Fight",
                "Normal Fight",
                "Dodge",
                "Defend"
            ]
            enemy_option = rnd.choice(options)
        await bus.emit(
            "GENERATE_CHOOSE_ACTION",
            player_id=player_id,
            chat_id=chat_id,
            enemy_id=enemy_id,
            enemy_type=enemy_type,
            enemy_count=enemy_count,
            message=message,
            character_id=character_id,
            enemy_option=enemy_option,
            character_option=character_option,
            hero=hero,
            emy=emy,
        )

    



        

start_combat = StartCombat()
bus.listen("START_COMBAT", start_combat.get)