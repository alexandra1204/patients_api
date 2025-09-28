#!/bin/bash
set -e

# wait for postgres to be ready
until pg_isready -h "${POSTGRES_HOST:-db}" -p "${POSTGRES_PORT:-5432}" -U "${POSTGRES_USER:-postgres}"; do
  echo "Waiting for postgres..."
  sleep 1
done

# ensure secret key
if [ -z "$SECRET_KEY_BASE" ]; then
  export SECRET_KEY_BASE=$(bundle exec rails secret)
fi

# create / migrate db then start
bundle exec rails db:create db:migrate || true

exec "$@"
