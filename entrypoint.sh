#!/bin/bash
set -e

echo "Waiting for database..."

# Function to check if database is ready
check_db() {
    pg_isready -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER" > /dev/null 2>&1
}

# Wait up to 30 seconds for database
MAX_ATTEMPTS=30
ATTEMPT=0

while [ $ATTEMPT -lt $MAX_ATTEMPTS ]; do
    if check_db; then
        echo "Database is ready!"
        break
    fi
    ATTEMPT=$((ATTEMPT + 1))
    echo "Database not ready. Attempt $ATTEMPT/$MAX_ATTEMPTS..."
    sleep 1
done

if [ $ATTEMPT -ge $MAX_ATTEMPTS ]; then
    echo "ERROR: Database did not become ready after $MAX_ATTEMPTS attempts"
    exit 1
fi

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Creating cache table..."
python manage.py createcachetable 2>/dev/null || echo "Cache table already exists"

echo "Starting Gunicorn server..."
exec gunicorn config.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 4 \
    --worker-class sync \
    --worker-tmp-dir /dev/shm \
    --timeout 120 \
    --access-logfile - \
    --error-logfile -
