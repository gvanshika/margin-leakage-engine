# Phase 6: Power BI Executive Cockpit Guide

## 1. Clean Exported Dataset Ready for Power BI
- **File Location**: `data/powerbi_margin_leakage_clean.csv`
- **Total Records**: **108,638 order item transactions**
- **Pre-computed Fields**:
  - `revenue`, `cogs`, `ad_cac`, `shipping_cost`, `return_allowance`, `realized_margin`
  - `shipping_ratio_pct`, `voucher_amount`, `is_critical_leak`
  - `order_month`, `category`

---

## 2. Recommended Power BI Layout (3 Visual Cockpit)

### A. Top KPI Cards:
1. **Total Realized Margin**: `SUM(realized_margin)` (Format: Currency in Red/Green)
2. **Total Margin Loss**: `CALCULATE(SUM(realized_margin), realized_margin < 0)`
3. **Critical Leaking Orders**: `SUM(is_critical_leak)`
4. **Average Freight-to-Price %**: `AVERAGE(shipping_ratio_pct)`

### B. Core Visuals:
1. **Monthly Margin Decay (Line & Clustered Column Chart)**:
   - X-Axis: `order_month`
   - Column: `revenue`
   - Line: `realized_margin` (Highlights the divergence where Revenue goes up but Margin decays)
2. **Category Margin Drain Waterfall / Bar Chart**:
   - Y-Axis: `category`
   - X-Axis: `realized_margin` (Sorted ascending to show top loss makers like `furniture_decor`)
3. **Scatter Plot (Freight Shock Anomaly Visualizer)**:
   - X-Axis: `revenue`
   - Y-Axis: `shipping_cost`
   - Size: `voucher_amount`
   - Color: `is_critical_leak` (Instantly flags orders above the 45-degree parity line)

---

## 3. What-If Parameter (Prescriptive Simulator)
In Power BI:
1. Go to **Modeling** tab -> **New Parameter** -> **Numeric range**.
2. Name: `Freight Surcharge on Bulky %` (Range: 0% to 50%, Increment: 5%).
3. Measure:
   ```dax
   Simulated Recovered Margin = 
   SUM(powerbi_margin_leakage_clean[realized_margin]) + 
   CALCULATE(
       SUM(powerbi_margin_leakage_clean[shipping_cost]) * [Freight Surcharge on Bulky % Value],
       powerbi_margin_leakage_clean[category] IN {"furniture_decor", "office_furniture"}
   )
   ```
This lets any executive move the slider in Power BI to see how much margin is recovered in real-time!
