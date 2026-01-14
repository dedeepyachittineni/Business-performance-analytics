-- KPI: Average Order Value (AOV)
-- Description: Calculates average revenue per order

SELECT
    SUM(oi.price) / COUNT(DISTINCT o.order_id) AS average_order_value
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id;
