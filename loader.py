# loader.py
from telegram.ext import ApplicationBuilder
from config import BOT_TOKEN, OPENAI_API_KEY, BOT_BASE_URL
from workers.tick import *

async def post_init(app):
    asyncio.create_task(tick.tick)

app_builder = ApplicationBuilder().token(BOT_TOKEN).post_init(post_init)

if BOT_BASE_URL:
    app_builder.base_url(BOT_BASE_URL)

app = app_builder.build()