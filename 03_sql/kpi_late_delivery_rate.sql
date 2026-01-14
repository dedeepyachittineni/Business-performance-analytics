-- KPI: Late Delivery Rate (Delivered Orders)
-- Definition: % of delivered orders where delivered_customer_date > estimated_delivery_date.
-- Notes: Uses TRY_CONVERT for date safety and NULLIF to avoid divide-by-zero.

SELECT
    COUNT(*) AS delivered_orders,
    SUM(CASE
            WHEN TRY_CONVERT(datetime2, o.order_delivered_customer_date)
               > TRY_CONVERT(datetime2, o.order_estimated_delivery_date) THEN 1
            ELSE 0
        END) AS late_delivered_orders,
    CAST(
        100.0 * SUM(CASE
                        WHEN TRY_CONVERT(datetime2, o.order_delivered_customer_date)
                           > TRY_CONVERT(datetime2, o.order_estimated_delivery_date) THEN 1
                        ELSE 0
                    END)
        / NULLIF(COUNT(*), 0)
        AS decimal(5,2)
    ) AS late_delivery_rate_pct
FROM dbo.orders o
WHERE o.order_status = 'delivered'
  AND TRY_CONVERT(datetime2, o.order_delivered_customer_date) IS NOT NULL
  AND TRY_CONVERT(datetime2, o.order_estimated_delivery_date) IS NOT NULL;
