# Start from a Python base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# System dependencies for curl and other utilities
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app ./app

# Create models directory
RUN mkdir -p /app/models

# Download TinyLlama GGUF model
RUN curl -L -o /app/models/tinyllama.gguf https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-GGUF/resolve/main/tinyllama-1.1b-chat.q4_K_M.gguf

# Run the server (adjust as per your actual command)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "7860"]
