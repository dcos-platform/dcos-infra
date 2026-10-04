-- Creates the per-service databases the DCOS services expect.
-- Runs only on first initialisation of an empty data directory (see the README note added by
-- this change). Written to be idempotent so it can also be applied by hand to an existing
-- instance without failing.
--
-- No OWNER clause: the script runs as POSTGRES_USER, so each database is owned by that role
-- and stays correct whatever the environment sets POSTGRES_USER to.

SELECT 'CREATE DATABASE cert_orchestrator'
 WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'cert_orchestrator')\gexec

SELECT 'CREATE DATABASE cert_admin'
 WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'cert_admin')\gexec

SELECT 'CREATE DATABASE cert_health_service'
 WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'cert_health_service')\gexec
