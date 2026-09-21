-- Problem Statement: Senior Managers | Company: Google
SELECT 
  e2.manager_name,
  COUNT(DISTINCT e1.manager_id) AS direct_reportees
FROM employees AS e1
  INNER JOIN employees AS e2
ON e1.manager_id = e2.emp_id
  INNER JOIN employees e3
ON e2.manager_id = e3.emp_id
GROUP BY e2.manager_id, e2.manager_name
ORDER BY direct_reportees DESC;
