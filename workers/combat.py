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
        chat_id = data.get("chat_id") or getattr(player, "telegram_id", None)
        enemy_type = data.get("enemy_type", "npc")
        enemy_count = data.get("enemy_count", 1)
        character_id= data.get("character_id")
        player_id = data.get("player_id")

        async with get_db() as session:
            query=select(Character).where(Character.character_id == character_id)
            result = await session.execute(query)
            hero= result.scalar_one_or_none()

            if enemy_type == 'npc':
                query=select(Npc).where(Npc.npc_id == enemy_id)
            elif enemy_type == "enemy":
                query=select(Enemy).where(Enemy.enemy_id == enemy_id)
            else:
                query=select(Character).where(Character.character_id == enemy_id)
            result = await session.execute(query)
            emy= result.scalar_one_or_none()
        session = CombatSession(
            player_id=player_id,
            enemy=emy,
            hero=hero,
            message=message,
            chat_id=chat_id,
            enemy_type=enemy_type,
            enemy_count=enemy_count,
        )
        await session.calculate()



class CombatSession:
    def __init__(self, player_id, hero, enemy, message, chat_id, enemy_type="npc", enemy_count=1):
        self.hero = hero
        self.enemy = enemy
        self.message = message
        self.chat_id = chat_id
        self.enemy_type = enemy_type
        self.enemy_count = max(1, int(enemy_count or 1))
        self.details = {}
        self.player_id = player_id

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

                case "Postion":
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

            print()
            print("-" * 100)
            print(f"Hero: {self.hero} vs Enemy: {self.enemy} x{self.enemy_count}")
            print("-" * 100)

            self.base_hero_energy = self.hero_stats.energy
            self.base_hero_mana = self.hero_stats.mana
            self.base_hero_hp = self.hero_stats.hp

            self.base_enemy_energy = self.enemy_stats.energy
            self.base_enemy_mana = self.enemy_stats.mana
            self.base_enemy_hp = self.enemy_stats.hp

            self.luck()
            self.set_powers()

            self.count = 0
            while (
                self.hero_stats.energy > 0
                and self.enemy_stats.energy > 0
                and self.hero_stats.hp > 0
                and self.enemy_stats.hp > 0
            ):
                await self.costs()
                self.luck()
                self.set_powers()
                self.count += 1
            if self.hero_stats.hp < 0:
                self.hero_stats.hp = 0
            if self.enemy_stats.hp < 0:
                self.enemy_stats.hp = 0
            
            loc = select(Location).where(Location.location_id == self.hero.character_path)
            loc = await session.execute(loc)
            loc = loc.scalar_one_or_none()
            await self.session.commit()
        winner = self.hero if self.enemy_stats.hp <= 0 else self.enemy
        loser = self.enemy if winner == self.hero else self.hero

        await bus.emit(
            "GENERATE_COMBAT_STORY",
            player_id=self.chat_id,
            chat_id=self.chat_id,
            hero=self.hero,
            winner=winner,
            loser=loser,
            details=self.details,
            message=self.message,
            location=loc.name,
            hero_stats=self.hero_stats,
            enemy_stats=self.enemy_stats,
            hro=self.hero.name,
            emy=self.enemy.name,
            enemy_count=self.enemy_count
        )
        winner = "hero" if self.enemy_stats.hp <= 0 else "enemy"
        loser = "enemy" if winner == self.hero else "hero"

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
        hero_total_power = (
            self.hero_stats.strength +
            self.hero_stats.speed +
            self.hero_stats.mana
        )

        enemy_total_power = (
            self.enemy_stats.strength +
            self.enemy_stats.speed +
            self.enemy_stats.mana
        )

        hero_mana_ratio = self.hero_stats.mana / max(1, hero_total_power)
        enemy_mana_ratio = self.enemy_stats.mana / max(1, enemy_total_power)

        hero_intelligence = getattr(self.hero_stats, "intelligence", 0) or 0
        enemy_intelligence = getattr(self.enemy_stats, "intelligence", 0) or 0

        hero_mana_ratio *= 1 + hero_intelligence / 5000
        enemy_mana_ratio *= 1 + enemy_intelligence / 5000

        hero_mana_ratio = min(hero_mana_ratio, 0.9)
        enemy_mana_ratio = min(enemy_mana_ratio, 0.9)

        hero_energy_ratio = 1 - hero_mana_ratio
        enemy_energy_ratio = 1 - enemy_mana_ratio

        hero_energy_cost = self.hero_damage * hero_energy_ratio * 0.02
        hero_mana_cost = self.hero_damage * hero_mana_ratio * 0.02
        hero_hp_cost = max(
            self.enemy_damage - self.hero_stats.defense,
            20
        )

        enemy_energy_cost = self.enemy_damage * enemy_energy_ratio * 0.02
        enemy_mana_cost = self.enemy_damage * enemy_mana_ratio * 0.02
        enemy_defense = getattr(self.enemy_stats, "defense", 0) or 0

        enemy_hp_cost = max(
            self.hero_damage - enemy_defense,
            20
        )

        hero_energy_cost *= 100 / (100 + self.hero_stats.defense)
        enemy_energy_cost *= 100 / (100 + enemy_defense)

        if rnd.randint(1, 50) <= self.hero_stats.luck:
            hero_energy_cost *= 0.75
            hero_mana_cost *= 0.75
            hero_hp_cost *= 0.75

        if rnd.randint(1, 50) <= self.enemy_stats.luck:
            enemy_energy_cost *= 0.75
            enemy_mana_cost *= 0.75
            enemy_hp_cost *= 0.75

        self.hero_stats.energy -= hero_energy_cost
        self.hero_stats.mana -= hero_mana_cost
        self.hero_stats.hp -= hero_hp_cost
        self.enemy_stats.energy -= enemy_energy_cost
        self.enemy_stats.mana -= enemy_mana_cost
        self.enemy_stats.hp -= enemy_hp_cost


        self.details = {
            "rounds" : self.count,
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


combat = Combat()

bus.listen("COMBAT", combat.start)
