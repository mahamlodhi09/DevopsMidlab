# Use an official Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy requirements first (for caching efficiency)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of your project
COPY . .

# Verify Django installation
RUN python -c "import django; print(django.__version__)"

# Expose port 8000 for Django
EXPOSE 8000

# Use Gunicorn in production and bind to the port Render provides at runtime.
# Fall back to 8000 if $PORT is not set (useful for local testing).
CMD ["sh", "-c", "gunicorn todoapp.wsgi --bind 0.0.0.0:${PORT:-8000} --log-file -"]
