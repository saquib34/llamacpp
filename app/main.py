from fastapi import FastAPI, Request
from pydantic import BaseModel
from llama_cpp import Llama
import os

app = FastAPI()

MODEL_PATH = "./models/tinyllama.gguf"

# Load model once
llm = Llama(
    model_path=MODEL_PATH,
    n_ctx=512,
    n_threads=4,
    n_batch=8,
    verbose=False
)

class Query(BaseModel):
    prompt: str

@app.post("/generate")
async def generate(query: Query):
    prompt = query.prompt
    output = llm(prompt, max_tokens=256)
    return {"response": output["choices"][0]["text"].strip()}
