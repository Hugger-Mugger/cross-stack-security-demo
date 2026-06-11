CREATE TABLE logs (
  id SERIAL PRIMARY KEY,
  tenant_id INT NOT NULL,
  message TEXT NOT NULL
);

ALTER TABLE logs ENABLE ROW LEVEL SECURITY;

CREATE POLICY tenant_isolation ON logs
  FOR SELECT
  USING (tenant_id = current_setting('app.tenant_id')::INT);

ALTER TABLE logs FORCE ROW LEVEL SECURITY;

CREATE USER tenant_user WITH PASSWORD 'secret';
GRANT CONNECT ON DATABASE demo TO tenant_user;
GRANT USAGE ON SCHEMA public TO tenant_user;
GRANT SELECT, INSERT ON logs TO tenant_user;
