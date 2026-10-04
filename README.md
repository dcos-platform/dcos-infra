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

## Databases

The PostgreSQL service creates the following databases on first initialization:

| Database | Purpose |
|----------|---------|
| `dcos` | Shared database; `cert-api` uses schema `dcos_certificates` within it |
| `cert_orchestrator` | Database for cert-orchestrator service |
| `cert_admin` | Database for cert-admin service |
| `cert_health_service` | Database for cert-health service |

**Note:** PostgreSQL initialization scripts run only when the data directory is empty. If you add this repository to an existing environment with a pre-existing `postgres-data` volume, apply the initialization script manually:

```bash
docker exec -i dcos-postgres psql -U dcos -d dcos < postgres-init/01-create-service-databases.sql
```

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
