# Day 3 Notes: Phase 3 Root-Cause Investigation

## 1. High-Confidence Leak Profile vs Normal Orders
- **Normal Orders**: Average Shipping R$ 20.58 (29.7% of order revenue), Voucher usage: 3.18%.
- **High-Confidence Leaks (492 orders)**: 
  - Average Shipping shot up to **R$ 131.17** (**109.43% of order revenue**)! Freight was literally more expensive than the items sold.
  - Voucher usage surged to **16.48%**.
  - Average margin: **-R$ 227.16** per order. Total loss from this cluster alone: **-R$ 111,761.98**.

## 2. Top Offending Product Categories
1. **furniture_decor**: 306 high-confidence leak orders (Total net negative margin: -R$ 461,987). Bulky items with high volumetric shipping.
2. **housewares**: 264 high-confidence leak orders (-R$ 344,895). High shipping-to-price ratio.
3. **bed_bath_table**: 152 high-confidence leaks (-R$ 403,136).
4. **garden_tools**: 151 high-confidence leaks (-R$ 188,117).
5. **office_furniture**: Highest average shipping cost (**R$ 79.80** avg shipping).

## 3. Prescriptive Takeaway for C-Suite
The primary operational leakage is **unsubsidized heavy/bulky freight** combined with **promotional voucher stacking on low-margin furniture and houseware categories**.
