from openai import AsyncOpenAI
from config import OPENAI_API_KEY
import asyncio
client = AsyncOpenAI(
    api_key=OPENAI_API_KEY,
    base_url="https://api.gapgpt.app/v1"
)
AI_LIMIT = asyncio.Semaphore(10)
async def narrate(TYPE, **data):
    async with AI_LIMIT:
        if TYPE == "combat":
            winner = data.get("winner")
            loser = data.get("loser")
            details = data.get("data")
            details = summarize_combat(details)
            stream = await client.chat.completions.create(
                model="gapgpt-qwen-3.5",
                stream=True,
                messages=[
                    {
                        "role": "system",
                        "content": "تو راوی داستان‌های حماسی و اساطیری هستی."
                    },
                    {
                        "role": "user",
                        "content": f"""
    یک روایت کوتاه از نبرد بنویس.

    برنده: {winner.name}
    بازنده: {loser.name}

    قوانین:
    - برنده حتما {winner.name} باشد
    - بازنده حتما {loser.name} باشد
    - لحن حماسی و اساطیری باشد
    - 3 تا 5 جمله باشد

    جزئیات نبرد:
    {details}
    """
                    }
                ],
                temperature=0.9
            )

            async for chunk in stream:

                if not chunk.choices:
                    continue

                choice = chunk.choices[0]

                if not hasattr(choice, "delta") or not choice.delta:
                    continue

                delta = choice.delta

                if hasattr(delta, "content") and delta.content:
                    yield delta.content


def summarize_combat(details: dict) -> str:
    hero = details.get("Total-hero-costs", {})
    enemy = details.get("Total-enemy-costs", {})

    hero_hp = hero.get("hp", 0)
    hero_energy = hero.get("energy", 0)
    hero_mana = hero.get("mana", 0)

    enemy_hp = enemy.get("hp", 0)
    enemy_energy = enemy.get("energy", 0)
    enemy_mana = enemy.get("mana", 0)

    description = []

    # شدت آسیب قهرمان
    if hero_hp > 50:
        description.append("قهرمان به شدت زخمی شد.")
    elif hero_hp > 20:
        description.append("قهرمان آسیب قابل توجهی دید.")
    elif hero_hp > 0:
        description.append("قهرمان تنها خراش‌های سطحی برداشت.")
    else:
        description.append("قهرمان تقریباً بدون آسیب ماند.")

    # شدت آسیب دشمن
    if enemy_hp > 50:
        description.append("دشمن ضربه‌ای مرگبار دریافت کرد.")
    elif enemy_hp > 20:
        description.append("دشمن به شدت عقب رانده شد.")
    elif enemy_hp > 0:
        description.append("دشمن اندکی آسیب دید.")
    else:
        description.append("دشمن تقریباً دست‌نخورده باقی ماند.")

    # مصرف انرژی و مانا
    if hero_energy + hero_mana > 40:
        description.append("قهرمان تقریباً تمام نیروی خود را خرج کرد.")

    if enemy_energy + enemy_mana > 40:
        description.append("دشمن نیز با تمام توان جنگید.")

    return " ".join(description)
