# dcos-infra

Infrastructure repository for the **DCOS** (Distributed Certificate Orchestration System) project.

This repo contains **no application code**. It provides the shared Docker Compose environment (RabbitMQ, PostgreSQL, Adminer), network configuration, and local development tooling used by all DCOS microservices.

## Contents

| Path | Description |
|------|-------------|
| `docker-compose.yml` | Shared services: RabbitMQ, PostgreSQL, Adminer |
| `.env.example` | Environment variable template – copy to `.env` and edit |
| `docs/architecture.md` | Architecture overview and service diagram |
| `docs/local-dev.md` | Local development guide |

## Quick Start

```bash
cp .env.example .env        # edit passwords as needed
docker-compose up -d
```

| Service | URL |
|---------|-----|
| RabbitMQ Management | http://localhost:15672 |
| Adminer (DB UI) | http://localhost:8080 |
| PostgreSQL | localhost:5432 |

See [docs/local-dev.md](docs/local-dev.md) for full instructions and [docs/architecture.md](docs/architecture.md) for the architecture diagram.
