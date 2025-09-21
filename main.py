from fastapi import FastAPI

app = FastAPI()


@app.get("/health")
def health():
    return {"status": "healthy"}


@app.get("/v1/hello")
def hello_v1(name: str = "World"):
    return {"message": f"Hello, {name}! (v1)"}
