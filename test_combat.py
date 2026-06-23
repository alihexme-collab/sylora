from workers import *
import asyncio

async def main():
    await bus.emit("COMBAT", ["npc_abyss_036", "npc_arcane_171", 65436])

asyncio.run(main())