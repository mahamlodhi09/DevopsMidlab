# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set workdir
WORKDIR /app

# Install system deps needed for psycopg2 (if using psycopg2)
RUN apt-get update && apt-get install -y --no-install-recommends gcc libpq-dev && rm -rf /var/lib/apt/lists/*

# Copy requirements and install (cache friendly)
COPY requirements.txt /app/
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . /app

# Verify Django installation (correct call)
RUN python -c "import django; print(django.get_version())"

# Expose port (for local runs; Render uses $PORT)
EXPOSE 8000

# Use shell form so ${PORT:-8000} expansion works
CMD sh -c "gunicorn todoapp.wsgi:application --bind 0.0.0.0:${PORT:-8000} --log-file -"
