# -----------------------------
# Stage 1: Builder
# -----------------------------
FROM python:3.10-slim AS builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (cache-friendly)
COPY requirements.txt .

# Install Python dependencies into a virtual location
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r requirements.txt

# -----------------------------
# Stage 2: Runtime
# -----------------------------
FROM python:3.10-slim

WORKDIR /app

# Install runtime dependency only (no gcc)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy installed Python packages from builder
COPY --from=builder /install /usr/local

# Copy project files
COPY . .

# Verify Django installation
RUN python -c "import django; print(django.get_version())"

# Expose port
EXPOSE 8000

# Start Django using Gunicorn
CMD sh -c "gunicorn todoapp.wsgi:application \
    --bind 0.0.0.0:${PORT:-8000} \
    --workers 3 \
    --log-file -"
