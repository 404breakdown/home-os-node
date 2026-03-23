#!/bin/sh
set -e

cd /app

if [ ! -f package.json ]; then
  echo "No package.json found in /app"
  exit 1
fi

mkdir -p data

if [ ! -d node_modules ]; then
  echo "Installing dependencies..."
  npm ci --include=dev
fi

echo "Building app..."
npm run build

export PORT="${PORT:-80}"

echo "Starting app on port ${PORT}..."
exec npm run start
