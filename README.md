
# Customer Tickets Dashboard (PostgreSQL)

A compact, realistic dataset and set of SQL queries that demonstrate customer support analytics: backlog, SLA performance, agent productivity, and churn‑risk heuristics.

## What's Included
- `agents.csv`, `customers.csv`, `tickets.csv`, `ticket_updates.csv`: synthetic but realistic data (~320 tickets across 140 days).
- `schema.sql`: table definitions.
- `load_csv.sql`: COPY commands to import the CSVs (edit the path).
- `analytics.sql`: portfolio‑grade queries you can run for screenshots/outputs.

## Quick Start (pgAdmin)
1. Create a database (e.g., `customer_tickets`).
2. Open **Query Tool**, run `schema.sql`.
3. In **psql** or pgAdmin's query tool, run `load_csv.sql` after replacing `<ABSOLUTE_PATH>` with the folder where the CSVs live.  
   - Example Windows path: `C:/Users/YourName/Downloads/customer_tickets_dashboard`
4. Run `analytics.sql` and grab screenshots of the result grids for your README/GitHub.

### Alternative load (pgAdmin GUI)
- Right‑click each table → **Import/Export** → Import from the corresponding CSV (Header = Yes, Format = CSV).

## Highlight on Resume
- Built a **Customer Tickets Dashboard** in PostgreSQL: modeled support workflows, imported CSVs, and wrote analytic SQL to track SLA compliance, backlog, agent productivity, and churn‑risk signals.
- Tech: PostgreSQL, SQL (CTEs, aggregates, joins), pgAdmin.

---

> Tip: add a short Loom/GIF demo scrolling through query results for extra polish.
