# Day 2 Notes: Phase 2 Leakage Detection & Anomaly Discovery

## 1. Comparison of Detection Methods
- **IQR (Statistical Method)**: Evaluated 1-dimensional distribution on `order_realized_margin`. Flagged **2,070** orders below the lower threshold.
- **Isolation Forest (Unsupervised ML)**: Multi-dimensional space using `[order_revenue, order_shipping, order_realized_margin, shipping_ratio_pct, voucher_pct]`. Flagged **2,895** orders.
- **High-Confidence Intersection**: **492** orders were identified by *both* methods as catastrophic margin drains.

## 2. Core Drivers of Identified Leakages
1. **Shipping Ratio Explosion**: Orders where logistics fees exceeded 60%+ of product revenue.
2. **Voucher / Promo Cannibalization**: Heavy reliance on vouchers on already compressed margin categories.
3. **Fixed CAC Overhead**: Flat acquisition costs eroding small-ticket basket sizes.
