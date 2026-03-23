#!/bin/sh
set -e

cd /app

if [ ! -f package.json ]; then
  echo "No package.json found in /app"
  exit 1
fi

mkdir -p data

echo "Cleaning old install..."
rm -rf node_modules dist

echo "Installing dependencies..."
npm install --include=dev --include=optional

echo "Checking vite..."
ls -la node_modules/.bin || true
test -f node_modules/.bin/vite || { echo "vite still missing after install"; exit 1; }

echo "Building app..."
npm run build

export PORT="${PORT:-80}"

echo "Starting app on port ${PORT}..."
exec npm run start
