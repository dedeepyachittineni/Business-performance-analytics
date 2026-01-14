-- RCA: Late Delivery by Month
-- Purpose: Identify months with unusually high late delivery rates

SELECT
    CONVERT(char(7), TRY_CONVERT(datetime2, o.order_purchase_timestamp), 120) AS order_month,
    COUNT(*) AS delivered_orders,
    SUM(
        CASE
            WHEN TRY_CONVERT(datetime2, o.order_delivered_customer_date)
               > TRY_CONVERT(datetime2, o.order_estimated_delivery_date)
            THEN 1
            ELSE 0
        END
    ) AS late_orders,
    CAST(
        100.0 * SUM(
            CASE
                WHEN TRY_CONVERT(datetime2, o.order_delivered_customer_date)
                   > TRY_CONVERT(datetime2, o.order_estimated_delivery_date)
                THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(*), 0)
        AS decimal(5,2)
    ) AS late_rate_pct
FROM dbo.orders o
WHERE o.order_status = 'delivered'
  AND TRY_CONVERT(datetime2, o.order_purchase_timestamp) IS NOT NULL
  AND TRY_CONVERT(datetime2, o.order_delivered_customer_date) IS NOT NULL
  AND TRY_CONVERT(datetime2, o.order_estimated_delivery_date) IS NOT NULL
GROUP BY CONVERT(char(7), TRY_CONVERT(datetime2, o.order_purchase_timestamp), 120)
ORDER BY late_rate_pct DESC;
