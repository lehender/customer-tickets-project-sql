
-- analytics.sql — Portfolio-grade queries for a Customer Tickets Dashboard

-- 1) Ticket volume by week
WITH weeks AS (
  SELECT date_trunc('week', created_at) AS week, count(*) AS tickets_created
  FROM tickets GROUP BY 1 ORDER BY 1
)
SELECT * FROM weeks;

-- 2) Average first response time (hours) by priority and team
SELECT
  t.priority,
  a.team,
  ROUND(AVG(EXTRACT(EPOCH FROM (t.first_response_at - t.created_at))/3600)::numeric, 2) AS avg_first_response_hours
FROM tickets t
JOIN agents a ON a.agent_id = t.agent_id
WHERE t.first_response_at IS NOT NULL
GROUP BY 1,2
ORDER BY 1,2;

-- 3) % first responses that met SLA by priority
SELECT
  priority,
  ROUND(100.0 * AVG( CASE WHEN (EXTRACT(EPOCH FROM (first_response_at - created_at))/3600) <= sla_first_response_hours THEN 1 ELSE 0 END ), 2) AS pct_within_sla
FROM tickets
WHERE first_response_at IS NOT NULL
GROUP BY 1
ORDER BY 1;

-- 4) Average resolution time (hours) by priority
SELECT
  priority,
  ROUND(AVG(EXTRACT(EPOCH FROM (closed_at - created_at))/3600)::numeric, 2) AS avg_resolution_hours
FROM tickets
WHERE closed_at IS NOT NULL
GROUP BY 1
ORDER BY 1;

-- 5) Agent performance: tickets closed, avg CSAT proxy (faster resolution = better), reopen rate
-- Note: CSAT proxy is an invented metric here for portfolio purposes.
SELECT
  a.agent_name,
  COUNT(*) FILTER (WHERE t.status = 'closed') AS tickets_closed,
  ROUND(AVG(EXTRACT(EPOCH FROM (t.closed_at - t.created_at))/3600)::numeric, 2) AS avg_resolution_hours,
  ROUND(100.0 * AVG(CASE WHEN t.reopened THEN 1 ELSE 0 END), 2) AS reopen_rate_pct
FROM tickets t
JOIN agents a ON a.agent_id = t.agent_id
GROUP BY 1
ORDER BY tickets_closed DESC;

-- 6) Backlog: open or pending tickets by priority
SELECT
  priority,
  COUNT(*) AS backlog_count
FROM tickets
WHERE status IN ('open','pending','escalated')
GROUP BY 1
ORDER BY 1;

-- 7) Churn risk heuristic: Enterprise customers with 2+ High/Urgent tickets in last 30 days
WITH recent AS (
  SELECT *
  FROM tickets
  WHERE created_at >= now() - INTERVAL '30 days'
)
SELECT
  c.customer_name,
  c.plan_tier,
  COUNT(*) AS critical_ticket_count
FROM recent r
JOIN customers c ON c.customer_id = r.customer_id
WHERE r.priority IN ('High','Urgent')
GROUP BY 1,2
HAVING COUNT(*) >= 2
ORDER BY critical_ticket_count DESC;

-- 8) Volume by category and region
SELECT
  t.category,
  c.region,
  COUNT(*) AS ticket_count
FROM tickets t
JOIN customers c ON c.customer_id = t.customer_id
GROUP BY 1,2
ORDER BY 1,2;
