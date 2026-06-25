from sqlalchemy import select
from database.db_manager import get_db
from database.model import *
from .bus import bus
from sqlalchemy import func, cast, Integer, desc


class Move:
    async def make(self, **data):
        self.chat_id = data.get("chat_id")
        self.message = data.get("message")
        await self.find_nearby_places()

    async def move(self, **data):
        self.chat_id = data.get("chat_id")
        self.message = data.get("message")
        data = data.get("data")

        loc = data.split(":")[1]
        async with get_db() as self.session:
            character: Character = await self.get_character()
            if self.stats.energy >= 20:
                self.stats.energy -= 20
                character.character_path = loc
                loc = await self.session.execute(
                    select(Location).where(Location.location_id == loc)
                )
                loc = loc.scalar_one_or_none()
            else:
                await bus.emit(
                    "SEND",
                    player_id=self.chat_id,
                    message=self.message,
                    chat_id=self.chat_id,
                    text=f"شما انرژی کافی برای رفتن به {loc.name} ندارید"
                )


        await bus.emit(
            "GENERATE_WELCOME_LOCATION",
            player_id=self.chat_id,
            chat_id=self.chat_id,
            message=self.message,
            loc=loc,
            char=character
        )



    async def find_nearby_places(self):
        async with get_db() as self.session:
            char: Character = await self.get_character()
            curr_loc = char.character_path  # مثلا: loc_abyss_012
            
            # استخراج بخش ریجن و شماره از مکان فعلی
            # فرض بر این است که فرمت همیشه loc_REGION_NUMBER است
            parts = curr_loc.split('_')
            region_name = parts[1] # abyss
            curr_num = int(parts[2]) # 12

    
            # کوئری برای پیدا کردن مکان‌های همان ریجن، به جز مکان فعلی
            # مرتب شده بر اساس کمترین فاصله عددی
            query = (
                select(Location)
                .where(
                    Location.location_id.like(f"loc_{region_name}_%"), # فقط در همین ریجن
                    Location.location_id != curr_loc # خودش نباشد
                )
                .order_by(
                    func.abs(
                        cast(func.split_part(Location.location_id, '_', 3), Integer) - curr_num
                    ).asc()
                )
                .limit(4) # حداکثر ۴ مورد نزدیک را بیاورد
            )
            
            result = await self.session.execute(query)
            nearby_locations = result.scalars().all()
            
            buttons = []
            for loc in nearby_locations:
                buttons.append(
                    {
                        "text": loc.name,
                        "callback" : f"move_to:{loc.location_id}"
                    }
                )
        await bus.emit(
            "GENERATE_MOVE_CHOICES",
            player_id=self.chat_id,
            chat_id=self.chat_id,
            message=self.message,
            buttons=buttons
        )



    async def get_character(self):
        
        player = await self.session.execute(
            select(Player).where(Player.telegram_id == self.chat_id)
        )
        player = player.scalar_one_or_none()

        character =await self.session.execute(
            select(Character).where(Character.player_id == self.player.player_id)
        )
        stats = await self.session.execute(
            select(CharacterStats).where(CharacterStats.character_id == self.character.character_id)
        )
        
        self.stats = stats.scalar_one_or_none()
        return character.scalar_one_or_none()


move = Move()

bus.listen("MOVE", move.make)
bus.listen("MOVE_TO", move.move)