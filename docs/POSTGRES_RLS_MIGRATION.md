# PostgreSQL + RLS migration (Phase B2)

This document describes how to migrate from Drift/SQLite to PostgreSQL with row-level security (RLS) for multi-tenant isolation.

## When to use

- You need multi-tenant isolation enforced at the database level.
- You run backend workers (Phase B1) that share the same database.
- You want to scale beyond a single SQLite file.

## Schema

The app schema is defined in [lib/data/database/app_database.dart](lib/data/database/app_database.dart). All main tables include `tenant_id INTEGER NOT NULL DEFAULT 1`.

For PostgreSQL you can:

1. **Use Drift with PostgreSQL:** Add `drift_postgres` and switch the storage backend when a `DATABASE_URL` env var is set (see [Drift PostgreSQL](https://drift.simonbinder.eu/docs/advanced-features/postgres/)).
2. **Or** run the reference SQL in `sql/postgres_schema.sql` to create tables and RLS policies, then use a PostgreSQL client in the app and workers.

## RLS (row-level security)

1. Enable RLS on each tenant-scoped table:

   ```sql
   ALTER TABLE products ENABLE ROW LEVEL SECURITY;
   -- same for listings, orders, decision_logs, user_rules_table, suppliers,
   -- supplier_offers, returns, marketplace_accounts, feature_flags, background_jobs
   ```

2. Create a policy that restricts rows by the current tenant (set via `SET app.current_tenant_id = 1` in each session or connection):

   ```sql
   CREATE POLICY tenant_isolation ON products
     USING (tenant_id = current_setting('app.current_tenant_id', true)::int);
   ```

3. Ensure inserts/updates also set or check `tenant_id` (e.g. with a policy that uses `WITH CHECK (tenant_id = current_setting('app.current_tenant_id', true)::int)`).

## Acceptance (Phase B2)

- Multi-tenant isolation is enforced at the DB level: each connection/session sets `app.current_tenant_id` and sees only that tenant’s rows.
- App and workers connect to PostgreSQL and set the tenant context (e.g. from auth/session) before running queries.

## Reference SQL

See [sql/postgres_schema.sql](sql/postgres_schema.sql) for a reference schema and example RLS policies. Adjust types (e.g. `TEXT`, `REAL`, `BOOLEAN`) to match PostgreSQL and your Drift schema.
