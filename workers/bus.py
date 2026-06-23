import asyncio
from collections import defaultdict
import traceback


class EventBus:
    DIRECT_EVENTS = {"SEND", "EDIT", "GENERATE_COMBAT_STORY"}

    def __init__(self):
        self.listeners = defaultdict(list)
        self.queues = defaultdict(asyncio.Queue)
        self.running_workers = {}

    def listen(self, event_name, callback):
        print(f"LISTEN registered: {event_name} -> {callback}")
        self.listeners[event_name].append(callback)

    async def emit(self, event_name, **data):
        player_id = data.get("player_id")

        print(f"EMIT called: {event_name}, player_id={player_id}, keys={list(data.keys())}")

        if event_name in self.DIRECT_EVENTS:
            print(f"DIRECT DISPATCH: {event_name}")
            result = await self._dispatch(event_name, data)
            print(f"DIRECT DISPATCH DONE: {event_name}")
            return result

            

        if player_id is None:
            await self._dispatch(event_name, data)
            return

        queue = self.queues[player_id]

        print(f"QUEUE before put: player_id={player_id}, size={queue.qsize()}")
        await queue.put((event_name, data))
        print(f"QUEUE after put: player_id={player_id}, size={queue.qsize()}")

        worker = self.running_workers.get(player_id)

        if worker is None or worker.done():
            if worker is not None and worker.done():
                try:
                    worker.result()
                except Exception:
                    print(f"Previous worker crashed for player {player_id}")
                    traceback.print_exc()

            print(f"Creating worker for player_id={player_id}")
            self.running_workers[player_id] = asyncio.create_task(
                self._worker(player_id)
            )
        else:
            print(f"Worker already running for player_id={player_id}")

        print(f"EMIT returned: {event_name}, player_id={player_id}")

    async def _worker(self, player_id):
        queue = self.queues[player_id]

        print(f"WORKER started for player_id={player_id}")

        while True:
            event_name, data = await queue.get()

            try:
                print(f"WORKER got event: {event_name}, player_id={player_id}, queue_size={queue.qsize()}")
                await self._dispatch(event_name, data)
                print(f"WORKER finished event: {event_name}, player_id={player_id}")

            except Exception as e:
                print(f"ERROR in event {event_name} for player {player_id}: {e}")
                traceback.print_exc()

            finally:
                queue.task_done()

    async def _dispatch(self, event_name, data):
        callbacks = self.listeners.get(event_name, [])
        result = None

        for callback in callbacks:
            if result is None:
                result = await callback(**data)

        return result



bus = EventBus()
