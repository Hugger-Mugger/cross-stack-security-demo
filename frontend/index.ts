import { Client } from 'pg';
async function main() {
  const client = new Client({ user: 'tenant_user', password: 'secret', database: 'demo' });
  await client.connect();
  const res = await client.query('SELECT * FROM logs;');
  console.log(res.rows);
  await client.end();
}
main();