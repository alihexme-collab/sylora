STAT_GROWTH_WEIGHTS = {
    "strength": 1.5,
    "speed": 1.5,
    "defense": 1.5,
    "intelligence": 1.0,
    "luck": 1.0,
    "base_hp": 5.0,
    "base_energy": 5.0,
    "base_mana": 5.0
}

COMBAT_ACTIONS = (
    "Hard Fight",
    "Normal Fight",
    "Dodge",
    "Defend",
)

COMBAT_ACTION_MODIFIERS = {
    "Hard Fight": {
        "damage_out": 1.35,
        "damage_taken": 1.15,
        "hit": 1.10,
        "evade": 0.65,
        "defense": 0.85,
        "energy_cost": 1.45,
        "mana_cost": 1.15,
        "min_damage": 25,
    },
    "Normal Fight": {
        "damage_out": 1.0,
        "damage_taken": 1.0,
        "hit": 1.0,
        "evade": 1.0,
        "defense": 1.0,
        "energy_cost": 1.0,
        "mana_cost": 1.0,
        "min_damage": 20,
    },
    "Dodge": {
        "damage_out": 0.55,
        "damage_taken": 0.70,
        "hit": 0.75,
        "evade": 1.90,
        "defense": 1.05,
        "energy_cost": 0.85,
        "mana_cost": 0.75,
        "min_damage": 5,
    },
    "Defend": {
        "damage_out": 0.70,
        "damage_taken": 0.55,
        "hit": 0.90,
        "evade": 0.85,
        "defense": 1.75,
        "energy_cost": 0.65,
        "mana_cost": 0.65,
        "min_damage": 8,
    },
}
