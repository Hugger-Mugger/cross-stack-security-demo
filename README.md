Here’s a polished **README.md** you can copy‑paste straight into your repo. It explains the demo clearly and makes it interview‑ready:

```markdown
# Cross-Stack Security Demo

This project demonstrates a cross‑stack setup (Rust, TypeScript, Shell, SQL) with **Postgres row‑level security (RLS)** for tenant isolation.

---

## 🚀 Run the Demo

Start the Postgres container:

```bash
./scripts/run.sh
```

Or run in detached mode (background):

```bash
docker-compose up -d
```

---

## 🔑 Connect as Test User

Open a new terminal and connect:

```bash
psql -h localhost -U tenant_user -d demo
```

Password: `secret`

---

## 🧪 Test Tenant Isolation

Inside `psql`, set the tenant context and query:

```sql
SET app.tenant_id = 1;
SELECT * FROM logs;  -- shows only Tenant 1 rows

SET app.tenant_id = 2;
SELECT * FROM logs;  -- shows only Tenant 2 rows
```

---

## 📌 Notes

- Superusers (`postgres`) bypass RLS and can see all rows.  
- Normal users (`tenant_user`) are restricted by the policy.  
- This proves **row‑level security isolation** is enforced correctly.  

---

## ✅ Day 1 Deliverables

- Cross‑stack repo structure (Rust, TypeScript, Shell, SQL).  
- Docker Compose orchestration.  
- Postgres schema + RLS policy.  
- Tenant isolation demo with normal user.  
```

---

✨ With this README in place, your repo will look professional and self‑explanatory.  

Now you can run:
```bash
git add README.md db/setup.sql docker-compose.yml scripts/run.sh
git commit -m "Day 1 demo complete: RLS isolation working with tenant_user"
git push origin main
```

## ✅ Day 2 Deliverables

- Separate **staging** (`demo_staging` on port 5433) and **production** (`demo_prod` on port 5434) environments.
- Isolation proof: inserts in staging and prod show independent rows.
- Rollback drill:
  1. Simulate bad release in prod:
     ```sql
     ALTER TABLE logs DROP COLUMN message;
     ```
     → Prod broke.
  2. Show staging unaffected:
     ```sql
     SELECT * FROM logs;
     ```
  3. Rollback prod:
     ```bash
     docker-compose -f docker-compose.prod.yml down -v
     docker-compose -f docker-compose.prod.yml up -d
     ```
  4. Verify recovery:
     ```sql
     INSERT INTO logs (tenant_id, message) VALUES (2, 'Recovered prod');
     SELECT * FROM logs;
     ```
- This demonstrates **release recovery reflexes**: staging safe, prod recoverable.
## 📌 Day 2 Notes

- **Environment separation**: Staging (`demo_staging`) and Production (`demo_prod`) run on separate ports with independent data.  
- **Rollback reflex**: Simulated bad release in prod (`DROP COLUMN message`) → queries failed → rollback with container re‑init → prod recovered.  
- **Crypto reflex**: Rust binary signing/verification with public/private keys to prove release integrity.  
- **Resilience proof**: Staging remained safe while prod was broken, then recovered.  

