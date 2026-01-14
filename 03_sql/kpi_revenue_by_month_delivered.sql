-- KPI: Revenue by Month (Delivered Orders Only)
-- Description: Monthly revenue trend for delivered orders

SELECT
    substr(o.order_purchase_timestamp, 1, 7) AS order_month,
    SUM(oi.price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY substr(o.order_purchase_timestamp, 1, 7)
ORDER BY order_month;
