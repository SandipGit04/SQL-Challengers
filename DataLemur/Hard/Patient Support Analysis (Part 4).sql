-- Problem Statement: Patient Support Analysis (Part 4) | Company: UnitedHealth
WITH CTE_LONG_CALLS AS
(
  SELECT 
    EXTRACT(YEAR FROM call_date::date) AS yr,
    EXTRACT(MONTH FROM call_date::date) AS mth, 
    COUNT(*) AS curr_calls,
    LAG(COUNT(policy_holder_id)) OVER() AS prev_month
  FROM callers
  WHERE call_duration_secs > 300
  GROUP BY month, year
  ORDER BY month, year
)

SELECT 
  yr,
  mth,
  ROUND(((curr_calls - prev_month) * 100.0 / prev_month) , 1) AS long_calls_growth_pct
FROM CTE_LONG_CALLS
