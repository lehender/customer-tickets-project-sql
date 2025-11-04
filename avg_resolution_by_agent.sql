-- analytics: average hours to resolution per agent
SELECT
  a.agent_name,
  ROUND(AVG(d.hrs_to_resolution), 2) AS avg_hours_to_resolve,
  COUNT(*) AS ticket_count
FROM public.ticket_durations d
JOIN public.agents a USING (agent_id)
WHERE d.hrs_to_resolution IS NOT NULL
GROUP BY a.agent_name
ORDER BY a.agent_name;
