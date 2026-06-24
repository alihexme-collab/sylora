# loader.py
from telegram.ext import ApplicationBuilder
from config import BOT_TOKEN, OPENAI_API_KEY, BOT_BASE_URL

app_builder = ApplicationBuilder().token(BOT_TOKEN)

if BOT_BASE_URL:
    app_builder.base_url(BOT_BASE_URL)

app = app_builder.build()