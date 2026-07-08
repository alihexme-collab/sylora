import random as rnd
from sqlalchemy import select
from database.db_manager import get_db
from database.model import *
from .bus import bus
from .callback_store import callback_store

def compare_power(player_power, enemy_power):
    ratio = enemy_power / max(player_power, 1)

    if ratio < 0.7:
        return "آسان 🟢"
    elif ratio < 1.2:
        return "چالش‌برانگیز 🟡"
    elif ratio < 1.7:
        return "سخت و نفس‌گیر 🔴"
    else:
        return "بسیار مرگبار ☠️"

def power_of(stats):
    if getattr(stats, "intelligence", False):
        return (
            (stats.strength or 0)
            + (stats.speed or 0)
            + (stats.defense or 0)
            + (stats.intelligence or 0)
            + (stats.hp or 0)
            + (stats.mana or 0)
            + (stats.energy or 0)
        )
    else:
        return (
            (stats.strength or 0)
            + (stats.speed or 0)
            + (stats.hp or 0)
            + (stats.mana or 0)
            + (stats.energy or 0)
        )

class FindEnemy:
    async def receive_fight(self, **data):
        chat_id = data.get("chat_id")
        message = data.get("message")

        if not chat_id:
            return

        async with get_db() as session:
            # ۱. دریافت اطلاعات بازیکن
            result = await session.execute(
                select(Player).where(Player.telegram_id == chat_id)
            )
            player = result.scalar_one_or_none()
            if not player:
                return

            # ۲. دریافت کاراکتر قهرمان
            result = await session.execute(
                select(Character).where(Character.player_id == player.player_id)
            )
            hero = result.scalar_one_or_none()
            if not hero:
                return

            # ۳. بررسی وضعیت استت‌های قهرمان
            result = await session.execute(
                select(CharacterStats).where(CharacterStats.character_id == hero.character_id)
            )
            player_stats = result.scalar_one_or_none()
            if not player_stats:
                return

            # جلوگیری از مبارزه در صورت وخیم بودن وضعیت بقا
            if player_stats.hp <= 10 or player_stats.energy <= 10:
                warning_text = (
                    "⚠️ <b>توان مبارزه ندارید!</b>\n\n"
                    f"❤️ سلامتی شما: <code>{player_stats.hp}</code>\n"
                    f"⚡ انرژی شما: <code>{player_stats.energy}</code>\n\n"
                    "وضعیت جسمانی شما بسیار وخیم است. پیش از ورود به هر مبارزه‌ای، "
                    "باید از طریق دستور <b>استراحت</b> منابع خود را بازیابی کنید."
                )
                await bus.emit(
                    "SEND",
                    player_id=chat_id,
                    text=warning_text,
                    message=message,
                    chat_id=chat_id,
                    parse_mode="HTML"
                )
                return

            # استخراج منطقه و بخش از مسیر حرکت کاراکتر
            try:
                _, region, area = hero.character_path.split("_")
            except Exception:
                return

            candidates = []

            # الف) کاندیداهای NPC (فقط برای بازیکنان سطح ۱۰ به بالا)
            if player_stats.level >= 10:
                result = await session.execute(
                    select(Npc).where(Npc.npc_id.like(f"npc_{region}_{area}"))
                )
                for npc in result.scalars().all():
                    candidates.append({
                        "obj": npc,
                        "type": "npc"
                    })

            # ب) کاراکترهای دیگر (سایر بازیکنان زنده در همین لوکیشن)
            result = await session.execute(
                select(Character).where(
                    Character.character_path == hero.character_path,
                    Character.character_id != hero.character_id,
                    Character.is_alive == True
                )
            )
            for char in result.scalars().all():
                candidates.append({
                    "obj": char,
                    "type": "character"
                })

            # ج) هیولاهای وحشی منطقه
            result = await session.execute(
                select(Enemy).where(Enemy.location_id == hero.character_path)
            )
            for emy in result.scalars().all():
                candidates.append({
                    "obj": emy,
                    "type": "enemy"
                })

            if not candidates:
                await bus.emit(
                    "SEND",
                    player_id=chat_id,
                    text="👀 <b>سکوت سنگینی منطقه را فرا گرفته است...</b>\n\nهیچ موجود یا حریفی در این اطراف یافت نشد.",
                    message=message,
                    chat_id=chat_id,
                    parse_mode="HTML"
                )
                return

            rnd.shuffle(candidates)
            choices = candidates[: rnd.randint(4, 6)]

            options = []
            player_power = power_of(player_stats)

            for cand in choices:
                enemy = cand["obj"]
                enemy_type = cand["type"]

                if enemy_type == "npc":
                    res = await session.execute(
                        select(NpcStats).where(NpcStats.npc_id == enemy.npc_id)
                    )
                    enemy_stats = res.scalar_one_or_none()

                elif enemy_type == "character":
                    res = await session.execute(
                        select(CharacterStats).where(CharacterStats.character_id == enemy.character_id)
                    )
                    enemy_stats = res.scalar_one_or_none()

                else:
                    res = await session.execute(
                        select(EnemyStats).where(EnemyStats.enemy_id == enemy.enemy_id)
                    )
                    enemy_stats = res.scalar_one_or_none()

                if not enemy_stats:
                    continue

                enemy_power = power_of(enemy_stats)
                difficulty = compare_power(player_power, enemy_power)

                options.append({
                    "enemy": enemy,
                    "type": enemy_type,
                    "difficulty": difficulty
                })

            # ۴. ساخت متن خروجی و دکمه‌ها با استایل نقش‌آفرینی
            text = (
                "⚔️ <b>حریفانی در سایه‌های این منطقه دیده شدند...</b>\n"
                "یکی از اهداف زیر را برای شروع نبرد انتخاب کنید:\n\n"
            )

            buttons = []

            for opt in options:
                enemy = opt["enemy"]
                enemy_type = opt["type"]
                name = getattr(enemy, "name", "موجود ناشناخته")

                # نمادهای گرافیکی بر اساس نوع دشمن
                icon = "👹" if enemy_type == "enemy" else "👤" if enemy_type == "character" else "🧙‍♂️"
                
                text += f"{icon} <b>{name}</b>\n└ 🛡️ <i>سطح خطرات: {opt['difficulty']}</i>\n\n"

                uid = (
                    enemy.enemy_id
                    if enemy_type == "enemy"
                    else enemy.npc_id
                    if enemy_type == "npc"
                    else enemy.character_id
                )
                
                cid = callback_store.put({
                    "enemy_type": enemy_type,
                    "enemy_id": uid,
                    "hero_id": hero.character_id
                })
                
                buttons.append({
                    "text": f"{icon} {name} ({opt['difficulty'].split()[-1]})",
                    "callback": f"fight:{cid}"
                })

            await bus.emit(
                "SEND",
                player_id=player.player_id,
                chat_id=chat_id,
                text=text,
                buttons=buttons,
                message=message,
                parse_mode="HTML"
            )

find_enemy = FindEnemy()
bus.listen("FIGHT", find_enemy.receive_fight)
