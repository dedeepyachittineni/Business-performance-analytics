-- KPI: Delivered Orders, Revenue, and Average Order Value (AOV)
-- Description:
-- Combines core commerce KPIs into a single query for executive reporting.
-- Uses delivered orders only and handles price stored as varchar.

SELECT
    COUNT(DISTINCT o.order_id) AS total_delivered_orders,
    SUM(CAST(oi.price AS decimal(18,2))) AS total_revenue,
    SUM(CAST(oi.price AS decimal(18,2)))
        / NULLIF(COUNT(DISTINCT o.order_id), 0) AS average_order_value
FROM dbo.orders o
JOIN dbo.order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND oi.price IS NOT NULL;
