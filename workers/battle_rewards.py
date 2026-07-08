from .bus import bus
from database.db_manager import get_db
from database.model import CharacterStats
from sqlalchemy import select, update

from game_formulas import LevelManager, ExpReward
from constants import STAT_GROWTH_WEIGHTS


class CombatRewardsProcessor:
    async def handle_combat_end(self, **data):
        hero_stats = data.get("hero_stats")
        chat_id = data.get("chat_id")
        message = data.get("message")
        enemy = data.get("enemy")
        winner = data.get("winner")
        player_id = data.get("player_id")
        enemy_type = data.get("enemy_type")
        enemy_count = max(1, int(data.get("enemy_count", 1) or 1))

        if not hero_stats:
            return

        hero_id = hero_stats.character_id
        you_win = winner == "hero"

        if not you_win:
            await self._emit_reward_event(
                chat_id=chat_id,
                message=message,
                enemy=enemy,
                hero_stats=hero_stats,
                gained_xp=0,
                level_up=False,
                final_stats={},
                you_win=False,
                player_id=player_id,
            )
            return

        gained_xp = self._calculate_gained_xp(
            enemy_type=enemy_type,
            enemy_count=enemy_count,
        )

        final_update_data, level_up = self._build_final_stats(
            hero_stats=hero_stats,
            gained_xp=gained_xp,
        )

        await self._update_hero_in_db(
            hero_id=hero_id,
            update_data=final_update_data,
        )

        new_stats = CharacterStats()

        # کپی تمام مقادیر قبلی
        for column in CharacterStats.__table__.columns:
            setattr(new_stats, column.name, getattr(hero_stats, column.name))

        # اعمال مقادیر جدید
        for key, value in final_update_data.items():
            setattr(new_stats, key, value)

        await self._emit_reward_event(
            chat_id=chat_id,
            message=message,
            enemy=enemy,
            hero_stats=new_stats,
            gained_xp=gained_xp,
            level_up=level_up,
            final_stats=final_update_data,
            you_win=True,
            player_id=player_id,
        )

    def _calculate_gained_xp(self, enemy_type: str, enemy_count: int) -> int:
        base_difficulty_map = {
            "npc": 8,
            "enemy": 12,
            "character": 16,
        }

        difficulty = base_difficulty_map.get(enemy_type, 10)
        difficulty += max(0, enemy_count - 1) * 2

        return ExpReward(difficulty).calc_exp_reward()

    def _build_final_stats(self, hero_stats, gained_xp: int):
        total_xp = hero_stats.exp + gained_xp
        current_level = hero_stats.level
        update_data = {"exp": total_xp}
        level_up = False

        while True:
            level_manager = LevelManager(current_level)
            required_xp = level_manager.get_required_total_for_level()

            if total_xp < required_xp:
                break

            level_up = True
            total_xp -= required_xp
            current_level += 1

            next_stats = {}

            for stat, weight in STAT_GROWTH_WEIGHTS.items():
                current_val = next_stats.get(stat, getattr(hero_stats, stat))
                next_stats[stat] = level_manager.get_upgrade_value(current_val, weight)

            update_data.update(next_stats)
            update_data["level"] = current_level

        update_data["exp"] = total_xp

        if level_up:
            update_data["hp"] = update_data.get("base_hp", hero_stats.base_hp)
            update_data["energy"] = update_data.get("base_energy", hero_stats.base_energy)
            update_data["mana"] = update_data.get("base_mana", hero_stats.base_mana)

        return update_data, level_up

    async def _update_hero_in_db(self, hero_id: str, update_data: dict):
        async with get_db() as session:
            stmt = (
                update(CharacterStats)
                .where(CharacterStats.character_id == hero_id)
                .values(**update_data)
            )
            await session.execute(stmt)
            await session.commit()

    async def _emit_reward_event(
        self,
        chat_id,
        message,
        enemy,
        hero_stats,
        gained_xp,
        level_up,
        final_stats,
        you_win,
        player_id,
    ):
        await bus.emit(
            "GENERATE_COMBAT_REWARDS",
            chat_id=chat_id,
            player_id=player_id,
            xp=gained_xp,
            stats=hero_stats,
            message=message,
            you_win=you_win,
            enemy_name=getattr(enemy, "name", "Unknown Enemy"),
            level_up=level_up,
            args=final_stats,
        )


rewards_processor = CombatRewardsProcessor()
bus.listen("COMBAT_FINISHED", rewards_processor.handle_combat_end)
