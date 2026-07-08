from .bus import bus
from database.db_manager import get_db
from database.model import (
    Player,
    Character,
    CharacterStats,
    Npc,
    NpcStats,
    Enemy,
    EnemyStats,
    Item,
    Skill,
    Location,
)
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession as Session
import random as rnd

from constants import COMBAT_ACTIONS, COMBAT_ACTION_MODIFIERS


class CombatFormula:
    @staticmethod
    def clamp(value, minimum, maximum):
        return max(minimum, min(value, maximum))

    @staticmethod
    def normalize_action(option: str) -> str:
        if option in COMBAT_ACTIONS:
            return option
        return "Normal Fight"

    @staticmethod
    def get_action_profile(option: str) -> dict:
        normalized_option = CombatFormula.normalize_action(option)
        return COMBAT_ACTION_MODIFIERS[normalized_option]

    @staticmethod
    def calc_damage(strength, speed, mana):
        return (
            strength * 2 +
            speed * 1.5 +
            mana * 0.3
        )

    @classmethod
    def resolve_attack(
        cls,
        attacker_stats,
        defender_stats,
        attacker_damage,
        attacker_option,
        defender_option,
    ):
        attacker_action = cls.get_action_profile(attacker_option)
        defender_action = cls.get_action_profile(defender_option)

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
            smart_defense_bonus = 1 + cls.clamp(defender_intelligence / 2000, 0, 0.25)
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

        hit_chance = cls.clamp(hit_chance, 0.05, 0.95)

        if rnd.random() > hit_chance:
            return {
                "hit": False,
                "critical": False,
                "blocked": False,
                "hp_damage": 0,
                "hit_chance": round(hit_chance, 4),
            }

        raw_damage = attacker_damage
        raw_damage *= attacker_action["damage_out"]
        raw_damage *= defender_action["damage_taken"]

        intelligence_damage_bonus = 1 + cls.clamp(attacker_intelligence / 2500, 0, 0.20)
        raw_damage *= intelligence_damage_bonus

        raw_damage -= effective_defense

        hp_damage = max(raw_damage, attacker_action["min_damage"])

        critical_chance = attacker_luck / 200

        if attacker_option == "Hard Fight":
            critical_chance += 0.05
        elif attacker_option == "Dodge":
            critical_chance -= 0.03

        critical_chance -= cls.clamp(defender_intelligence / 3000, 0, 0.10)
        critical_chance = cls.clamp(critical_chance, 0, 0.30)

        critical = rnd.random() <= critical_chance
        if critical:
            crit_multiplier = 1.35 + cls.clamp(attacker_intelligence / 5000, 0, 0.15)
            hp_damage *= crit_multiplier

        blocked = False
        if defender_option == "Defend":
            block_chance = (
                0.25
                + defender_defense / 1000
                + cls.clamp(defender_intelligence / 4000, 0, 0.10)
            )
            block_chance = cls.clamp(block_chance, 0.25, 0.55)

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

    @classmethod
    def calculate_resource_costs(cls, stats, base_damage, action_option, own_defense):
        total_power = cls.calc_damage(
            stats.strength,
            stats.speed,
            stats.mana
        )

        mana_ratio = stats.mana / max(1, total_power)

        intelligence = getattr(stats, "intelligence", 50) or 50
        mana_ratio *= 1 + intelligence / 5000
        mana_ratio = min(mana_ratio, 0.9)

        energy_ratio = 1 - mana_ratio
        action = cls.get_action_profile(action_option)

        energy_cost = (
            base_damage *
            energy_ratio *
            0.05 *
            action["energy_cost"]
        )

        mana_cost = (
            base_damage *
            mana_ratio *
            0.15 *
            action["mana_cost"]
        )

        energy_cost *= 100 / (100 + own_defense)

        luck_value = getattr(stats, "luck", 5) or 5
        luck_chance = cls.clamp(luck_value / 100, 0.02, 0.35)

        if rnd.random() <= luck_chance:
            energy_cost *= 0.75
            mana_cost *= 0.75

        return {
            "energy_cost": round(energy_cost, 2),
            "mana_cost": round(mana_cost, 2),
        }


