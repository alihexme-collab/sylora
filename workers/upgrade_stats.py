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
            "base_hp",
            "base_mana",
            "base_energy",
        ]
        costs = {}
        for stat in  stats:
            item = self.calc_cost(stat)
            if item[1]:
                costs.update({stat: [item, True]})
            else:
                costs.update({stat: [item, False]})
        total_stats = self.get_total_stats()
        reqire_level = 100 + (self.stats.level - 1) * 40
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
            "base_hp": 10,
            "base_mana": 8,
            "base_energy": 9,
        }
        base = base_costs.get(stat_name, 10)
        cost = base + (value // 5) * 5
        return cost, cost < self.stats.exp
        
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


upg = UpgradeRequest()
bus.listen("UPGRADE", upg.get)