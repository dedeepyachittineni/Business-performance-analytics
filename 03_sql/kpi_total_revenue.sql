-- KPI: Total Delivered Revenue
-- Description:
-- Calculates total revenue from delivered orders only.
-- Note: price is stored as varchar in the raw dataset and is cast to decimal
-- to ensure accurate aggregation.

SELECT
    SUM(CAST(oi.price AS decimal(18,2))) AS total_revenue
FROM dbo.order_items oi
JOIN dbo.orders o
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND oi.price IS NOT NULL;

