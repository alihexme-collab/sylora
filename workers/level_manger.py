from database.model import *

class LevelManager:
    @classmethod
    def manage(
        cls,
        stats: CharacterStats | EnemyStats | NpcStats
    ):
        calc_inc_value = lambda stat, level: max(stat * .5, 1) + max(level * .5, 1)
        level = stats.level
        exp = stats.exp
        require_exp = cls.get_required_total_for_level(level)
        values = {
            "strength" : stats.strength,
            "speed" : stats.speed,
            "defense" : stats.defense,
            "base_hp" : stats.base_hp,
            "base_energy" : stats.base_energy,
            "base_mana" : stats.base_mana,
            "luck" : stats.luck,
            "intelligence" : getattr(stats, "intelligence", 0),
        }
        while exp >= require_exp:
            for key , value in values.items():
                values[key] += calc_inc_value(value, level)
            values.update(
                {
                    "hp" : values["base_hp"],
                    "energy" : values["base_energy"],
                    "mana" : values["base_mana"]
                }
            )
            exp -= require_exp
            level += 1
            require_exp = cls.get_required_total_for_level(level)
        values.update(
            {
                "level": level,
                "exp": current_exp
            }
        )

        return values
                

    @classmethod       
    def get_required_total_for_level(cls, level: int):
        return 100 + (level - 1) * 40