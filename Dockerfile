FROM python:3.10-slim

# Install system dependencies required for building packages like llama-cpp-python
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .
COPY models ./models
# Expose the port your app runs on
EXPOSE 8000

# Run the 
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

