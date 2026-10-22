# Day 1 Notes: Margin Leakage Engine Foundation

## 1. Realized Margin Formula
```
Realized Margin = Revenue − COGS − Ad CAC − Shipping − Return Allowance
```
- **Revenue**: Item sale price (`price` from Olist order items).
- **COGS**: Cost of Goods Sold estimated as `Revenue * cogs_pct`.
- **Ad CAC**: Customer Acquisition Cost allocated per item (assumed baseline: R$ 50.00 flat).
- **Shipping**: Freight cost per item (`freight_value`).
- **Return Allowance**: Expected return loss calculated as `Revenue * return_rate * return_cost_pct`.

## 2. Rationale for Assumptions (`data/assumptions.csv`)
Since Olist is a marketplace transaction log without internal cost structures, we model:
- `health_beauty`: Higher gross margins (`cogs_pct: 0.45`), moderate returns (`0.05`).
- `computers_accessories`: Lower margins / expensive components (`cogs_pct: 0.60`), higher return risk (`0.08`).
- `furniture_decor`: Bulk logistics risk (`return_cost_pct: 0.20`), standard COGS (`0.50`).
- Default fallback for unmatched categories: 50% COGS, 5% return rate, 25% return loss.

## 3. Key Observations & Anomaly Signals
- High proportion of items exhibiting **negative contribution margin** due to low AOV items where fixed `ad_cac` (R$ 50) + shipping exceeds gross profit.
- This highlights the exact business problem: **unthrottled acquisition spend on low-margin / low-ticket items causes silent cash burn.**
