-- Root Cause: Late Delivery Rate by Seller State
-- Description: Identifies seller regions with the highest late delivery rates

SELECT
    s.seller_state,
    COUNT(*) AS delivered_orders,
    SUM(CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
        ELSE 0
    END) AS late_orders,
    ROUND(
        100.0 * SUM(CASE
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
            ELSE 0
        END) / COUNT(*)
    , 2) AS late_delivery_rate_pct
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY s.seller_state
HAVING COUNT(*) >= 100
ORDER BY late_delivery_rate_pct DESC;
