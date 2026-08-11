# Architecture

> **TODO**: Add architecture diagram(s) here (e.g. a C4 context diagram or a service-dependency graph).

## Overview

```
┌─────────────────────────────────────────────────────────┐
│                     dcos-net (bridge)                   │
│                                                         │
│  ┌────────────┐   AMQP    ┌──────────────┐             │
│  │ microservice│──────────▶│  RabbitMQ    │             │
│  │   (any)    │           │  :5672       │             │
│  └────────────┘           │  mgmt :15672 │             │
│                           └──────────────┘             │
│  ┌────────────┐  SQL/TCP  ┌──────────────┐             │
│  │ microservice│──────────▶│  PostgreSQL  │             │
│  │   (any)    │           │  :5432       │             │
│  └────────────┘           └──────────────┘             │
│                                  ▲                      │
│                           ┌──────┴───────┐             │
│                           │   Adminer    │             │
│                           │  :8080       │             │
│                           └──────────────┘             │
└─────────────────────────────────────────────────────────┘
```

## Services

| Service    | Image                              | Default Port(s)     | Purpose                        |
|------------|------------------------------------|---------------------|--------------------------------|
| rabbitmq   | `rabbitmq:3.12-management-alpine`  | 5672 / 15672        | AMQP message broker            |
| postgres   | `postgres:16-alpine`               | 5432                | Shared relational database     |
| adminer    | `adminer:4-standalone`             | 8080                | Web UI for PostgreSQL          |

## Network

All services join the **`dcos-net`** bridge network.  
Microservices that need to connect should also attach to this network:

```yaml
networks:
  dcos-net:
    external: true
```

## Volumes

| Volume          | Mounted in   | Purpose                         |
|-----------------|--------------|---------------------------------|
| `postgres-data` | `/var/lib/postgresql/data` | Persistent DB storage |
| `rabbitmq-data` | `/var/lib/rabbitmq`        | Persistent queue storage |
