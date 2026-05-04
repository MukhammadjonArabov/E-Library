#!/bin/bash

echo "Waiting for database..."
# Use pg_isready to check if database is ready
MAX_ATTEMPTS=30
ATTEMPT=0
until [ $ATTEMPT -ge $MAX_ATTEMPTS ] || pg_isready -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER &>/dev/null; do
  ATTEMPT=$((ATTEMPT+1))
  echo "Database not ready yet. Attempt $ATTEMPT/$MAX_ATTEMPTS..."
  sleep 1
done

if [ $ATTEMPT -ge $MAX_ATTEMPTS ]; then
  echo "Database startup failed after $MAX_ATTEMPTS attempts"
  exit 1
fi

echo "Database started"

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Creating cache table..."
python manage.py createcachetable 2>/dev/null || true

echo "Starting Gunicorn..."
exec gunicorn config.wsgi:application --bind 0.0.0.0:8000 --workers 4 --timeout 120
