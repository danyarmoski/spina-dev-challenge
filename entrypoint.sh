#!/bin/bash
set -e

rm -f /app/tmp/pids/server.pid

echo "Installing gems..."
bundle install

echo "Waiting for database..."
until bundle exec rails db:version > /dev/null 2>&1; do
  sleep 2
done

echo "Preparing database..."
bundle exec rails db:prepare

exec "$@"