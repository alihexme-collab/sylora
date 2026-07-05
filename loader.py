# loader.py
import asyncio

from telegram.ext import ApplicationBuilder
from config import BOT_TOKEN, BOT_BASE_URL
from workers.tick import tick

async def post_init(app):
    task = await asyncio.create_task(tick.tick())
    app.bot_data["tick_task"] = task

async def post_shutdown(app):
    task = app.bot_data.get("tick_task")
    if task:
        task.cancel()
        await asyncio.gather(task, return_exceptions=True)

app_builder = (
    ApplicationBuilder()
    .token(BOT_TOKEN)
    .post_init(post_init)
    .post_shutdown(post_shutdown)
)

if BOT_BASE_URL:
    app_builder.base_url(BOT_BASE_URL)

app = app_builder.build()
