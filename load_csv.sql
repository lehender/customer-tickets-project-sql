
-- load_csv.sql — Replace <ABSOLUTE_PATH> with the folder where these CSVs live.
-- Example on Windows (use forward slashes):  'C:/Users/You/Downloads/customer_tickets_dashboard/agents.csv'

\copy agents FROM '<ABSOLUTE_PATH>/agents.csv' WITH (FORMAT csv, HEADER true);
\copy customers FROM '<ABSOLUTE_PATH>/customers.csv' WITH (FORMAT csv, HEADER true);
\copy tickets FROM '<ABSOLUTE_PATH>/tickets.csv' WITH (FORMAT csv, HEADER true);
\copy ticket_updates FROM '<ABSOLUTE_PATH>/ticket_updates.csv' WITH (FORMAT csv, HEADER true);
