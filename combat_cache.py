import time
import secrets

COMBAT_CACHE = {}

COMBAT_CACHE_TTL = 120


def create_combat_session(payload: dict) -> str:
    session_id = secrets.token_urlsafe(6)

    COMBAT_CACHE[session_id] = {
        "payload": payload,
        "expires_at": time.time() + COMBAT_CACHE_TTL,
    }

    return session_id


def get_combat_session(session_id: str) -> dict | None:
    item = COMBAT_CACHE.get(session_id)

    if not item:
        return None

    if item["expires_at"] < time.time():
        COMBAT_CACHE.pop(session_id, None)
        return None

    return item["payload"]


def delete_combat_session(session_id: str):
    COMBAT_CACHE.pop(session_id, None)
