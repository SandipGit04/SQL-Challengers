-- Problem Statement: Marketing Touch Streak | Company: Snowflake
WITH CTE_CONTRACTS AS
(
  SELECT 
    contact_id,
    LAG(DATE_PART('week', event_date)) OVER(PARTITION BY contact_id	ORDER BY event_date) AS prev_week,
    DATE_PART('week', event_date) AS curr_week,
    LEAD(DATE_PART('week', event_date)) OVER(PARTITION BY contact_id ORDER BY event_date) AS next_week
  FROM marketing_touches
  WHERE contact_id IN (SELECT contact_id FROM marketing_touches WHERE event_type = 'trial_request')
)

SELECT email
FROM CTE_CONTRACTS AS c1
JOIN crm_contacts AS c2
ON c1.contact_id = c2.contact_id
WHERE prev_week + 1 = curr_week AND curr_week + 1 = next_week;
