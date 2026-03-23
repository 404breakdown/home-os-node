#!/bin/sh
set -e

cd /app

if [ ! -f package.json ]; then
  echo "No package.json found in /app"
  exit 1
fi

if [ ! -d data ]; then
  mkdir -p data
fi

if [ ! -d node_modules ]; then
  echo "Installing dependencies..."
  npm ci
fi

if [ ! -d dist ]; then
  echo "Building app..."
  npm run build
fi

echo "Starting app on port ${PORT}..."
exec npm run start
