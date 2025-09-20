#!/bin/bash

echo "=== Navigating to project directory ==="
cd ./app

echo "=== Installing dependencies ==="
npm install

echo "=== Running linter ==="
npm run lint || echo "No lint script found in package.json"

echo "=== Running tests ==="
npm test

echo "=== Building Docker image ==="
docker build -t teamavailtest .

echo "=== Navigating back to project root ==="
cd ..

echo "=== Starting with Docker Compose ==="
docker compose up --build