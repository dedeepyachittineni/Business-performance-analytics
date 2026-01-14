-- KPI: Total Orders
-- Description: Counts the number of unique orders placed

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;
