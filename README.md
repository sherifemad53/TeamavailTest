# 🚀 Project Setup & CI Pipeline

This repo shows how I set up a simple Node.js project with Docker and a
CI script.

---

## 📦 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/sherifemad53/TeamavailTest.gi
cd TeamavailTest
```

### 2. Install dependencies (local dev)

```bash
npm install
```

### 3. Make sure `.gitignore` exists

Add common stuff like:

    node_modules
    .env
    *.log

---

## ⚡ The CI Script (`ci.sh`)

I wrote a simple Bash script that automates the main steps:

-   Runs **linting** (if available).\
-   Runs **tests**.\
-   Builds the Docker image.\
-   Starts everything with Docker Compose.

Run it with:

```bash
sudo ./ci.sh
```

---

## 🐳 Dockerizing the App

The app is containerized using a small Node.js base image.\

-   Layers are cleaned up for smaller size.\
-   Build uses cache efficiently.

`Dockerfile` example:

```dockerfile
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

---

## 🛠 Docker Compose

`docker-compose.yml` is used to run the app (and any extra services if
needed, like Redis or Postgres).

Basic example:

```yaml
version: "3.8"

services:
    app:
        build: .
        container_name: teamavail_app
        ports:
            - "3000:3000"
        networks:
            - app-net

networks:
    app-net:
        driver: bridge
```

Run with:

```bash
docker compose up --build
```

---

## ✅ Validation

I tested the whole flow locally:

1.  `sudo ./ci.sh` runs lint, tests, build, and spin-up the container and mount volume to it
2.  The app starts successfully in Docker.
3.  Delete the container and run new one the data should remain the same

---

## Screen Shots

![App Screenshot](images/Screenshot1.png)
