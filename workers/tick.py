from .bus import *
import asyncio
from datetime import datetime
import json
from pathlib import Path

class Tick:
    def __init__(self, ye=3033, mo=9, da=16, ho=7, mi=30, se=25):
        file_path = Path("tick.json")
        if file_path.exists():
            with open("tick.json", "r") as file:
                self.data = json.load(
                    file
                )
        else:
            self.data = {
                "ye": ye,
                "mo": mo,
                "da": da,
                "ho": ho,
                "mi": mi,
                "se": se
            }
        self.datetime = datetime(
            self.data["ye"],
            self.data["mo"],
            self.data["da"],
            self.data["ho"],
            self.data["mi"],
            self.data["se"]
        )

    async def tick(self):
        while True:
            await asyncio.sleep(60)
            timestamp = self.datetime.timestamp()
            timestamp += 300
            self.datetime = self.datetime.fromtimestamp(timestamp)
            self.data = {
                "ye": self.datetime.year,
                "mo": self.datetime.month,
                "da": self.datetime.day,
                "ho": self.datetime.hour,
                "mi": self.datetime.minute,
                "se": self.datetime.second
            }
            with open("tick.json", "w") as file:
                json.dump(
                    self.data,
                    file
                    )
            print(self.datetime.strftime("%D %H %M"))
            await bus.emit(
                "TICK",
                player_id=0,
                data=self.data
            )

tick=Tick()