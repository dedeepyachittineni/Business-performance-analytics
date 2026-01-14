/* ============================================================
   Project: Olist E-commerce | Business Performance Analytics
   File: 01_data_setup_and_kpis.sql
   Source: Flat File Import (quoted column names)
   ============================================================ */

USE olist_db;
GO

/* ------------------------------------------------------------
   1) Create CLEAN tables (keep raw tables intact)
   ------------------------------------------------------------ */

-- Orders Clean
IF OBJECT_ID('dbo.orders_clean','U') IS NOT NULL
    DROP TABLE dbo.orders_clean;
GO

SELECT
    ["order_id"]                      AS order_id,
    ["customer_id"]                   AS customer_id,
    ["order_status"]                  AS order_status,
    TRY_CONVERT(datetime2, ["order_purchase_timestamp"])      AS order_purchase_ts,
    TRY_CONVERT(datetime2, ["order_approved_at"])             AS order_approved_ts,
    TRY_CONVERT(datetime2, ["order_delivered_carrier_date"])  AS delivered_carrier_ts,
    TRY_CONVERT(datetime2, ["order_delivered_customer_date"]) AS delivered_customer_ts,
    TRY_CONVERT(date,      ["order_estimated_delivery_date"]) AS estimated_delivery_date
INTO dbo.orders_clean
FROM dbo.orders;
GO

SELECT TOP 5 * FROM dbo.orders_clean;
GO


-- Order Items Clean
IF OBJECT_ID('dbo.order_items_clean','U') IS NOT NULL
    DROP TABLE dbo.order_items_clean;
GO

SELECT
    ["order_id"]          AS order_id,
    ["order_item_id"]     AS order_item_id,
    ["product_id"]        AS product_id,
    ["seller_id"]         AS seller_id,
    TRY_CONVERT(datetime2, ["shipping_limit_date"]) AS shipping_limit_ts,
    TRY_CONVERT(decimal(18,2), ["price"])           AS price,
    TRY_CONVERT(decimal(18,2), ["freight_value"])   AS freight_value
INTO dbo.order_items_clean
FROM dbo.order_items;
GO

SELECT TOP 5 * FROM dbo.order_items_clean;
GO


/* ------------------------------------------------------------
   2) Order-level Finance View (real-world practice)
   ------------------------------------------------------------ */

CREATE OR ALTER VIEW dbo.v_order_finance AS
SELECT
    order_id,
    SUM(ISNULL(price,0))                       AS items_revenue,
    SUM(ISNULL(freight_value,0))               AS freight_revenue,
    SUM(ISNULL(price,0) + ISNULL(freight_value,0)) AS total_order_value
FROM dbo.order_items_clean
GROUP BY order_id;
GO


/* ------------------------------------------------------------
   3) Core KPIs
   ------------------------------------------------------------ */

-- Total Revenue (Delivered)
SELECT
    SUM(v.total_order_value) AS total_revenue
FROM dbo.v_order_finance v
JOIN dbo.orders_clean o
    ON o.order_id = v.order_id
WHERE o.order_status = 'delivered';
GO

-- AOV (Delivered)
SELECT
    CAST(
        SUM(v.total_order_value) / NULLIF(COUNT(*),0)
        AS decimal(18,2)
    ) AS aov
FROM dbo.v_order_finance v
JOIN dbo.orders_clean o
    ON o.order_id = v.order_id
WHERE o.order_status = 'delivered';
GO

-- Late Delivery Rate
SELECT
    COUNT(*) AS delivered_orders,
    SUM(CASE
            WHEN o.delivered_customer_ts > o.estimated_delivery_date
                THEN 1 ELSE 0
        END) AS late_delivered_orders,
    CAST(
        100.0 * SUM(CASE
                        WHEN o.delivered_customer_ts > o.estimated_delivery_date
                            THEN 1 ELSE 0
                    END)
        / NULLIF(COUNT(*), 0)
        AS decimal(5,2)
    ) AS late_delivery_rate_pct
FROM dbo.orders_clean o
WHERE o.order_status = 'delivered'
  AND o.delivered_customer_ts IS NOT NULL
  AND o.estimated_delivery_date IS NOT NULL;
GO

-- Late Delivery Rate by Month
SELECT
    CONVERT(char(7), o.order_purchase_ts, 120) AS order_month,
    COUNT(*) AS delivered_orders,
    SUM(CASE
            WHEN o.delivered_customer_ts > o.estimated_delivery_date
                THEN 1 ELSE 0
        END) AS late_orders,
    CAST(
        100.0 * SUM(CASE
                        WHEN o.delivered_customer_ts > o.estimated_delivery_date
                            THEN 1 ELSE 0
                    END)
        / NULLIF(COUNT(*), 0)
        AS decimal(5,2)
    ) AS late_rate_pct
FROM dbo.orders_clean o
WHERE o.order_status = 'delivered'
GROUP BY CONVERT(char(7), o.order_purchase_ts, 120)
ORDER BY order_month;
GO
