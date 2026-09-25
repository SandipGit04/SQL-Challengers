-- Problem Statement: Consecutive Filing Years | Company: Intuit
WITH CTE_TurboTax AS
(
  SELECT
      user_id,
      LAG(DATE_PART('YEAR', filing_date)) OVER(PARTITION BY user_id ORDER BY filing_date) AS prev_year,
      DATE_PART('YEAR', filing_date) AS curr_year,
      LEAD(DATE_PART('YEAR', filing_date)) OVER(PARTITION BY user_id ORDER BY filing_date) AS next_year
  FROM filed_taxes
  WHERE product LIKE 'TurboTax%'
)

SELECT DISTINCT user_id
FROM CTE_TurboTax
WHERE prev_year = curr_year - 1 AND curr_year + 1 = next_year
ORDER BY user_id;
