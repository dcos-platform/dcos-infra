# Local Development Guide

## Prerequisites

| Tool | Minimum version | Install guide |
|------|----------------|---------------|
| Docker | 24.x | https://docs.docker.com/get-docker/ |
| Docker Compose | 2.x (plugin) | Bundled with Docker Desktop |

## Quick Start

```bash
# 1. Clone the infrastructure repository
git clone https://github.com/dcos-platform/dcos-infra.git
cd dcos-infra

# 2. Create your local environment file
cp .env.example .env
# Edit .env and change the default passwords before first run

# 3. Start all services
docker-compose up -d

# 4. Verify services are healthy
docker-compose ps
```

## Service Endpoints

| Service              | URL / address                        |
|----------------------|--------------------------------------|
| RabbitMQ AMQP        | `amqp://localhost:5672`              |
| RabbitMQ Management  | http://localhost:15672               |
| PostgreSQL           | `postgresql://localhost:5432/<db>`   |
| Adminer              | http://localhost:8080                |

> Default credentials are stored in `.env` (copied from `.env.example`).

## Connecting a Microservice

Each DCOS microservice should reference the shared network so it can reach the
broker and the database by their container names (`rabbitmq`, `postgres`).

Add the following to the microservice's own `docker-compose.yml`:

```yaml
services:
  my-service:
    # ...
    environment:
      RABBITMQ_HOST: rabbitmq
      RABBITMQ_PORT: 5672
      POSTGRES_HOST: postgres
      POSTGRES_PORT: 5432
    networks:
      - dcos-net

networks:
  dcos-net:
    external: true   # created by dcos-infra
```

## Useful Commands

```bash
# Tail logs for all services
docker-compose logs -f

# Stop all services (data is preserved in volumes)
docker-compose stop

# Stop and remove containers + volumes (destructive!)
docker-compose down -v

# Restart a single service
docker-compose restart rabbitmq

# Open a psql shell
docker-compose exec postgres psql -U ${POSTGRES_USER:-dcos} -d ${POSTGRES_DB:-dcos}

# Open a RabbitMQ management shell
docker-compose exec rabbitmq rabbitmqctl status
```

## Troubleshooting

### Port conflicts
If ports 5432, 5672, 15672, or 8080 are already in use, override them in `.env`:

```dotenv
POSTGRES_PORT=5433
RABBITMQ_PORT=5673
RABBITMQ_MANAGEMENT_PORT=15673
ADMINER_PORT=8081
```

### Services not becoming healthy
Run `docker-compose logs <service>` to inspect startup output.  
Increase `start_period` values in `docker-compose.yml` on slow machines.

### Reset all data
```bash
docker-compose down -v   # removes named volumes
docker-compose up -d
```
