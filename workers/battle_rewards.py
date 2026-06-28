from .bus import bus
from database.db_manager import get_db
from database.model import *
from sqlalchemy import update
import random as rnd

class BattleRewards:
    async def get(self, **data):
        print(data)
        self.player=data.get("player")
        self.enemy=data.get("enemy")
        self.enemy_type=data.get("enemy_type")
        self.enemy_count=data.get("enemy_count")
        self.winner=data.get("winner")
        self.loser=data.get("loser")
        self.details=data.get("details")
        self.hero_stats: CharacterStats=data.get("hero_stats")
        self.enemy_stats: CharacterStats=data.get("enemy_stats")
        self.message=data.get("message")
        self.chat_id=data.get("chat_id")

        await self.apply()
    def get_required_total_for_level(self, level):
        return 100 + (level - 1) * 40
    
    async def apply(self):
        gained_xp = self.calculate_combat_xp()
        async with get_db() as session:
            args = {
                "exp": self.hero_stats.exp + gained_xp,
            }
            level_up =False
            if self.hero_stats.exp + gained_xp > self.get_required_total_for_level(self.hero_stats.level):
                level = self.hero_stats.level + 1
                args.update(
                    {
                        "level": level,
                        "strength": self.hero_stats.strength + 2 * level,
                        "speed": self.hero_stats.speed + 2 * level,
                        "defense": self.hero_stats.defense + 2* level,
                        "hp": self.hero_stats.base_hp + 10* level,
                        "energy": self.hero_stats.base_energy + 10* level,
                        "mana": self.hero_stats.base_mana + 10* level,
                        "intelligence": self.hero_stats.intelligence + 1* level,
                        "luck": self.hero_stats.luck +1* level,
                        "base_hp": self.hero_stats.base_hp + 10* level,
                        "base_energy": self.hero_stats.base_energy + 10* level,
                        "base_mana": self.hero_stats.base_mana + 10* level,
                        "exp": 0,
                    }
                )
                gained_xp = 0
                level_up = True
            query = update(
                CharacterStats
            ).where(
                CharacterStats.character_id == self.hero_stats.character_id
            ).values(
                **args
            )
            await session.execute(query)
        await bus.emit(
            "GENERATE_COMBAT_REWARDS",
            chat_id=self.chat_id,
            player=self.player,
            xp=gained_xp,
            stats=self.hero_stats,
            message=self.message,
            you_win=self.is_hero_winner(),
            enemy_name=self.enemy.name,
            level_up=level_up,
        )


    def is_hero_winner(self):
        return self.winner == "hero"
    
    def calculate_combat_xp(self, base_xp: int = 25) -> int:
        print("+"*100)
        result = self.result_multiplier()
        print(result)
        effort = self.effort_multiplier()
        print(effort)
        performance = self.performance_multiplier()
        print(performance)
        duration = self.duration_multiplier()
        print(duration)

        xp = int(base_xp * result * effort * performance * duration)
        print(xp)
        print("+"*100)
        if self.is_hero_winner():
            return max(xp, 5)

        return max(xp, 1)


    def result_multiplier(self) -> float:
        if self.is_hero_winner():
            return 1.0

        return 0.35


    def effort_multiplier(self) -> float:
        hero_effort = self.hero_effort_score()
        enemy_damage = self.enemy_damage_score()

        total = hero_effort + enemy_damage

        if total <= 0:
            return 0.2

        multiplier = 0.6 + min(total / 120, 1.4)

        return min(multiplier, 2.0)


    def performance_multiplier(self) -> float:
        hero_effort = self.hero_effort_score()
        enemy_damage = self.enemy_damage_score()

        total_activity = hero_effort + enemy_damage

        if total_activity <= 0:
            return 0.1

        performance_ratio = enemy_damage / max(total_activity, 1)

        if self.is_hero_winner():
            return 0.8 + min(performance_ratio * 1.4, 1.2)

        return 0.3 + min(performance_ratio * 1.7, 1.1)


    def duration_multiplier(self) -> float:
        rounds = self.details.get("rounds", 1)

        if rounds <= 1:
            return 0.35

        if rounds <= 3:
            return 0.7

        if rounds <= 7:
            return 1.0

        return 1.15


    def hero_effort_score(self) -> float:
        hero = self.details.get("Total-hero-costs", {})
        self.hero = hero
        return (
            hero.get("hp", 0) * 1.3 +
            hero.get("energy", 0) * 0.7 +
            hero.get("mana", 0) * 0.9
        )


    def enemy_damage_score(self) -> float:
        enemy = self.details.get("Total-enemy-costs", {})

        return (
            enemy.get("hp", 0) * 1.2 +
            enemy.get("energy", 0) * 0.5 +
            enemy.get("mana", 0) * 0.7
        )


battle_reward = BattleRewards()
bus.listen("COMBAT_FINISHED", battle_reward.get)