import websockets
import json

import var

async def send(packet: dict):
    async with websockets.connect(var.uri) as socket:
        await socket.send(json.dumps(packet))