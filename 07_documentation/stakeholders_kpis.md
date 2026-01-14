# Stakeholders and Key Performance Indicators

## Primary Stakeholders
- Executive Leadership (CEO, COO)
- Finance Team
- Operations Team
- Marketing Team
- Product & Seller Management

## Key Business KPIs

### Revenue & Sales
- Total Revenue
- Revenue Growth Rate
- Average Order Value (AOV)
- Orders per Customer

### Customer Metrics
- Active Customers
- Customer Retention Rate
- Repeat Purchase Rate
- Customer Lifetime Value (Estimated)

### Operations Metrics
- Average Delivery Time
- Late Delivery Rate
- Order Fulfillment Time
- Seller SLA Compliance

### Product & Seller Performance
- Top Performing Products
- Underperforming Sellers
- Cancellation Rate
- Customer Review Score


# KPI Dictionary (Olist E-commerce)

This document defines core business KPIs used in the dashboards and analysis.
All KPIs are designed for executive decision-making and operational monitoring.

---

## Revenue & Sales KPIs

### 1. Total Revenue
Definition: Total sales value from all items sold.
Formula: SUM(order_items.price)
Tables/Fields:
- order_items.price
Business Use: Measures overall sales performance.

---

### 2. Total Orders
Definition: Number of unique orders placed.
Formula: COUNT(DISTINCT orders.order_id)
Tables/Fields:
- orders.order_id
Business Use: Measures demand volume.

---

### 3. Average Order Value (AOV)
Definition: Average revenue per order.
Formula: Total Revenue / Total Orders
Tables/Fields:
- order_items.price
- orders.order_id
Business Use: Helps evaluate pricing and upsell performance.

---

## Customer KPIs

### 4. Active Customers
Definition: Number of unique customers who placed at least one order.
Formula: COUNT(DISTINCT orders.customer_id)
Tables/Fields:
- orders.customer_id
Business Use: Measures customer base size and engagement.

---

### 5. Repeat Purchase Rate
Definition: Percentage of customers who placed more than one order.
Formula: Customers with >=2 orders / Total customers
Tables/Fields:
- orders.customer_id
Business Use: Measures retention and loyalty.

---

## Operations KPIs

### 6. Average Delivery Time (Days)
Definition: Average days from purchase to delivery.
Formula: AVG(order_delivered_customer_date - order_purchase_timestamp)
Tables/Fields:
- orders.order_purchase_timestamp
- orders.order_delivered_customer_date
Business Use: Monitors fulfillment speed and customer experience.

---

### 7. Late Delivery Rate
Definition: Percentage of orders delivered after the estimated delivery date.
Formula: Late delivered orders / Total delivered orders
Tables/Fields:
- orders.order_delivered_customer_date
- orders.order_estimated_delivery_date
- orders.order_status
Business Use: Tracks SLA performance and operational risk.

---

## Customer Experience KPIs

### 8. Average Review Score
Definition: Average customer review rating.
Formula: AVG(reviews.review_score)
Tables/Fields:
- reviews.review_score
Business Use: Measures customer satisfaction.

---

## Product & Seller KPIs

### 9. Top Product Categories by Revenue
Definition: Revenue by product category.
Formula: SUM(order_items.price) grouped by product_category_name
Tables/Fields:
- order_items.price
- products.product_category_name
Business Use: Identifies best-performing categories.

---

### 10. Seller Performance (Revenue)
Definition: Revenue contribution by seller.
Formula: SUM(order_items.price) grouped by seller_id
Tables/Fields:
- order_items.price
- order_items.seller_id
Business Use: Identifies top and underperforming sellers.
