from pathlib import Path

from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

app = FastAPI()


@app.get("/api")
async def hello_world():
    return {"hello": "world"}


try:
    public = Path(__file__).parent.parent / '.output' / 'public'
    print(public)
    app.mount("/", StaticFiles(directory=str(public), html=True), name="frontend")
    print("Frontend ready to serve at /")
except RuntimeError as e:
    print(f"Frontend cannot be served: {e}")
