class ExpReward:
    def __init__(
        self,
        base_exp: int = 15,
        winner: str = "enemy",
        details: dict | None = None,
        turn: int = 1,
        enemy_count: int = 1,
    ):
        self.base = max(1, int(base_exp or 15))
        self.winner = winner
        self.details = details or {}
        self.turn = max(1, int(turn or 1))
        self.enemy_count = max(1, int(enemy_count or 1))

    def calc_exp_reward(self) -> int:
        result = self.result_multiplier()
        effort = self.effort_multiplier()
        performance = self.performance_multiplier()
        duration = self.duration_multiplier()
        count = self.enemy_count_multiplier()

        xp = int(
            self.base
            * result
            * effort
            * performance
            * duration
            * count
        )

        if self.is_hero_winner():
            return max(xp, 5)

        return max(xp, 1)

    def is_hero_winner(self) -> bool:
        return self.winner == "hero"

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
        rounds = self.turn

        if rounds <= 1:
            return 0.35

        if rounds <= 3:
            return 0.7

        if rounds <= 7:
            return 1.0

        return 1.15

    def enemy_count_multiplier(self) -> float:
        """
        اگر چند دشمن درگیر بوده‌اند، XP کمی بیشتر شود.
        برای جلوگیری از abuse، رشد را محدود نگه می‌داریم.
        """
        if self.enemy_count <= 1:
            return 1.0

        return min(1.0 + ((self.enemy_count - 1) * 0.25), 2.0)

    def hero_effort_score(self) -> float:
        hero = self.details.get("Total-hero-costs", {}) or {}

        return (
            hero.get("hp", 0) * 1.3
            + hero.get("energy", 0) * 0.7
            + hero.get("mana", 0) * 0.9
        )

    def enemy_damage_score(self) -> float:
        enemy = self.details.get("Total-enemy-costs", {}) or {}

        return (
            enemy.get("hp", 0) * 1.2
            + enemy.get("energy", 0) * 0.5
            + enemy.get("mana", 0) * 0.7
        )



class LevelManager:
    def __init__(self, level: int):
        self.level = level

    
    def get_required_total_for_level(self):
        return 100 + (self.level - 1) * 40
    
    def get_upgrade_value(self, current_value, weight):
        return current_value + weight * self.level
    
import random as rnd
from constants import COMBAT_ACTION_MODIFIERS

class CombatCalculator:
    @staticmethod
    def get_action_profile(option: str) -> dict:
        return COMBAT_ACTION_MODIFIERS.get(option, COMBAT_ACTION_MODIFIERS["Normal Fight"])

    @staticmethod
    def calculate_base_damage(stats) -> float:
        # فرمول بر اساس استت‌های پایه
        return (
            (stats.strength or 10) * 2 +
            (stats.speed or 10) * 1.5 +
            (stats.mana or 10) * 0.3
        )

    @staticmethod
    def clamp(value, low, high):
        return max(low, min(value, high))

    @classmethod
    def resolve_attack(cls, attacker, defender):
        a_profile = cls.get_action_profile(attacker.option)
        d_profile = cls.get_action_profile(defender.option)

        # محاسبه شانس برخورد (Hit Chance)
        speed_advantage = (attacker.stats.speed - defender.stats.speed) / 300
        luck_advantage = (attacker.stats.luck - defender.stats.luck) / 200
        
        hit_chance = 0.75 + speed_advantage + luck_advantage
        hit_chance = (hit_chance * a_profile["hit"]) / d_profile["evade"]
        hit_chance = cls.clamp(hit_chance, 0.05, 0.95)

        if rnd.random() > hit_chance:
            return {"hit": False, "damage": 0, "hit_chance": hit_chance}

        # محاسبه آسیب نهایی
        effective_defense = defender.stats.defense * d_profile["defense"]
        raw_damage = (attacker.base_damage * a_profile["damage_out"] * d_profile["damage_taken"])
        
        # اعمال Intelligence Bonus (مثال)
        intel_bonus = 1 + cls.clamp(attacker.stats.intelligence / 2500, 0, 0.20)
        final_damage = (raw_damage * intel_bonus) - effective_defense
        
        # تضمین حداقل دمیج بر اساس پروفایل اکشن
        hp_damage = max(final_damage, a_profile["min_damage"])

        # محاسبات شانس کریتیکال
        crit_chance = cls.clamp(attacker.stats.luck / 200, 0.05, 0.30)
        is_crit = rnd.random() <= crit_chance
        if is_crit:
            hp_damage *= (1.35 + cls.clamp(attacker.stats.intelligence / 5000, 0, 0.15))

        return {
            "hit": True,
            "critical": is_crit,
            "damage": round(hp_damage, 2),
            "hit_chance": round(hit_chance, 4)
        }
