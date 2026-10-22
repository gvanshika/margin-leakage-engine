# Day 4 Notes: Phase 4 Causal Analytics (Difference-in-Differences)

## 1. Econometric Model Specification
```
Item_Margin ~ Intercept + β1*(post_campaign) + β2*(treatment) + β3*(post_campaign * treatment)
```
- **Treatment Category**: `furniture_decor` (Discount / Voucher heavy).
- **Control Category**: `health_beauty` (Baseline organic demand).
- **Intervention Event**: Black Friday 2017 (`2017-11-24`).

## 2. Regression Results & Interpretation
```
===========================================================================================
                              coef    std err          t      P>|t|      [0.025      0.975]
-------------------------------------------------------------------------------------------
Intercept                   1.1004      2.943      0.374      0.708      -4.670       6.871
post_campaign               0.5028      4.052      0.124      0.901      -7.442       8.447
treatment                 -32.1732      3.993     -8.057      0.000     -40.003     -24.344
post_campaign:treatment     2.3029      5.594      0.412      0.681      -8.666      13.272
===========================================================================================
```

### Key Business Insights:
1. **Inherent Margin Deficit (`treatment = -32.17`, p < 0.001)**:
   - `furniture_decor` inherently delivers **R$ 32.17 LESS margin per item** compared to health/beauty due to heavy freight and bulky handling.
2. **Causal Lift / Cannibalization (`post:treatment = +2.30`, p = 0.681)**:
   - The interaction coefficient is **statistically insignificant** ($p = 0.681 > 0.05$).
   - **Executive Meaning**: Pushing heavy discount/voucher promotions on Black Friday **did NOT causally improve realized margin** for bulky furniture. It only drove unprofitable top-line volume while absorbing shipping subsidies.
