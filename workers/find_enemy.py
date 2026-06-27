import random as rnd

from sqlalchemy import select
from database.db_manager import get_db
from database.model import *
from .bus import bus

def compare_power(player_power, enemy_power):
    ratio = enemy_power / max(player_power, 1)

    if ratio < 0.7:
        return "ضعیف‌تر از شما 🟢"
    elif ratio < 1.2:
        return "تقریباً هم‌سطح 🟡"
    elif ratio < 1.7:
        return "قوی‌تر از شما 🔴"
    else:
        return "بسیار خطرناک ☠️"

def power_of(stats):
    if getattr(stats, "intelligence", False):
        return (
            (stats.strength or 0)
            + (stats.speed or 0)
            + (stats.defense or 0)
            + (stats.intelligence or 0)
            + (stats.hp or 0)
            + (stats.mana or 0)
            + (stats.energy or 0)
        )
    else:
        return (
            (stats.strength or 0)
            + (stats.speed or 0)
            + (stats.hp or 0)
            + (stats.mana or 0)
            + (stats.energy or 0)
        )
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
            if player_stats.hp <= 10 or player_stats.energy <= 10:
                await bus.emit(
                    "SEND",
                    player_id=chat_id,
                    text="وضعیت فعلی شما خیلی وخیم است و توان مبارزه ندارید",
                    message=message,
                    chat_id=chat_id
                )
                print("%"*99)
                return
            # region extraction
            try:
                _, region, area = hero.character_path.split("_")
            except Exception:
                return

            candidates = []
            # NPC candidates
            if player_stats.level >= 10:
                result = await session.execute(
                    select(Npc).where(Npc.npc_id.like(f"npc_{region}_{area}"))
                )
                for npc in result.scalars().all():
                    candidates.append(
                        {
                            "obj": npc,
                            "type": "npc"
                        }
                    )

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

            rnd.shuffle(candidates)
            choices = candidates[: rnd.randint(3, 4)]

            options = []

            player_power = power_of(player_stats)

            for cand in choices:

                enemy = cand["obj"]
                enemy_type = cand["type"]

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
                    continue

                enemy_power = power_of(enemy_stats)

                difficulty = compare_power(player_power, enemy_power)

                options.append({
                    "enemy": enemy,
                    "type": enemy_type,
                    "difficulty": difficulty
                })


            text = "⚔️ دشمنانی در اطراف شما دیده شدند.\n"
            text += "یکی را برای مبارزه انتخاب کنید:\n\n"

            buttons = []

            for opt in options:

                enemy = opt["enemy"]
                enemy_type = opt["type"]

                name = getattr(enemy, "name", "Unknown")

                text += f"• {name} — {opt['difficulty']}\n"

                uid = (
                    enemy.enemy_id
                    if enemy_type == "enemy"
                    else enemy.npc_id
                    if enemy_type == "npc"
                    else enemy.character_id
                )

                buttons.append({
                    "text": name,
                    "callback": f"fight:{enemy_type}:{uid}:{hero.character_id}"
                })
            await bus.emit(
                "SEND",
                player_id=player.player_id,
                chat_id=chat_id,
                text=text,
                buttons=buttons,
                message=message
            )


find_enemy = FindEnemy()
bus.listen("FIGHT", find_enemy.receive_fight)
