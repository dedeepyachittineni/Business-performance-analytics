-- KPI: Late Delivery Rate
-- Description: % of delivered orders that arrived after the estimated delivery date

SELECT
    ROUND(
        100.0 * SUM(CASE
            WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
            ELSE 0
        END) / COUNT(*)
    , 2) AS late_delivery_rate_pct
FROM orders o
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL;
