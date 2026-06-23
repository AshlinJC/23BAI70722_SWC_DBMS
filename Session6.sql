--Question:Supercloud Customer


SELECT 
  customers.customer_id, 
  COUNT(DISTINCT products.product_category) AS product_count
FROM customer_contracts AS customers
INNER JOIN products 
  ON customers.product_id = products.product_id
GROUP BY customers.customer_id;


--Question:User's Third Transaction

SELECT 
  user_id, 
  spend, 
  transaction_date, 
  ROW_NUMBER() OVER (
    PARTITION BY user_id ORDER BY transaction_date) AS row_num
FROM transactions;
