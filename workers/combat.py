from .bus import bus
from database.db_manager import get_db
from database.model import *
from sqlalchemy import select
import random as rnd
from sqlalchemy.ext.asyncio import AsyncSession as Session

class Combat:
    async def start(self, **data):
        enemy_id = data.get("enemy_id")
        message = data.get("message")
        enemy_type = data.get("enemy_type", "npc")
        enemy_count = data.get("enemy_count", 1)
        character_id = data.get("character_id")
        player_id = data.get("player_id")
        character_option = data.get("character_option")
        enemy_option = data.get("enemy_option")

        async with get_db() as session:
            player_query = select(Player).where(Player.telegram_id == player_id)
            player_result = await session.execute(player_query)
            player = player_result.scalar_one_or_none()

            chat_id = getattr(player, "telegram_id", None)

            query = select(Character).where(Character.character_id == character_id)
            result = await session.execute(query)
            hero = result.scalar_one_or_none()

            if enemy_type == "npc":
                query = select(Npc).where(Npc.npc_id == enemy_id)
            elif enemy_type == "enemy":
                query = select(Enemy).where(Enemy.enemy_id == enemy_id)
            else:
                query = select(Character).where(Character.character_id == enemy_id)

            result = await session.execute(query)
            emy = result.scalar_one_or_none()

        session = CombatSession(
            player_id=player_id,
            enemy=emy,
            hero=hero,
            message=message,
            chat_id=chat_id,
            enemy_type=enemy_type,
            enemy_count=enemy_count,
            character_option=character_option,
            enemy_option=enemy_option,
            character_id=character_id,
            enemy_id=enemy_id,
        )
        await session.calculate()




