-- Problem Statement: Server Utilization Time | Company: Amazon
WITH CTE_UPTIMES AS
(
  SELECT 
    RANK() OVER(PARTITION BY su1.server_id, su1.status_time ORDER BY su1.status_time, su2.status_time) AS rank,
    su1.server_id,
    (su2.status_time - su1.status_time) AS day_diff
  FROM server_utilization AS su1
  INNER JOIN server_utilization AS su2
  ON su1.server_id = su2.server_id AND su1.status_time < su2.status_time
     AND su1.session_status = 'start' AND su2.session_status = 'stop'
)

SELECT DATE_PART('DAYS', JUSTIFY_HOURS(SUM(day_diff))) AS total_uptime_days
FROM CTE_UPTIMES
WHERE rank = 1

/* JUSTIFY_HOURS() — brief explanation
JUSTIFY_HOURS() is a PostgreSQL function that converts every 24 hours in an interval into 1 day.

For example: 50 hours -> 2 days 2 hours
And, 25 days 26 hours -> 26 days 2 hours

So, simply: JUSTIFY_HOURS() normalizes an interval by converting excess hours (24+) into days.
It doesn't change the total amount of time; it only changes how the interval is represented. */
