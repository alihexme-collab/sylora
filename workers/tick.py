from .bus import bus
import asyncio
import json
from pathlib import Path
from datetime import datetime, timedelta

class Tick:
    def __init__(self, ye=3033, mo=9, da=16, ho=7, mi=30, se=25):
        self.file_path = Path("tick.json")

        if self.file_path.exists():
            with self.file_path.open("r") as file:
                self.data = json.load(file)
        else:
            self.data = {
                "ye": ye,
                "mo": mo,
                "da": da,
                "ho": ho,
                "mi": mi,
                "se": se,
            }

        self.datetime = datetime(
            self.data["ye"],
            self.data["mo"],
            self.data["da"],
            self.data["ho"],
            self.data["mi"],
            self.data["se"],
        )

    async def tick(self):
        while True:
            await asyncio.sleep(300)

            self.datetime += timedelta(minutes=2.5)

            self.data = {
                "ye": self.datetime.year,
                "mo": self.datetime.month,
                "da": self.datetime.day,
                "ho": self.datetime.hour,
                "mi": self.datetime.minute,
                "se": self.datetime.second,
            }

            with self.file_path.open("w") as file:
                json.dump(self.data, file)

            print(self.datetime.strftime("%D %H:%M"))

            await bus.emit(
                "TICK",
                player_id=0,
                datatime=self.data,
            )

tick = Tick()
