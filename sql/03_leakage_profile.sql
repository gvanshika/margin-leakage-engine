# Phase 2 Leakage Investigation: Profiling Anomalous Orders
WITH order_leak_profile AS (
    SELECT 
        iso_forest_anomaly,
        iqr_anomaly,
        COUNT(*) AS total_orders,
        ROUND(AVG(order_revenue), 2) AS avg_revenue,
        ROUND(AVG(order_shipping), 2) AS avg_shipping,
        ROUND(AVG(shipping_ratio_pct), 2) AS avg_shipping_pct_of_rev,
        ROUND(AVG(voucher_pct), 2) AS avg_voucher_pct,
        ROUND(AVG(order_realized_margin), 2) AS avg_realized_margin,
        ROUND(SUM(order_realized_margin), 2) AS total_margin_impact
    FROM df_clean
    GROUP BY 1, 2
)
SELECT * FROM order_leak_profile
ORDER BY avg_realized_margin ASC;
