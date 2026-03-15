-- Reference PostgreSQL schema for Phase B2 (multi-tenant with RLS).
-- Mirrors lib/data/database/app_database.dart. Run after creating the database.

-- Session variable for current tenant (set per connection).
-- e.g. SET app.current_tenant_id = 1;

CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  local_id TEXT NOT NULL,
  source_id TEXT NOT NULL,
  source_platform_id TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  image_urls TEXT NOT NULL,
  variants_json TEXT NOT NULL,
  base_price REAL NOT NULL,
  shipping_cost REAL,
  currency TEXT NOT NULL DEFAULT 'PLN',
  supplier_id TEXT,
  supplier_country TEXT,
  estimated_days INTEGER,
  raw_json TEXT,
  updated_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS listings (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  local_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  target_platform_id TEXT NOT NULL,
  target_listing_id TEXT,
  status TEXT NOT NULL,
  selling_price REAL NOT NULL,
  source_cost REAL NOT NULL,
  decision_log_id TEXT,
  marketplace_account_id TEXT,
  promised_min_days INTEGER,
  promised_max_days INTEGER,
  created_at TIMESTAMPTZ NOT NULL,
  published_at TIMESTAMPTZ,
  variant_id TEXT
);

CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  local_id TEXT NOT NULL,
  listing_id TEXT NOT NULL,
  target_order_id TEXT NOT NULL,
  target_platform_id TEXT NOT NULL,
  customer_address_json TEXT NOT NULL,
  status TEXT NOT NULL,
  source_order_id TEXT,
  source_cost REAL NOT NULL,
  selling_price REAL NOT NULL,
  quantity INTEGER NOT NULL DEFAULT 1,
  tracking_number TEXT,
  decision_log_id TEXT,
  marketplace_account_id TEXT,
  promised_delivery_min TIMESTAMPTZ,
  promised_delivery_max TIMESTAMPTZ,
  delivered_at TIMESTAMPTZ,
  approved_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS orders_target_platform_order_listing_unique
  ON orders(target_platform_id, target_order_id, listing_id);

