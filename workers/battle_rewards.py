from .bus import bus
from database.db_manager import get_db
from database.model import CharacterStats
from sqlalchemy import update
from game_formulas import LevelManager, ExpReward
from constants import STAT_GROWTH_WEIGHTS

class CombatRewardsProcessor:
    def __init__(self):
        self.hero_stats = None
        self.chat_id = None
        self.hero_id = None

    async def handle_combat_end(self, **data):
        """نقطه ورود از طریق Event Bus"""
        self.hero_stats = data.get("hero_stats")
        self.chat_id = data.get("chat_id")
        self.hero_id = self.hero_stats.character_id
        
        # ذخیره کردن دیتا برای استفاده در ایونت نهایی
        self.raw_data = data 
        
        await self._process_rewards()

    async def _process_rewards(self):
        """مدیریت چرخه اهدای جوایز"""
        gained_xp = self._calculate_gained_xp()
        total_xp = self.hero_stats.exp + gained_xp
        
        # بررسی وضعیت لول‌آپ
        level_manager = LevelManager(self.hero_stats.level)
        required_xp = level_manager.get_required_total_for_level()
        
        is_level_up = total_xp >= required_xp
        
        if is_level_up:
            update_data = self._build_level_up_stats(level_manager, total_xp, required_xp)
        else:
            update_data = {"exp": total_xp}

        await self._update_hero_in_db(update_data)
        await self._emit_reward_event(gained_xp, is_level_up, update_data)

    def _calculate_gained_xp(self) -> int:
        """محاسبه تجربه کسب شده از این نبرد"""
        # عدد 12 می‌تواند از سختی دشمن (self.raw_data.get("enemy_type")) بیاید
        return ExpReward(12).calc_exp_reward()

    def _build_level_up_stats(self, level_manager, total_xp, required_xp) -> dict:
        """ساخت دیکشنری ویژگی‌های جدید هنگام ارتقای سطح"""
        new_level = self.hero_stats.level + 1
        stats_update = {}

        # ۱. ارتقای ویژگی‌های پایه بر اساس وزن‌های تعریف شده در constants
        for stat, weight in STAT_GROWTH_WEIGHTS.items():
            current_val = getattr(self.hero_stats, stat)
            stats_update[stat] = level_manager.get_upgrade_value(current_val, weight)

        # ۲. همگام‌سازی منابع جاری با مقادیر پایه جدید و کسر تجربه مصرف شده
        stats_update.update({
            "level": new_level,
            "hp": stats_update["base_hp"],
            "energy": stats_update["base_energy"],
            "mana": stats_update["base_mana"],
            "exp": total_xp - required_xp
        })
        return stats_update

    async def _update_hero_in_db(self, update_data: dict):
        """اعمال تغییرات در دیتابیس"""
        async with get_db() as session:
            stmt = (
                update(CharacterStats)
                .where(CharacterStats.character_id == self.hero_id)
                .values(**update_data)
            )
            await session.execute(stmt)

    async def _emit_reward_event(self, gained_xp, is_level_up, final_args):
        """ارسال سیگنال برای نمایش نتایج به کاربر"""
        await bus.emit(
            "GENERATE_COMBAT_REWARDS",
            chat_id=self.chat_id,
            player=self.raw_data.get("player"),
            xp=0 if is_level_up else gained_xp, # اگر لول آپ شده، تجربه فعلی ریست شده
            stats=self.hero_stats,
            message=self.raw_data.get("message"),
            you_win=self.raw_data.get("winner") == self.raw_data.get("player"),
            enemy_name=self.raw_data.get("enemy").name,
            level_up=is_level_up,
            args=final_args
        )

# Instance و ثبت شنونده
rewards_processor = CombatRewardsProcessor()
bus.listen("COMBAT_FINISHED", rewards_processor.handle_combat_end)
