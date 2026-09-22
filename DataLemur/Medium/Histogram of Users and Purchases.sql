-- Problem Statement: Histogram of Users and Purchases | Company: Walmart
SELECT 
  transaction_date,
  user_id,
  COUNT(product_id) AS purchase_count
FROM user_transactions
WHERE(user_id, transaction_date) IN 
  ( SELECT 
      user_id, 
      MAX(transaction_date) AS transaction_date 
    FROM user_transactions 
    GROUP BY user_id
  )
GROUP BY user_id, transaction_date
ORDER BY transaction_date;
