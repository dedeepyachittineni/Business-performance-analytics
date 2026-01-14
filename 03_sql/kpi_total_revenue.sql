-- KPI: Total Revenue
-- Description: Calculates total sales value from all items sold

SELECT
    SUM(price) AS total_revenue
FROM order_items;
