import asyncio
from sqlalchemy import select
from database.db_manager import get_db
from database.model import EnemyStats


def scale(value, factor, minimum=1):
    if value is None:
        return minimum
    return max(int(value * factor), minimum)


async def rebalance_enemy_stats():

    async with get_db() as session:

        result = await session.execute(select(EnemyStats))
        enemies = result.scalars().all()

        for e in enemies:

            # scale factor
            factor = 0.08

            e.strength = scale(e.strength, factor)
            e.speed = scale(e.speed, factor)
            e.mana = scale(e.mana, factor)
            e.energy = scale(e.energy, factor)
            e.hp = scale(e.hp, factor)
            e.luck = scale(e.luck, factor)

            e.base_hp = scale(e.base_hp, factor)
            e.base_mana = scale(e.base_mana, factor)
            e.base_energy = scale(e.base_energy, factor)

        await session.commit()

        print(f"{len(enemies)} enemy stats rebalanced")


if __name__ == "__main__":
    asyncio.run(rebalance_enemy_stats())
