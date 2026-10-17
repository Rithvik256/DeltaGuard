CREATE OR REFRESH MATERIALIZED VIEW gold_product_sales AS
SELECT 
    p.product_id,
    p.name,
    p.price_category,
    COUNT(p.name) AS units_sold,
    SUM(t.amount) AS total_revenue,
    AVG(t.amount) AS avg_revenue_per_txn
FROM deltaguard.silver.transactions_silver t
INNER JOIN deltaguard.silver.products_silver p
ON p.product_id=t.product_id
GROUP BY p.product_id, p.name, p.price_category
ORDER BY p.product_id ASC;