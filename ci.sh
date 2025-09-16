#!/bin/bash

echo "=== Installing dependencies ==="
npm install

echo "=== Running linter ==="
npm run lint || echo "No lint script found in package.json"

echo "=== Running tests ==="
npm test

echo "=== Building Docker image ==="
docker build -t teamavailtest .

echo "=== Starting with Docker Compose ==="
docker-compose up -d