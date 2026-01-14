# Insights & Recommendations – Late Delivery

## Objective
Reduce late delivery rate by identifying the highest-impact regions and operational drivers.

---

## Key Findings (from SQL RCA)
1. Late delivery rate varies significantly by region.
2. Certain seller states show consistently higher late delivery rates (fulfillment-side risk).
3. Certain customer states show higher late delivery rates (destination-side constraints).
4. High-volume regions should be prioritized first to maximize impact.

> Note: Exact states and percentages will be filled after running queries in SQLite/Power BI.

---

## Recommendations (Actionable)

### 1) Focus on High-Volume, High-Late Regions First
**Action:**
- Prioritize investigation and process fixes for seller/customer states with:
  - High delivered order volume AND
  - High late delivery rate

**Why this matters:**
- Fixing high-volume problem areas produces the biggest reduction in overall late delivery rate.

---

### 2) Seller Performance Management (SLA & Monitoring)
**Action:**
- Implement seller SLA tracking (late delivery rate per seller/state).
- Create a monthly seller scorecard:
  - Delivered volume
  - Late delivery rate
  - Average delivery time

**Why this matters:**
- Enables early detection of underperforming sellers and targeted improvement plans.

---

### 3) Operational Root-Cause Deep Dive
**Action:**
Break late deliveries into stages and identify where delays are happening:
- Purchase → shipping
- Shipping → delivery

**Why this matters:**
- Helps separate seller processing issues vs. logistics/delivery constraints.

---

### 4) Customer Experience Mitigation (Short-Term)
**Action:**
- Proactively communicate realistic delivery expectations in high-risk regions.
- Offer incentives or support when deliveries exceed estimates.

**Why this matters:**
- Reduces negative reviews and improves retention even before operational fixes fully take effect.

---

## Next Analysis to Validate (Planned)
- Relationship between late delivery and review score
- Late delivery impact on repeat purchase behavior
- Seller-level RCA (top 20 sellers by late rate and volume)


---

## Impact on Customer Satisfaction

### Insight
Orders delivered late have a noticeably lower average review score compared to on-time deliveries.
This confirms that delivery delays directly impact customer satisfaction and experience.

### Business Implication
- Late deliveries contribute to lower ratings and negative reviews
- Poor reviews can reduce repeat purchases and brand trust
- Operational issues translate into customer-facing risks

### Recommendation
- Treat late delivery reduction as a customer experience priority, not just an operations metric
- Track late delivery rate and review score together in executive dashboards
- Use delivery performance as an input into seller and logistics partner evaluations

