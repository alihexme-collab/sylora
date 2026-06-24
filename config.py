# config.py
import os
from dotenv import load_dotenv

load_dotenv()

# توکن‌ها و دسترسی‌ها
BOT_TOKEN = os.getenv("BOT_TOKEN", "your_bale_or_telegram_token")
BOT_BASE_URL = os.getenv("BOT_BASE_URL", "https://tapi.bale.ai/") # اتصال مستقیم به سرور بله یا تلگرام
OPENAI_API_KEY = os.getenv("OPENAI_API_KEY", "sk-proj-...")

# اطلاعات دیتابیس عظیم سیلورا
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "password")
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_NAME", "sylora_db")

db_url = os.getenv("DATABASE_URL")
if db_url and db_url.startswith("postgresql://"):
    DATABASE_URL = db_url.replace("postgresql://", "postgresql+asyncpg://", 1)

OPENAI_BASE_URL = os.getenv("OPENAI_BASE_URL")

# نقش‌های اصلی جهان
CREATOR_ID = int(os.getenv("CREATOR_ID", "12345678"))  # شناسه تلگرام شما (خالق)
CHANNEL_ID = os.getenv("CHANNEL_ID", "@silvera_legends")  # کانال انتشار افسانه‌ها

# قوانین جهان سیلورا
MAX_AGE_GRAND_MAN_STAGE_1 = 10
REQUIRED_POINTS_STAGE_1 = 1000
MAX_AGE_GRAND_MAN_STAGE_2 = 20
REQUIRED_POINTS_STAGE_2 = 1000000