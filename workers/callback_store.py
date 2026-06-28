import secrets
import time

class CallbackStore:

    def __init__(self):
        self.data = {}
        self.ttl = 300  # 5 minutes

    def _generate_id(self):
        return secrets.token_hex(3)  # 6 chars

    def put(self, payload: dict) -> str:
        cid = self._generate_id()

        self.data[cid] = {
            "payload": payload,
            "time": time.time()
        }

        return cid

    def get(self, cid: str):
        item = self.data.get(cid)

        if not item:
            return None

        # expire old data
        if time.time() - item["time"] > self.ttl:
            self.data.pop(cid, None)
            return None

        return item["payload"]

    def delete(self, cid: str):
        self.data.pop(cid, None)


callback_store = CallbackStore()
