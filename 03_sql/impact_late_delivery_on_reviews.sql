-- Impact Analysis: Late Delivery vs Review Score
-- Description: Compares average review scores for late vs on-time deliveries

SELECT
    CASE
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
            THEN 'Late Delivery'
        ELSE 'On-Time Delivery'
    END AS delivery_status,
    COUNT(*) AS total_orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score
FROM orders o
JOIN reviews r
    ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_status;
