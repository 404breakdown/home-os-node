#!/bin/sh
set -e

echo "MIHOME START SCRIPT v4"

cd /app

if [ ! -f package.json ]; then
  echo "No package.json found in /app"
  exit 1
fi

mkdir -p data
mkdir -p node_modules

if [ ! -f node_modules/.install-complete ]; then
  echo "Installing dependencies..."
  rm -rf dist
  npm install --include=dev --include=optional
  touch node_modules/.install-complete
fi

echo "Building app..."
npm run build

export PORT="${PORT:-80}"

echo "Starting app on port ${PORT}..."
exec npm run start
