from .bus import bus
from database.db_manager import get_db
from database.model import Character, Npc, Enemy
from sqlalchemy import select
import random as rnd

from constants import COMBAT_ACTIONS


class StartCombat:
    async def get(self, **data):
        enemy_id = data.get("enemy_id")
        message = data.get("message")
        chat_id = data.get("chat_id")
        enemy_type = data.get("enemy_type", "npc")
        enemy_count = max(1, int(data.get("enemy_count", 1) or 1))
        character_id = data.get("character_id")
        player_id = data.get("player_id")
        enemy_option = data.get("enemy_option")
        character_option = data.get("character_option")
        turn = int(data.get("turn") or 1)
        details = data.get("details") or {}

        async with get_db() as session:
            hero = await self._get_character(session, character_id)
            enemy = await self._get_enemy(session, enemy_id, enemy_type)

        if hero is None or enemy is None:
            return

        if not enemy_option or enemy_option not in COMBAT_ACTIONS:
            enemy_option = rnd.choice(COMBAT_ACTIONS)

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
            emy=enemy,
            turn=turn,
            details=details,
        )

    async def _get_character(self, session, character_id):
        query = select(Character).where(Character.character_id == character_id)
        result = await session.execute(query)
        return result.scalar_one_or_none()

    async def _get_enemy(self, session, enemy_id, enemy_type):
        model_map = {
            "npc": Npc,
            "enemy": Enemy,
            "character": Character,
        }

        field_map = {
            "npc": Npc.npc_id,
            "enemy": Enemy.enemy_id,
            "character": Character.character_id,
        }

        model = model_map.get(enemy_type, Npc)
        field = field_map.get(enemy_type, Npc.npc_id)

        query = select(model).where(field == enemy_id)
        result = await session.execute(query)
        return result.scalar_one_or_none()


start_combat = StartCombat()
bus.listen("START_COMBAT", start_combat.get)