CREATE TABLE IF NOT EXISTS decision_logs (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  local_id TEXT NOT NULL,
  type TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  reason TEXT NOT NULL,
  criteria_snapshot TEXT,
  created_at TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS user_rules_table (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  min_profit_percent REAL NOT NULL,
  max_source_price REAL,
  preferred_supplier_countries TEXT NOT NULL,
  manual_approval_listings BOOLEAN NOT NULL,
  manual_approval_orders BOOLEAN NOT NULL,
  scan_interval_minutes INTEGER NOT NULL,
  blacklisted_product_ids TEXT NOT NULL,
  blacklisted_supplier_ids TEXT NOT NULL,
  default_markup_percent REAL NOT NULL,
  search_keywords TEXT NOT NULL,
  marketplace_fees_json TEXT NOT NULL DEFAULT '{}',
  payment_fees_json TEXT NOT NULL DEFAULT '{}',
  seller_return_address_json TEXT,
  marketplace_return_policy_json TEXT NOT NULL DEFAULT '{}',
  targets_read_only BOOLEAN NOT NULL DEFAULT false,
  pricing_strategy TEXT NOT NULL DEFAULT 'always_below_lowest',
  category_min_profit_percent_json TEXT NOT NULL DEFAULT '{}',
  premium_when_better_reviews_percent REAL NOT NULL DEFAULT 2.0,
  min_sales_count_for_premium INTEGER NOT NULL DEFAULT 10,
  kpi_driven_strategy_enabled BOOLEAN NOT NULL DEFAULT false,
  rate_limit_max_requests_per_second_json TEXT NOT NULL DEFAULT '{}'
);

CREATE TABLE IF NOT EXISTS suppliers (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  supplier_id TEXT NOT NULL,
  name TEXT NOT NULL,
  platform_type TEXT NOT NULL,
  country_code TEXT,
  rating REAL,
  return_window_days INTEGER,
  return_shipping_cost REAL,
  restocking_fee_percent REAL,
  accepts_no_reason_returns BOOLEAN NOT NULL DEFAULT false,
  warehouse_address TEXT,
  warehouse_city TEXT,
  warehouse_zip TEXT,
  warehouse_country TEXT,
  warehouse_phone TEXT,
  warehouse_email TEXT,
  feed_source TEXT,
  shop_url TEXT
);

CREATE TABLE IF NOT EXISTS supplier_offers (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  offer_id TEXT NOT NULL,
  product_id TEXT NOT NULL,
  supplier_id TEXT NOT NULL,
  source_platform_id TEXT NOT NULL,
  cost REAL NOT NULL,
  shipping_cost REAL,
  min_estimated_days INTEGER,
  max_estimated_days INTEGER,
  carrier_code TEXT,
  shipping_method_name TEXT,
  last_price_refresh_at TIMESTAMPTZ,
  last_stock_refresh_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS returns (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  return_id TEXT NOT NULL,
  order_id TEXT NOT NULL,
  reason TEXT NOT NULL,
  status TEXT NOT NULL,
  notes TEXT,
  refund_amount REAL,
  return_shipping_cost REAL,
  restocking_fee REAL,
  requested_at TIMESTAMPTZ,
  resolved_at TIMESTAMPTZ,
  return_to_address TEXT,
  return_to_city TEXT,
  return_to_country TEXT,
  return_tracking_number TEXT,
  return_carrier TEXT,
  supplier_id TEXT,
  product_id TEXT,
  source_platform_id TEXT,
  target_platform_id TEXT,
  return_destination TEXT
);

CREATE TABLE IF NOT EXISTS marketplace_accounts (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  account_id TEXT NOT NULL,
  platform_id TEXT NOT NULL,
  display_name TEXT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT false,
  connected_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS feature_flags (
  name TEXT NOT NULL,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  enabled BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (name)
);

CREATE TABLE IF NOT EXISTS background_jobs (
  id SERIAL PRIMARY KEY,
  tenant_id INTEGER NOT NULL DEFAULT 1,
  job_type TEXT NOT NULL,
  payload_json TEXT NOT NULL DEFAULT '{}',
  status TEXT NOT NULL,
  attempts INTEGER NOT NULL DEFAULT 0,
  max_attempts INTEGER NOT NULL DEFAULT 3,
  created_at TIMESTAMPTZ NOT NULL,
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  error_message TEXT
);

-- Example RLS: enable and add policy for products. Repeat for other tenant-scoped tables.
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
CREATE POLICY products_tenant_isolation ON products
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY products_tenant_insert ON products
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));

ALTER TABLE listings ENABLE ROW LEVEL SECURITY;
CREATE POLICY listings_tenant_isolation ON listings
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY listings_tenant_insert ON listings
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));

ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
CREATE POLICY orders_tenant_isolation ON orders
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY orders_tenant_insert ON orders
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));

ALTER TABLE decision_logs ENABLE ROW LEVEL SECURITY;
CREATE POLICY decision_logs_tenant_isolation ON decision_logs
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY decision_logs_tenant_insert ON decision_logs
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));

ALTER TABLE user_rules_table ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_rules_tenant_isolation ON user_rules_table
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY user_rules_tenant_insert ON user_rules_table
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));

ALTER TABLE suppliers ENABLE ROW LEVEL SECURITY;
CREATE POLICY suppliers_tenant_isolation ON suppliers
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY suppliers_tenant_insert ON suppliers
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));

ALTER TABLE supplier_offers ENABLE ROW LEVEL SECURITY;
CREATE POLICY supplier_offers_tenant_isolation ON supplier_offers
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY supplier_offers_tenant_insert ON supplier_offers
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));

ALTER TABLE returns ENABLE ROW LEVEL SECURITY;
CREATE POLICY returns_tenant_isolation ON returns
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY returns_tenant_insert ON returns
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));

ALTER TABLE marketplace_accounts ENABLE ROW LEVEL SECURITY;
CREATE POLICY marketplace_accounts_tenant_isolation ON marketplace_accounts
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY marketplace_accounts_tenant_insert ON marketplace_accounts
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));

ALTER TABLE feature_flags ENABLE ROW LEVEL SECURITY;
CREATE POLICY feature_flags_tenant_isolation ON feature_flags
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY feature_flags_tenant_insert ON feature_flags
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));

ALTER TABLE background_jobs ENABLE ROW LEVEL SECURITY;
CREATE POLICY background_jobs_tenant_isolation ON background_jobs
  USING (tenant_id = (current_setting('app.current_tenant_id', true)::int));
CREATE POLICY background_jobs_tenant_insert ON background_jobs
  WITH CHECK (tenant_id = (current_setting('app.current_tenant_id', true)::int));