class CombatSession:
    def __init__(self, 
                 player_id, 
                 hero, 
                 enemy, 
                 message, 
                 chat_id, 
                 character_option,
                 enemy_option,
                 character_id,
                 enemy_id,
                 enemy_type="npc", 
                 enemy_count=1,
                 ):
        self.OPTIONS = {
            "Hard Fight",
            "Normal Fight",
            "Dodge",
            "Defend",
        }

        self.ACTION_PROFILES = {
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

        self.hero = hero
        self.enemy = enemy
        self.message = message
        self.chat_id = chat_id
        self.enemy_type = enemy_type
        self.enemy_count = max(1, int(enemy_count or 1))
        self.details = {}
        self.player_id = player_id
        self.character_option = character_option if character_option in self.OPTIONS else "Normal Fight"
        self.enemy_option = enemy_option if enemy_option in self.OPTIONS else "Normal Fight"

        self.character_id = character_id
        self.enemy_id = enemy_id


    async def _get_infos(self, uid: str, entity_type: str):
            if entity_type == "hero":
                get_target = await self.session.execute(
                    select(Character).where(Character.player_id == uid)
                )
                target = get_target.scalar_one_or_none()
                get_target = await self.session.execute(
                    select(CharacterStats).where(CharacterStats.character_id == target.character_id)
                )
                target = get_target.scalar_one_or_none()
                return target, None, None

            if entity_type == "character":
                get_target = await self.session.execute(
                    select(CharacterStats).where(CharacterStats.character_id == uid)
                )
                target = get_target.scalar_one_or_none()
                return target, None, None

            if entity_type == "npc":
                get_target = await self.session.execute(
                    select(NpcStats).where(NpcStats.npc_id == uid)
                )
                target = get_target.scalar_one_or_none()

                get_target_item = select(Item).where(
                    Item.item_id == uid.replace("npc", "item")
                )
                get_target_skill = select(Skill).where(
                    Skill.skill_id == uid.replace("npc", "skill")
                )

                item_result = await self.session.execute(get_target_item)
                skill_result = await self.session.execute(get_target_skill)

                return (
                    target,
                    item_result.scalar_one_or_none(),
                    skill_result.scalar_one_or_none(),
                )

            if entity_type == "enemy":
                get_target = await self.session.execute(
                    select(EnemyStats).where(EnemyStats.enemy_id == uid)
                )
                target = get_target.scalar_one_or_none()
                return target, None, None

            return None, None, None
           

    async def _set_stats(self):
        hero_info = await self._get_infos(self.hero.player_id, "hero")

        self.hero_stats, self.hero_items, self.hero_skills= hero_info

        if self.enemy_type == "character":
            enemy_uid = self.enemy.character_id
        elif self.enemy_type == "npc":
            enemy_uid = self.enemy.npc_id
        else:
            enemy_uid = self.enemy.enemy_id

        enemy_info = await self._get_infos(enemy_uid, self.enemy_type)

        self.enemy_stats, self.enemy_items, self.enemy_skills = enemy_info

        if self.enemy_count > 1 and self.enemy_stats:
            scale = self.enemy_count

            self.enemy_stats.energy = int(self.enemy_stats.energy * scale)
            self.enemy_stats.mana = int(self.enemy_stats.mana * scale)
            self.enemy_stats.hp = int(self.enemy_stats.hp * (1 + (0.4 * (scale - 1))))

            self.enemy_stats.strength = int(
                self.enemy_stats.strength * (1 + (0.2 * (scale - 1)))
            )
            if hasattr(self.enemy_stats, "defense"):
                self.enemy_stats.defense = int(
                    self.enemy_stats.defense * (1 + (0.15 * (scale - 1)))
                )


    def _allow_items_effect(self, item, owner_stats, owner_damage):
        if item is not None:
            item_effect = item.effect_json

            match item.type:
                case "Armor":
                    owner_stats.defense += item_effect["defense"]
                    owner_stats.hp += item_effect["hp_bonus"]

                case "Potion":
                    if item_effect["target"] == "hp":
                        owner_stats.hp += item_effect["restore_value"]
                    elif item_effect["target"] == "mana":
                        owner_stats.mana += item_effect["restore_value"]
                    else:
                        owner_stats.energy += item_effect["restore_value"]

                case "QuestItem":
                    pass

                case "Relic":
                    pass

                case "Weapon":
                    owner_damage += item_effect["damage"]

        return owner_stats, owner_damage

    async def calculate(self):
        async with get_db() as session:
            session: Session = session
            self.session = session
            await self._set_stats()

            if not self.hero_stats or not self.enemy_stats:
                return

            self.base_hero_energy = self.hero_stats.energy
            self.base_hero_mana = self.hero_stats.mana
            self.base_hero_hp = self.hero_stats.hp

            self.base_enemy_energy = self.enemy_stats.energy
            self.base_enemy_mana = self.enemy_stats.mana
            self.base_enemy_hp = self.enemy_stats.hp

            self.turn = 1

            self.luck()
            self.set_powers()
            await self.costs()
            await self.session.commit() 
            hero_finished = self.hero_stats.hp <= 0 or self.hero_stats.energy <= 0
            enemy_finished = self.enemy_stats.hp <= 0 or self.enemy_stats.energy <= 0

            if hero_finished or enemy_finished:
                if self.hero_stats.hp <= 0 or self.hero_stats.energy <= 0:
                    winner = "enemy"
                    loser = "hero"
                elif self.enemy_stats.hp <= 0 or self.enemy_stats.energy <= 0:
                    winner = "hero"
                    loser = "enemy"
                else:
                    if self.hero_stats.hp > self.enemy_stats.hp:
                        winner = "hero"
                        loser = "enemy"
                    else:
                        winner = "enemy"
                        loser = "hero"
                await bus.emit(
                    "GENERATE_COMBAT_STORY",
                    player_id=self.player_id,
                    chat_id=self.chat_id,
                    hero=self.hero,
                    details=self.details,
                    message=self.message,
                    location=loc.name if loc else None,
                    hero_stats=self.hero_stats,
                    enemy_stats=self.enemy_stats,
                    hro=self.hero.name,
                    emy=self.enemy.name,
                    enemy_count=self.enemy_count,
                )

                await bus.emit(
                    "COMBAT_FINISHED",
                    player_id=self.player_id,
                    enemy=self.enemy,
                    enemy_type=self.enemy_type,
                    enemy_count=self.enemy_count,
                    winner=winner,
                    loser=loser,
                    details=self.details,
                    hero_stats=self.hero_stats,
                    enemy_stats=self.enemy_stats,
                    message=self.message,
                    chat_id=self.chat_id,
                )
            else:
                loc = select(Location).where(Location.location_id == self.hero.character_path)
                loc = await session.execute(loc)
                loc = loc.scalar_one_or_none()

                await self.session.commit()

                await bus.emit(
                    "GENERATE_COMBAT_STORY",
                    player_id=self.player_id,
                    chat_id=self.chat_id,
                    hero=self.hero,
                    details=self.details,
                    message=self.message,
                    location=loc.name if loc else None,
                    hero_stats=self.hero_stats,
                    enemy_stats=self.enemy_stats,
                    hro=self.hero.name,
                    emy=self.enemy.name,
                    enemy_count=self.enemy_count,
                )

                await bus.emit(
                    "START_COMBAT",
                    player_id=self.player_id,
                    chat_id=self.chat_id,
                    enemy_id=self.enemy_id,
                    enemy_type=self.enemy_type,
                    enemy_count=self.enemy_count,
                    message=self.message,
                    character_id=self.character_id,
                    enemy_option=self.enemy_option,
                    character_option=self.character_option,
                )

    def luck(self):
        self.hero_luck = rnd.randint(1, max(1, int(self.hero_stats.luck)))
        self.enemy_luck = rnd.randint(1, max(1, int(self.enemy_stats.luck)))

    def set_powers(self):
        self.hero_damage = self.calc_damage(*self.power_args("HERO"))

        if self.hero_items is not None:
            self.hero_stats, self.hero_damage = self._allow_items_effect(
                self.hero_items,
                self.hero_stats,
                self.hero_damage
            )

        self.enemy_damage = self.calc_damage(*self.power_args("ENEMY"))

        if self.enemy_items is not None:
            self.enemy_stats, self.enemy_damage = self._allow_items_effect(
                self.enemy_items,
                self.enemy_stats,
                self.enemy_damage
            )

    def calc_damage(self, strength, speed, mana):
        return (
            strength * 2 +
            speed * 1.5 +
            mana * 0.3
        )

    def power_args(self, owner_type):
        if owner_type == "HERO":
            return (
                self.hero_stats.strength,
                self.hero_stats.speed,
                self.hero_stats.mana,
            )

        return (
            self.enemy_stats.strength,
            self.enemy_stats.speed,
            self.enemy_stats.mana,
        )

    async def costs(self):
        hero_total_power = self.calc_damage(
            self.hero_stats.strength,
            self.hero_stats.speed,
            self.hero_stats.mana
        )

        enemy_total_power = self.calc_damage(
            self.enemy_stats.strength +
            self.enemy_stats.speed +
            self.enemy_stats.mana
        )

        hero_mana_ratio = self.hero_stats.mana / max(1, hero_total_power)
        enemy_mana_ratio = self.enemy_stats.mana / max(1, enemy_total_power)

        hero_intelligence = getattr(self.hero_stats, "intelligence", 50) or 50
        enemy_intelligence = getattr(self.enemy_stats, "intelligence", 50) or 50

        hero_mana_ratio *= 1 + hero_intelligence / 5000
        enemy_mana_ratio *= 1 + enemy_intelligence / 5000

        hero_mana_ratio = min(hero_mana_ratio, 0.9)
        enemy_mana_ratio = min(enemy_mana_ratio, 0.9)

        hero_energy_ratio = 1 - hero_mana_ratio
        enemy_energy_ratio = 1 - enemy_mana_ratio

        hero_action = self._action_profile(self.character_option)
        enemy_action = self._action_profile(self.enemy_option)

        enemy_defense = getattr(self.enemy_stats, "defense", 50) or 50
        hero_defense = getattr(self.hero_stats, "defense", 50) or 50

        hero_attack = self._resolve_attack(
            attacker_stats=self.hero_stats,
            defender_stats=self.enemy_stats,
            attacker_damage=self.hero_damage,
            attacker_option=self.character_option,
            defender_option=self.enemy_option,
        )

        enemy_attack = self._resolve_attack(
            attacker_stats=self.enemy_stats,
            defender_stats=self.hero_stats,
            attacker_damage=self.enemy_damage,
            attacker_option=self.enemy_option,
            defender_option=self.character_option,
        )

        hero_energy_cost = (
            self.hero_damage *
            hero_energy_ratio *
            0.1 *
            hero_action["energy_cost"]
        )

        hero_mana_cost = (
            self.hero_damage *
            hero_mana_ratio *
            0.3 *
            hero_action["mana_cost"]
        )

        enemy_energy_cost = (
            self.enemy_damage *
            enemy_energy_ratio *
            0.1 *
            enemy_action["energy_cost"]
        )

        enemy_mana_cost = (
            self.enemy_damage *
            enemy_mana_ratio *
            0.3 *
            enemy_action["mana_cost"]
        )

        hero_energy_cost *= 100 / (100 + hero_defense)
        enemy_energy_cost *= 100 / (100 + enemy_defense)

        hero_luck_chance = self._clamp(self.hero_stats.luck / 100, 0.02, 0.35)
        enemy_luck_chance = self._clamp(self.enemy_stats.luck / 100, 0.02, 0.35)

        if rnd.random() <= hero_luck_chance:
            hero_energy_cost *= 0.75
            hero_mana_cost *= 0.75

        if rnd.random() <= enemy_luck_chance:
            enemy_energy_cost *= 0.75
            enemy_mana_cost *= 0.75


        hero_hp_cost = enemy_attack["hp_damage"]
        enemy_hp_cost = hero_attack["hp_damage"]

        self.hero_stats.energy = max(0, self.hero_stats.energy - hero_energy_cost)
        self.hero_stats.mana = max(0, self.hero_stats.mana - hero_mana_cost)
        self.hero_stats.hp = max(0, self.hero_stats.hp - hero_hp_cost)

        self.enemy_stats.energy = max(0, self.enemy_stats.energy - enemy_energy_cost)
        self.enemy_stats.mana = max(0, self.enemy_stats.mana - enemy_mana_cost)
        self.enemy_stats.hp = max(0, self.enemy_stats.hp - enemy_hp_cost)

        self.details = {
            "turn": getattr(self, "turn", 1),
            "options": {
                "hero": self.character_option,
                "enemy": self.enemy_option,
            },
            "attacks": {
                "hero": hero_attack,
                "enemy": enemy_attack,
            },
            "Total-hero-costs": {
                "energy": self.base_hero_energy - self.hero_stats.energy,
                "mana": self.base_hero_mana - self.hero_stats.mana,
                "hp": self.base_hero_hp - self.hero_stats.hp,
            },
            "Total-enemy-costs": {
                "energy": self.base_enemy_energy - self.enemy_stats.energy,
                "mana": self.base_enemy_mana - self.enemy_stats.mana,
                "hp": self.base_enemy_hp - self.enemy_stats.hp,
            }
        }

    
    def _clamp(self, value, minimum, maximum):
        return max(minimum, min(value, maximum))


    def _action_profile(self, option):
        return self.ACTION_PROFILES.get(option, self.ACTION_PROFILES["Normal Fight"])


    def _resolve_attack(
        self,
        attacker_stats,
        defender_stats,
        attacker_damage,
        attacker_option,
        defender_option,
    ):
        attacker_action = self._action_profile(attacker_option)
        defender_action = self._action_profile(defender_option)

        attacker_speed = getattr(attacker_stats, "speed", 50) or 50
        defender_speed = getattr(defender_stats, "speed", 50) or 50

        attacker_luck = getattr(attacker_stats, "luck", 5) or 5
        defender_luck = getattr(defender_stats, "luck", 5) or 5

        attacker_intelligence = getattr(attacker_stats, "intelligence", 50) or 50
        defender_intelligence = getattr(defender_stats, "intelligence", 50) or 50

        defender_defense = getattr(defender_stats, "defense", 50) or 50

        speed_advantage = attacker_speed - defender_speed
        luck_advantage = attacker_luck - defender_luck
        intelligence_advantage = attacker_intelligence - defender_intelligence

        effective_defense = defender_defense * defender_action["defense"]

        if defender_option in ("Dodge", "Defend"):
            smart_defense_bonus = 1 + self._clamp(defender_intelligence / 2000, 0, 0.25)
            effective_defense *= smart_defense_bonus

        hit_chance = 0.75
        hit_chance += speed_advantage / 300
        hit_chance += luck_advantage / 200
        hit_chance += intelligence_advantage / 1200

        hit_chance *= attacker_action["hit"]
        hit_chance /= defender_action["evade"]

        if attacker_option == "Hard Fight" and defender_option == "Dodge":
            hit_chance *= 0.75

        if attacker_option == "Hard Fight" and defender_option == "Defend":
            hit_chance *= 0.90

        if attacker_option == "Dodge":
            hit_chance *= 0.90

        hit_chance = self._clamp(hit_chance, 0.05, 0.95)

        if rnd.random() > hit_chance:
            return {
                "hit": False,
                "critical": False,
                "blocked": False,
                "hp_damage": 0,
                "hit_chance": hit_chance,
            }

        raw_damage = attacker_damage
        raw_damage *= attacker_action["damage_out"]
        raw_damage *= defender_action["damage_taken"]

        intelligence_damage_bonus = 1 + self._clamp(attacker_intelligence / 2500, 0, 0.20)
        raw_damage *= intelligence_damage_bonus

        raw_damage -= effective_defense

        hp_damage = max(raw_damage, attacker_action["min_damage"])

        critical_chance = attacker_luck / 200

        if attacker_option == "Hard Fight":
            critical_chance += 0.05
        elif attacker_option == "Dodge":
            critical_chance -= 0.03

        critical_chance -= self._clamp(defender_intelligence / 3000, 0, 0.10)
        critical_chance = self._clamp(critical_chance, 0, 0.30)

        critical = rnd.random() <= critical_chance
        if critical:
            crit_multiplier = 1.35 + self._clamp(attacker_intelligence / 5000, 0, 0.15)
            hp_damage *= crit_multiplier

        blocked = False
        if defender_option == "Defend":
            block_chance = 0.25 + defender_defense / 1000 + self._clamp(defender_intelligence / 4000, 0, 0.10)
            block_chance = self._clamp(block_chance, 0.25, 0.55)

            if rnd.random() <= block_chance:
                hp_damage *= 0.55
                blocked = True

        hp_damage = max(0, round(hp_damage, 2))

        return {
            "hit": True,
            "critical": critical,
            "blocked": blocked,
            "hp_damage": hp_damage,
            "hit_chance": round(hit_chance, 4),
            "critical_chance": round(critical_chance, 4),
            "effective_defense": round(effective_defense, 2),
        }



combat = Combat()

bus.listen("COMBAT", combat.start)