class CombatItemEffect:
    @staticmethod
    def apply(item, owner_stats, owner_damage):
        if item is None:
            return owner_stats, owner_damage

        item_effect = item.effect_json or {}

        match item.type:
            case "Armor":
                owner_stats.defense += item_effect.get("defense", 0)
                owner_stats.hp += item_effect.get("hp_bonus", 0)

            case "Potion":
                target = item_effect.get("target")
                restore_value = item_effect.get("restore_value", 0)

                if target == "hp":
                    owner_stats.hp += restore_value
                elif target == "mana":
                    owner_stats.mana += restore_value
                else:
                    owner_stats.energy += restore_value

            case "Weapon":
                owner_damage += item_effect.get("damage", 0)

            case "QuestItem":
                pass

            case "Relic":
                pass

        return owner_stats, owner_damage


class Combat:
    async def start(self, **data):
        async with get_db() as session:
            session: Session = session

            combat_session = CombatSession(session=session, **data)
            await combat_session.run()


class CombatSession:
    def __init__(
        self,
        session: Session,
        player_id,
        hero=None,
        enemy=None,
        message=None,
        chat_id=None,
        character_option=None,
        enemy_option=None,
        character_id=None,
        enemy_id=None,
        enemy_type="npc",
        enemy_count=1,
        turn=1,
        details=None,
    ):
        self.session = session

        self.player_id = player_id
        self.character_id = character_id
        self.enemy_id = enemy_id
        self.enemy_type = enemy_type
        self.enemy_count = max(1, int(enemy_count or 1))
        self.turn = int(turn or 1)

        self.message = message
        self.chat_id = chat_id

        self.hero = hero
        self.enemy = enemy

        self.character_option = CombatFormula.normalize_action(character_option)
        self.enemy_option = CombatFormula.normalize_action(enemy_option)

        self.details = details or {}

        self.hero_stats = None
        self.hero_items = None
        self.hero_skills = None

        self.enemy_stats = None
        self.enemy_items = None
        self.enemy_skills = None

        self.hero_damage = 0
        self.enemy_damage = 0

    async def run(self):
        await self._load_entities_if_needed()
        if not self.hero or not self.enemy:
            return

        await self._load_stats()

        if not self.hero_stats or not self.enemy_stats:
            return

        self._scale_enemy_stats_if_needed()
        self._save_base_stats()
        self._set_powers()
        await self._apply_round_costs()

        await self.session.commit()

        location_name = await self._get_location_name()
        await self._emit_story(location_name)

        if self._is_combat_finished():
            await self._emit_finished()
        else:
            await self._emit_continue()

    async def _load_entities_if_needed(self):
        if self.chat_id is None:
            player = await self._get_player_by_telegram_id(self.player_id)
            self.chat_id = getattr(player, "telegram_id", None)

        if self.hero is None:
            self.hero = await self._get_character_by_id(self.character_id)

        if self.enemy is None:
            self.enemy = await self._get_enemy_entity(
                enemy_id=self.enemy_id,
                enemy_type=self.enemy_type,
            )

    async def _load_stats(self):
        self.hero_stats, self.hero_items, self.hero_skills = await self._get_infos(
            uid=self.hero.character_id,
            entity_type="character",
        )

        enemy_uid = self._get_enemy_uid()

        self.enemy_stats, self.enemy_items, self.enemy_skills = await self._get_infos(
            uid=enemy_uid,
            entity_type=self.enemy_type,
        )

    async def _get_player_by_telegram_id(self, player_id):
        query = select(Player).where(Player.telegram_id == player_id)
        result = await self.session.execute(query)
        return result.scalar_one_or_none()

    async def _get_character_by_id(self, character_id):
        query = select(Character).where(Character.character_id == character_id)
        result = await self.session.execute(query)
        return result.scalar_one_or_none()

    async def _get_enemy_entity(self, enemy_id, enemy_type):
        if enemy_type == "npc":
            query = select(Npc).where(Npc.npc_id == enemy_id)
        elif enemy_type == "enemy":
            query = select(Enemy).where(Enemy.enemy_id == enemy_id)
        else:
            query = select(Character).where(Character.character_id == enemy_id)

        result = await self.session.execute(query)
        return result.scalar_one_or_none()

    async def _get_infos(self, uid: str, entity_type: str):
        if entity_type == "character":
            result = await self.session.execute(
                select(CharacterStats).where(CharacterStats.character_id == uid)
            )
            stats = result.scalar_one_or_none()
            return stats, None, None

        if entity_type == "npc":
            stats_result = await self.session.execute(
                select(NpcStats).where(NpcStats.npc_id == uid)
            )
            item_result = await self.session.execute(
                select(Item).where(Item.item_id == uid.replace("npc", "item"))
            )
            skill_result = await self.session.execute(
                select(Skill).where(Skill.skill_id == uid.replace("npc", "skill"))
            )

            return (
                stats_result.scalar_one_or_none(),
                item_result.scalar_one_or_none(),
                skill_result.scalar_one_or_none(),
            )

        if entity_type == "enemy":
            result = await self.session.execute(
                select(EnemyStats).where(EnemyStats.enemy_id == uid)
            )
            stats = result.scalar_one_or_none()
            return stats, None, None

        return None, None, None

    def _get_enemy_uid(self):
        if self.enemy_type == "character":
            return self.enemy.character_id
        if self.enemy_type == "npc":
            return self.enemy.npc_id
        return self.enemy.enemy_id

    def _scale_enemy_stats_if_needed(self):
        if self.enemy_count <= 1 or not self.enemy_stats:
            return

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

    def _save_base_stats(self):
        self.base_hero_energy = self.hero_stats.energy
        self.base_hero_mana = self.hero_stats.mana
        self.base_hero_hp = self.hero_stats.hp

        self.base_enemy_energy = self.enemy_stats.energy
        self.base_enemy_mana = self.enemy_stats.mana
        self.base_enemy_hp = self.enemy_stats.hp

    def _set_powers(self):
        self.hero_damage = CombatFormula.calc_damage(
            self.hero_stats.strength,
            self.hero_stats.speed,
            self.hero_stats.mana,
        )
        self.hero_stats, self.hero_damage = CombatItemEffect.apply(
            self.hero_items,
            self.hero_stats,
            self.hero_damage,
        )

        self.enemy_damage = CombatFormula.calc_damage(
            self.enemy_stats.strength,
            self.enemy_stats.speed,
            self.enemy_stats.mana,
        )
        self.enemy_stats, self.enemy_damage = CombatItemEffect.apply(
            self.enemy_items,
            self.enemy_stats,
            self.enemy_damage,
        )

    async def _apply_round_costs(self):
        hero_defense = getattr(self.hero_stats, "defense", 50) or 50
        enemy_defense = getattr(self.enemy_stats, "defense", 50) or 50

        hero_attack = CombatFormula.resolve_attack(
            attacker_stats=self.hero_stats,
            defender_stats=self.enemy_stats,
            attacker_damage=self.hero_damage,
            attacker_option=self.character_option,
            defender_option=self.enemy_option,
        )

        enemy_attack = CombatFormula.resolve_attack(
            attacker_stats=self.enemy_stats,
            defender_stats=self.hero_stats,
            attacker_damage=self.enemy_damage,
            attacker_option=self.enemy_option,
            defender_option=self.character_option,
        )

        hero_costs = CombatFormula.calculate_resource_costs(
            stats=self.hero_stats,
            base_damage=self.hero_damage,
            action_option=self.character_option,
            own_defense=hero_defense,
        )

        enemy_costs = CombatFormula.calculate_resource_costs(
            stats=self.enemy_stats,
            base_damage=self.enemy_damage,
            action_option=self.enemy_option,
            own_defense=enemy_defense,
        )

        self.hero_stats.energy = max(0, self.hero_stats.energy - hero_costs["energy_cost"])
        self.hero_stats.mana = max(0, self.hero_stats.mana - hero_costs["mana_cost"])
        self.hero_stats.hp = max(0, self.hero_stats.hp - enemy_attack["hp_damage"])

        self.enemy_stats.energy = max(0, self.enemy_stats.energy - enemy_costs["energy_cost"])
        self.enemy_stats.mana = max(0, self.enemy_stats.mana - enemy_costs["mana_cost"])
        self.enemy_stats.hp = max(0, self.enemy_stats.hp - hero_attack["hp_damage"])

        self.details = self._build_details(hero_attack, enemy_attack)

    def _build_details(self, hero_attack, enemy_attack):
        total_hero_energy_costs = (
            self.details.get("Total-hero-costs", {}).get("energy", 0)
            + self.base_hero_energy
            - self.hero_stats.energy
        )
        total_hero_mana_costs = (
            self.details.get("Total-hero-costs", {}).get("mana", 0)
            + self.base_hero_mana
            - self.hero_stats.mana
        )
        total_hero_hp_costs = (
            self.details.get("Total-hero-costs", {}).get("hp", 0)
            + self.base_hero_hp
            - self.hero_stats.hp
        )

        total_enemy_energy_costs = (
            self.details.get("Total-enemy-costs", {}).get("energy", 0)
            + self.base_enemy_energy
            - self.enemy_stats.energy
        )
        total_enemy_mana_costs = (
            self.details.get("Total-enemy-costs", {}).get("mana", 0)
            + self.base_enemy_mana
            - self.enemy_stats.mana
        )
        total_enemy_hp_costs = (
            self.details.get("Total-enemy-costs", {}).get("hp", 0)
            + self.base_enemy_hp
            - self.enemy_stats.hp
        )

        return {
            "turn": self.turn,
            "options": {
                "hero": self.character_option,
                "enemy": self.enemy_option,
            },
            "attacks": {
                "hero": hero_attack,
                "enemy": enemy_attack,
            },
            "Total-hero-costs": {
                "energy": round(total_hero_energy_costs, 2),
                "mana": round(total_hero_mana_costs, 2),
                "hp": round(total_hero_hp_costs, 2),
            },
            "Total-enemy-costs": {
                "energy": round(total_enemy_energy_costs, 2),
                "mana": round(total_enemy_mana_costs, 2),
                "hp": round(total_enemy_hp_costs, 2),
            },
        }

    def _is_combat_finished(self):
        hero_finished = self.hero_stats.hp <= 0 or self.hero_stats.energy <= 10
        enemy_finished = self.enemy_stats.hp <= 0 or self.enemy_stats.energy <= 10
        return hero_finished or enemy_finished

    def _resolve_winner(self):
        if self.hero_stats.hp <= 0 or self.hero_stats.energy <= 0:
            return "enemy", "hero"

        if self.enemy_stats.hp <= 0 or self.enemy_stats.energy <= 0:
            return "hero", "enemy"

        if self.hero_stats.hp > self.enemy_stats.hp:
            return "hero", "enemy"

        return "enemy", "hero"

    async def _get_location_name(self):
        query = select(Location).where(Location.location_id == self.hero.character_path)
        result = await self.session.execute(query)
        loc = result.scalar_one_or_none()
        return loc.name if loc else None

    async def _emit_story(self, location_name):
        await bus.emit(
            "GENERATE_COMBAT_STORY",
            player_id=self.player_id,
            chat_id=self.chat_id,
            hero=self.hero,
            details=self.details,
            message=self.message,
            location=location_name,
            hero_stats=self.hero_stats,
            enemy_stats=self.enemy_stats,
            hro=self.hero.name,
            emy=self.enemy.name,
            enemy_count=self.enemy_count,
        )

    async def _emit_finished(self):
        winner, loser = self._resolve_winner()

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
            turn=self.turn,
        )

    async def _emit_continue(self):
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
            turn=self.turn + 1,
            details=self.details,
        )


combat = Combat()
bus.listen("COMBAT", combat.start)
