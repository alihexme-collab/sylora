from workers.tick import *
import asyncio
async def gg(**data):
    print(data)

bus.listen("TICK", gg)

async def main():
    await asyncio.create_task(tick.tick())

asyncio.run(main())