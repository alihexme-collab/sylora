from .bus import bus
from database.db_manager import get_db
from database.model import *
from sqlalchemy import select, func
from datetime import datetime
import random as rnd


class Command:

    async def receive(self, **data):

        chat_id = data["chat_id"]
        text = data["text"]
        username = data["username"]
        name = data.get("name")
        message = data.get("message")

        cmd = text.split()[0].lower()

        match cmd:

            case "/start":
                await self.start(chat_id, username, name, message)


    async def start(self, chat_id, username, name, message):

        player_id = await self.check_exists(chat_id)

        if player_id:

            async with get_db() as session:

                hero = await session.scalar(
                    select(Character).where(Character.player_id==player_id)
                )

                stats = await session.scalar(
                    select(CharacterStats).where(
                        CharacterStats.character_id==hero.character_id
                    )
                )

        else:

            with open("number.txt") as f:
                numbers = f.readlines()

            player_id=numbers[0].strip()
            character_id=numbers[1].strip()

            async with get_db() as session:

                session.add(Player(
                    player_id=player_id,
                    telegram_id=chat_id,
                    username=username,
                    created_at=datetime.now(),
                    role="user",
                    is_banned=False
                ))

            async with get_db() as session:

                loc=await session.scalar(
                    select(Location).order_by(func.random()).limit(1)
                )

                hero=Character(
                    character_id=character_id,
                    player_id=player_id,
                    created_at=datetime.now(),
                    is_alive=True,
                    name=name,
                    race="انسان",
                    character_path=loc.location_id,
                    age=20
                )

                session.add(hero)

            async with get_db() as session:

                npc=await session.scalar(
                    select(NpcStats).order_by(func.random()).limit(1)
                )

                stats=CharacterStats(
                    character_id=character_id,
                    strength=int(npc.strength*rnd.uniform(0.9,1.1)),
                    speed=int(npc.speed*rnd.uniform(0.9,1.1)),
                    defense=int(npc.defense*rnd.uniform(0.9,1.1)),
                    intelligence=int(npc.intelligence*rnd.uniform(0.9,1.1)),
                    luck=max(1,int(npc.luck*rnd.uniform(0.9,1.1))),
                    energy=npc.energy,
                    mana=int(npc.mana*rnd.uniform(0.9,1.1)),
                    hp=int(npc.hp*rnd.uniform(0.9,1.1)),
                    exp=int(npc.exp*rnd.uniform(0.9,1.1)),
                    level=int(npc.level*rnd.uniform(0.9,1.1)),
                    hunting_points=int(npc.hunting_points*rnd.uniform(0.9,1.1)),
                    black_knowledge_level=int(npc.black_knowledge_level*rnd.uniform(0.9,1.1)),
                    gold=int(npc.gold*rnd.uniform(0.9,1.1)),
                )

                session.add(stats)

            with open("number.txt","w") as f:
                f.write(f"{int(player_id)+1}\n{int(character_id)+1}")

        print("COMMAND.start reached end")
        print("about to emit GENERATE_START")
        print("chat_id:", chat_id)
        print("message:", message)
        print("hero:", hero)
        print("stats:", stats)
        await bus.emit(
            "GENERATE_START",
            player_id=chat_id,
            chat_id=chat_id,
            username=username,
            character=hero,
            stats=stats,
            message=message
        )
        print("GENERATE_START emitted")

    async def check_exists(self,chat_id):

        async with get_db() as session:

            return await session.scalar(
                select(Player.player_id)
                .where(Player.telegram_id==chat_id)
            )


cmd=Command()

bus.listen("COMMAND",cmd.receive)
