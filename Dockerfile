FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# MTProxy is built from the official Telegram source on first start.
# Keep build tools in the runtime image so this also works on Railway cold starts.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       build-essential libssl-dev zlib1g-dev git curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt ./
RUN python -m pip install --no-cache-dir --upgrade pip \
    && python -m pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000
CMD ["python", "main.py"]
