-- Problem Statement: International Call Percentage | Company: Verizon
SELECT 
  ROUND(SUM(CASE WHEN pi1.country_id <> pi2.country_id THEN 100.0 ELSE 0 END) / COUNT(*), 1) AS international_calls_pct
FROM phone_calls AS pc 
INNER JOIN phone_info AS pi1
ON pc.caller_id = pi1.caller_id
INNER JOIN phone_info AS pi2
ON pc.receiver_id = pi2.caller_id;
