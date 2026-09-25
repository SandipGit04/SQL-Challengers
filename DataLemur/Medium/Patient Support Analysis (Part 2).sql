-- Problem Statement: Patient Support Analysis (Part 2) | Company: UnitedHealth
SELECT 
  ROUND( 
   SUM( 
    CASE
      WHEN (call_category = 'n/a' OR call_category IS NULL) THEN 100.0
      ELSE 0 
    END) / COUNT(*), 1) AS uncategorised_call_pct
FROM callers;
