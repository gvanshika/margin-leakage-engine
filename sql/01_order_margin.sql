WITH base AS (
    SELECT
        i.order_id,
        i.order_item_id,
        i.product_id,
        COALESCE(c.product_category_name_english, 'unknown')  AS category_english,
        i.price                                               AS revenue,
        i.freight_value                                       AS shipping,
        COALESCE(a.cogs_pct, 0.50)                            AS cogs_pct,
        COALESCE(a.return_rate, 0.05)                         AS return_rate,
        COALESCE(a.return_cost_pct, 0.25)                     AS return_cost_pct,
        50.0                                                  AS ad_cac   -- assumption: flat CAC per item (BRL)
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
    category_english,
    revenue,
    revenue * cogs_pct                                   AS cogs,
    ad_cac,
    shipping,
    revenue * return_rate * return_cost_pct              AS return_allowance,
    revenue
      - revenue * cogs_pct
      - ad_cac
      - shipping
      - revenue * return_rate * return_cost_pct          AS realized_margin
FROM base;
