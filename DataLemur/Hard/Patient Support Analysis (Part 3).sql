-- Problem Statement: Patient Support Analysis (Part 3) | Company: UnitedHealth
WITH CTE AS
(
  SELECT 
    policy_holder_id,
    LEAD(call_date) OVER(PARTITION BY policy_holder_id ORDER BY call_date) - call_date AS date_diff
  FROM callers
)

SELECT COUNT(DISTINCT policy_holder_id) AS policy_holder_count
FROM CTE
WHERE date_diff <= INTERVAL '7 days'
