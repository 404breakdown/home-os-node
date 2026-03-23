#!/bin/sh
set -e

cd /app

if [ ! -f package.json ]; then
  echo "No package.json found in /app"
  exit 1
fi

mkdir -p data

echo "Installing dependencies..."
rm -rf node_modules
npm ci --include=dev --include=optional

echo "Building app..."
npm run build

export PORT="${PORT:-80}"

echo "Starting app on port ${PORT}..."
exec npm run start
