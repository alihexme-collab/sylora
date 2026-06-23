import random as rnd

from sqlalchemy import select
from database.db_manager import get_db
from database.model import *
from .bus import bus


class FindEnemy:
    async def receive_fight(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")

        if not chat_id:
            return

        async with get_db() as session:
            # player
            result = await session.execute(
                select(Player).where(Player.telegram_id == chat_id)
            )
            player = result.scalar_one_or_none()
            if not player:
                return

            # hero character
            result = await session.execute(
                select(Character).where(Character.player_id == player.player_id)
            )
            hero = result.scalar_one_or_none()
            if not hero:
                return

            # hero stats
            result = await session.execute(
                select(CharacterStats).where(CharacterStats.character_id == hero.character_id)
            )
            player_stats = result.scalar_one_or_none()
            if not player_stats:
                return

            # region extraction
            try:
                _, region, area = hero.character_path.split("_")
            except Exception:
                return

            candidates = []

            # NPC candidates
            result = await session.execute(
                select(Npc).where(Npc.npc_id.like(f"npc_{region}_%"))
            )
            for npc in result.scalars().all():
                candidates.append({
                    "obj": npc,
                    "type": "npc"
                })

            # Character candidates in same region
            result = await session.execute(
                select(Character).where(Character.character_path == hero.character_path)
            )
            for char in result.scalars().all():
                if char.character_id == hero.character_id:
                    continue
                candidates.append({
                    "obj": char,
                    "type": "character"
                })

            result = await session.execute(
                select(Enemy).where(Enemy.location_id == hero.character_path)
            )
            for emy in result.scalars().all():
                candidates.append({
                    "obj": emy,
                    "type": "enemy"
                })

            if not candidates:
                return

            chosen = rnd.choice(candidates)
            enemy = chosen["obj"]
            enemy_type = chosen["type"]

            # enemy stats
            enemy_stats = None

            if enemy_type == "npc":
                result = await session.execute(
                    select(NpcStats).where(NpcStats.npc_id == enemy.npc_id)
                )
                enemy_stats = result.scalar_one_or_none()

            elif enemy_type == "character":
                result = await session.execute(
                    select(CharacterStats).where(CharacterStats.character_id == enemy.character_id)
                )
                enemy_stats = result.scalar_one_or_none()
            
            else:
                result = await session.execute(
                    select(EnemyStats).where(EnemyStats.enemy_id == enemy.enemy_id)
                )
                enemy_stats = result.scalar_one_or_none()

            if not enemy_stats:
                return

            def power_of(stats):
                return (
                    (stats.strength or 0)
                    + (stats.speed or 0)
                    + (stats.defense or 0)
                    + (stats.intelligence or 0)
                    + (stats.hp or 0)
                    + (stats.mana or 0)
                )
            if enemy_type == "enemy":
                player_power = power_of(player_stats)
                enemy_power = power_of(enemy_stats)

                # Determine count
                if enemy_power < player_power:
                    ratio = player_power / max(enemy_power, 1)
                    enemy_count = max(2, min(int(ratio), 5))
                else:
                    enemy_count = 1
            else:
                enemy_count = 1

            await bus.emit(
                "COMBAT",
                player_id=chat_id,
                chat_id=chat_id,
                player=player,
                hero=hero,
                enemy=enemy,
                enemy_type=enemy_type,
                enemy_count=enemy_count,
                message=message
            )


find_enemy = FindEnemy()
bus.listen("FIGHT", find_enemy.receive_fight)
