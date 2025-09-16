# 🚀 Project Setup & CI Pipeline

This repo shows how I set up a simple Node.js project with Docker and a
basic CI script. Everything is lightweight and easy to follow.

------------------------------------------------------------------------

## 📦 Getting Started

### 1. Clone the repo

``` bash
git clone <your-repo-url>
cd <your-project-folder>
```

### 2. Install dependencies (local dev)

``` bash
npm install
```

### 3. Make sure `.gitignore` exists

Add common stuff like:

    node_modules
    .env
    *.log

------------------------------------------------------------------------

## ⚡ The CI Script (`ci.sh`)

I wrote a simple Bash script that automates the main steps:

-   Runs **linting** (if available).\
-   Runs **tests**.\
-   Builds the Docker image.\
-   Starts everything with Docker Compose.

Run it with:

``` bash
sudo ./ci.sh
```

------------------------------------------------------------------------

## 🐳 Dockerizing the App

The app is containerized using a small Node.js base image.\
- Layers are cleaned up for smaller size.\
- Build uses cache efficiently.

`Dockerfile` example:

``` dockerfile
FROM node:20-alpine

WORKDIR /app

# Copy only package files first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

COPY . .

EXPOSE 3000

CMD ["npm", "run", "start"]
```

------------------------------------------------------------------------

## 🛠 Docker Compose

`docker-compose.yml` is used to run the app (and any extra services if
needed, like Redis or Postgres).

Basic example:

``` yaml
version: "3.9"

services:
  app:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/app
    command: npm start
```

Run with:

``` bash
docker compose up --build
```

------------------------------------------------------------------------

## ✅ Validation

I tested the whole flow locally:

1.  `sudo ./ci.sh` runs lint, tests, build, and spin-up.\
2.  The app starts successfully in Docker.