# Cross‑Stack Security Demo

This project demonstrates a reproducible **incident response reflex** across Rust, TypeScript, SQL, and Shell.  
It highlights **tenant isolation**, **release rollback**, and **crypto/security instincts** — all in one modular setup.

---

## 🚀 Quick Start

### Clone & Run
```bash
git clone https://github.com/Hugger-Mugger/cross-stack-security-demo.git
cd cross-stack-security-demo
./scripts/run.sh
Or run in detached mode:

bash
docker-compose up -d
🔑 Connect to Database
Open a new terminal:

bash
psql -h localhost -U tenant_user -d demo
Password: secret
🧪 Tenant Isolation (RLS)
sql
SET app.tenant_id = 1;
SELECT * FROM logs;  -- shows only Tenant 1 rows

SET app.tenant_id = 2;
SELECT * FROM logs;  -- shows only Tenant 2 rows
Superusers (postgres) bypass RLS.

Normal users (tenant_user) restricted by policy.

✅ Proves row‑level security isolation.

🔄 Rollback Reflex
Simulate bad release in production:

sql
ALTER TABLE logs DROP COLUMN message;
SELECT * FROM logs;  -- fails
Run rollback:

bash
./scripts/rollback.sh
Verify recovery:

sql
INSERT INTO logs (tenant_id, message) VALUES (1, 'Recovered!');
SELECT * FROM logs;
✅ Prod broken → rollback reflex → prod recovered.
✅ Staging remains unaffected.

🔐 Crypto/Security Instincts
Build Rust binary
bash
cd rust-service
cargo build --release
cd ..
Sign binary
bash
openssl dgst -sha256 -sign private.pem -out rust-service.sig rust-service/target/release/rust-service
Verify signature
bash
./scripts/verify.sh
Expected output:

Code
Signature valid, running program...
📌 Environment Separation
Check containers:

bash
docker-compose -f docker-compose.staging.yml ps
docker-compose -f docker-compose.prod.yml ps
✅ Staging vs prod isolated.
✅ Release integrity proven.

✅ Reproducibility Guide
Anyone with Docker, Postgres (psql), Rust, and OpenSSL can reproduce this demo:

Clone repo

Run containers (./scripts/run.sh)

Follow steps for tenant isolation, rollback reflex, and signature verification

👉 Same reflex proof will be produced locally.

🎯 Founder Demo Angle
This repo demonstrates:

Tenant isolation

Rollback reflex

Crypto verification

Reproducibility guide

Clone → Build → Run → Verify → ✅ Reflexes green.