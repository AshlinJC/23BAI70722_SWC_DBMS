--Question:Pages Currently Active

WITH latest_status AS (
    SELECT
        page_id,
        status,
        ROW_NUMBER() OVER (
            PARTITION BY page_id
            ORDER BY changed_at DESC, event_id DESC
        ) AS rn
    FROM page_status_log
)
SELECT COUNT(*) AS active_pages
FROM latest_status
WHERE rn = 1
  AND status = 'active';

--Question:Positive Ad Channels

WITH channel_stats AS (
    SELECT
        advertising_channel,
        MIN(customers_acquired) AS min_customers,
        MAX(money_spent) AS max_spent
    FROM uber_advertising
    GROUP BY advertising_channel
)
SELECT advertising_channel
FROM channel_stats
WHERE min_customers > 1500
  AND max_spent = (
      SELECT MIN(max_spent)
      FROM channel_stats
      WHERE min_customers > 1500
  );
