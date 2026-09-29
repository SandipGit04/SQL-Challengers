-- Problem Statement: Maximize Prime Item Inventory | Company: Amazon
WITH CTE_CAPACITY AS
(
  SELECT 
    item_type,
    COUNT(*) AS total_batch_item,
    SUM(square_footage) AS total_sqft,
    FLOOR(500000 / SUM(square_footage)) AS max_allocation
  FROM inventory
  GROUP BY item_type
)
, CTE_PRIME AS
(
  SELECT 500000 - (total_sqft * max_allocation) AS left_space
  FROM CTE_CAPACITY 
  WHERE item_type = 'prime_eligible'
)
, CTE_ALLOCATION AS
(
  SELECT 
    item_type,
    total_batch_item,
    CASE 
      WHEN item_type = 'prime_eligible' THEN max_allocation
      WHEN item_type = 'not_prime' THEN FLOOR((SELECT * FROM CTE_PRIME) / total_sqft)
    END AS total_batches
  FROM CTE_CAPACITY
)

SELECT 
  item_type,
  (total_batches * total_batch_item) AS item_count
FROM CTE_ALLOCATION
ORDER BY item_type DESC

