FROM python:3.10-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Set working dir
WORKDIR /app

# Copy app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

# Create models folder
RUN mkdir -p /app/models

# Download GGUF model (TinyLlama example)
RUN curl -L -o /app/models/tinyllama.gguf https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-GGUF/resolve/main/tinyllama-1.1b-chat.q4_K_M.gguf

# Run server
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "7860"]
