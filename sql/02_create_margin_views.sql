-- Step 2: Create a persistent analytical view of order item margins
CREATE OR REPLACE VIEW v_order_item_margins AS
WITH base AS (
    SELECT
        i.order_id,
        i.order_item_id,
        i.product_id,
        o.customer_id,
        o.order_purchase_timestamp,
        COALESCE(c.product_category_name_english, 'unknown')  AS category_english,
        i.price                                               AS revenue,
        i.freight_value                                       AS shipping,
        COALESCE(a.cogs_pct, 0.50)                            AS cogs_pct,
        COALESCE(a.return_rate, 0.05)                         AS return_rate,
        COALESCE(a.return_cost_pct, 0.25)                     AS return_cost_pct,
        50.0                                                  AS ad_cac   -- flat CAC assumption per item (BRL)
    FROM items i
    JOIN orders o
        ON i.order_id = o.order_id
    LEFT JOIN products p
        ON i.product_id = p.product_id
    LEFT JOIN categories c
        ON p.product_category_name = c.product_category_name
    LEFT JOIN assumptions a
        ON c.product_category_name_english = a.category_english
    WHERE o.order_status = 'delivered'
)
SELECT
    order_id,
    order_item_id,
    product_id,
    customer_id,
    order_purchase_timestamp,
    category_english,
    revenue,
    revenue * cogs_pct                                   AS cogs,
    ad_cac,
    shipping,
    revenue * return_rate * return_cost_pct              AS return_allowance,
    revenue
      - (revenue * cogs_pct)
      - ad_cac
      - shipping
      - (revenue * return_rate * return_cost_pct)        AS realized_margin,
    -- Margin flag
    CASE 
        WHEN (revenue - (revenue * cogs_pct) - ad_cac - shipping - (revenue * return_rate * return_cost_pct)) < 0 
        THEN 1 ELSE 0 
    END AS is_negative_margin
FROM base;

-- Aggregated Order-Level View
CREATE OR REPLACE VIEW v_order_margins AS
SELECT
    order_id,
    customer_id,
    MIN(order_purchase_timestamp) AS order_purchase_timestamp,
    COUNT(order_item_id)          AS total_items,
    SUM(revenue)                  AS order_revenue,
    SUM(cogs)                     AS order_cogs,
    SUM(ad_cac)                   AS order_ad_cac,
    SUM(shipping)                 AS order_shipping,
    SUM(return_allowance)         AS order_return_allowance,
    SUM(realized_margin)          AS order_realized_margin,
    ROUND(SUM(realized_margin) / NULLIF(SUM(revenue), 0) * 100, 2) AS order_margin_pct
FROM v_order_item_margins
GROUP BY order_id, customer_id;
