from .bus import bus
from database.db_manager import get_db
from database.model import *
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession as Session


class UpgradeRequest:
    async def get(self, **data):
        self.chat_id = data.get("chat_id")
        self.message = data.get("message")
        await self._create()

    async def _get_infos(self):
        async with get_db() as session:
            session: Session
            player = select(Player).where(Player.telegram_id == self.chat_id)
            player = await session.execute(player)
            self.player = player.scalar_one_or_none()

            character = select(Character).where(Character.player_id == self.player.player_id)
            character = await session.execute(character)
            self.character = character.scalar_one_or_none()

            stats = select(CharacterStats).where(CharacterStats.character_id == self.character.character_id)
            stats = await session.execute(stats)
            self.stats = stats.scalar_one_or_none()

    async def _create(self):
        await self._get_infos()
        stats = [
            "strength",
            "speed",
            "defense",
            "intelligence",
            "luck",
            "hp",
            "mana",
            "energy",
        ]
        costs = {}
        for stat in  stats:
            item = self.calc_cost(stat)
            if item is not None:
                costs.update({stat: item})
        total_stats = self.get_total_stats()
        reqire_level = self.get_required_total_for_level(self.stats.level)
        print("SHOW_UPGADE_COSTS")
        await bus.emit(
            "SHOW_UPGADE_COSTS",
            player_id=self.chat_id,
            message=self.message,
            costs=costs,
            stats=self.stats,
            total_stats=total_stats,
            reqire_level=reqire_level
        )
        
    
    def calc_cost(self, stat_name):
        value = getattr(self.stats, stat_name)
        base_costs = {
            "strength": 15,
            "speed": 13,
            "defense": 14,
            "intelligence": 12,
            "luck": 11,
            "charisma": 14,
            "hp": 10,
            "mana": 8,
            "energy": 9,
        }
        base = base_costs.get(stat_name, 10)
        cost = base + (value // 5) * 5
        if cost < self.stats.exp:
            return cost
        
    def get_total_stats(self):
        return (
            self.stats.hp +
            self.stats.mana +
            self.stats.energy +
            self.stats.strength +
            self.stats.speed +
            self.stats.defense +
            self.stats.intelligence +
            self.stats.luck
        )



# class StatsUpgradeService:
#     def __init__(self, db, bus, player, character, stats, message):
#         self.db = db
#         self.bus = bus
#         self.player = player
#         self.character = character
#         self.stats = stats
#         self.message = message

#     def get_total_stats(self):
#         return (
#             self.stats.health +
#             self.stats.mana +
#             self.stats.energy +
#             self.stats.strength +
#             self.stats.speed +
#             self.stats.defense +
#             self.stats.intelligence +
#             self.stats.luck
#         )

#     def get_required_total_for_level(self, level):
#         return 100 + (level - 1) * 40

#     def calc_cost(self, stat_name):
#         value = getattr(self.stats, stat_name)
#         base_costs = {
#             "strength": 10,
#             "speed": 10,
#             "defense": 12,
#             "intelligence": 12,
#             "luck": 15,
#             "charisma": 14,
#             "health": 8,
#             "mana": 8,
#             "energy": 8,
#         }
#         base = base_costs.get(stat_name, 10)
#         return base + (value // 5) * 5

#     def can_upgrade(self, stat_name):
#         cost = self.calc_cost(stat_name)
#         return self.stats.experience >= cost

#     async def apply_upgrade(self, stat_name):
#         cost = self.calc_cost(stat_name)
#         if self.stats.experience < cost:
#             return False, "XP کافی نیست"

#         setattr(self.stats, stat_name, getattr(self.stats, stat_name) + 1)
#         self.stats.experience -= cost

#         leveled_up = await self.check_level_up()

#         await self.db.commit()
#         return True, leveled_up

#     async def check_level_up(self):
#         total = self.get_total_stats()
#         required = self.get_required_total_for_level(self.stats.level)

#         if total >= required:
#             self.stats.level += 1
#             return True

#         return False

        

upg = UpgradeRequest()
bus.listen("UPGRADE", upg.get)