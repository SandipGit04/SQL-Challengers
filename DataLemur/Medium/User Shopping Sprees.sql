-- Problem Statement: User Shopping Sprees | Company: Amazon
WITH CTE_SPREE AS
(
  SELECT
    user_id,
    LAG(DATE_PART('DAY', transaction_date)) OVER(PARTITION BY user_id ORDER BY transaction_date) AS prev_day,
    DATE_PART('DAY', transaction_date) AS curr_day,
    LEAD(DATE_PART('DAY', transaction_date)) OVER(PARTITION BY user_id ORDER BY transaction_date) AS next_day
  FROM transactions
)

SELECT user_id
FROM CTE_SPREE
WHERE prev_day + 1 = curr_day	AND curr_day + 1 = next_day;
