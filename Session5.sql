--Question 1
--Data Lemur - Active User Retention

SELECT 7 AS month, COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_actions
WHERE event_date>='2022-07-01' AND event_date<'2022-08-01'
AND user_id IN (
        SELECT DISTINCT user_id
        FROM user_actions
        WHERE event_date>='2022-06-01' AND event_date<'2022-07-01'
    );



--Question 2
--Data Lemur - Repeated Payments

WITH cte AS (
    SELECT transaction_id, merchant_id, credit_card_id, amount,
    transaction_timestamp, LAG(transaction_timestamp) OVER (
      PARTITION BY merchant_id, credit_card_id, amount
      ORDER BY transaction_timestamp
      ) AS prev_time
    FROM transactions
)
SELECT COUNT(*) AS payment_count
FROM cte
WHERE EXTRACT(EPOCH FROM (transaction_timestamp - prev_time))/60 <= 10;


