# Data Model – Star Schema

## Overview
This project uses a star schema to support business reporting and decision-making.
The model is designed to analyze revenue, customer behavior, product performance,
seller efficiency, and customer satisfaction.

The central fact table is `order_items`, as it captures item-level sales and revenue.

---

## Fact Table

### order_items (Fact)
Grain: One row per product per order

Key columns:
- order_id
- product_id
- seller_id
- price
- freight_value

Business metrics:
- Revenue
- Number of items sold
- Freight cost

---

## Dimension Tables

### orders (Dimension)
- order_id
- customer_id
- order_status
- order_purchase_timestamp
- order_delivered_customer_date

Purpose:
Tracks order lifecycle and time-based analysis.

---

### customers (Dimension)
- customer_id
- customer_city
- customer_state

Purpose:
Customer segmentation and geographic analysis.

---

### products (Dimension)
- product_id
- product_category_name

Purpose:
Product and category performance analysis.

---

### sellers (Dimension)
- seller_id
- seller_city
- seller_state

Purpose:
Seller performance and fulfillment analysis.

---

### payments (Dimension)
- order_id
- payment_type
- payment_value
- payment_installments

Purpose:
Payment method and financial insights.

---

### reviews (Dimension)
- order_id
- review_score

Purpose:
Customer satisfaction and experience analysis.

---

## Business Context and Design Rationale

This data model was designed to support real-world business analysis and decision-making.
The star schema structure enables clear, consistent reporting across revenue, customers,
products, sellers, operations, and customer experience.

Design decisions were made to:
- Capture revenue at the most accurate level (item-level sales)
- Support flexible analysis across multiple business dimensions
- Enable clear KPI definitions and performance tracking
- Reduce reporting complexity for dashboards and stakeholder reviews
- Align operational data with strategic business questions

This structure allows analysts and decision-makers to efficiently explore trends,
identify issues, and make informed, data-driven decisions and also this design ensures the data model can support both strategic analysis
and day-to-day operational reporting needs.

