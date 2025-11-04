
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

## Tech
- PostgreSQL, SQL (CTEs, aggregates, joins), pgAdmin.

## Average Resolution Time by Agent

The query in  `analytics/avg_resolution_by_agent.sql` calculates the mean time (hours) each agent takes to resolve tickets.

You can export the result grid as CSV in pgAdmin and render it with the provided Python helper:

```bash
python viz_avg_resolution_by_agent.py avg_resolution_by_agent.csv

