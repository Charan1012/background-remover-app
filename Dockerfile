FROM python:3.9-slim

# Install system dependencies for rembg
RUN apt-get update && apt-get install -y \
    libgl1 libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5100

CMD ["gunicorn", "--bind", "0.0.0.0:5100", "app:app", "--workers=1"]