CREATE OR REFRESH STREAMING TABLE deltaguard.silver.products_silver
(
    CONSTRAINT valid_product EXPECT (product_id IS NOT NULL) ON VIOLATION FAIL UPDATE,
    CONSTRAINT valid_price EXPECT (price>0) ON VIOLATION DROP ROW,
    CONSTRAINT valid_name EXPECT(name IS NOT NULL)
)
AS
SELECT
        DISTINCT product_id,
        INITCAP(TRIM(name)) AS name,
        CAST(price AS DOUBLE) AS price,
        CASE
            WHEN price<100 THEN 'Low'
            WHEN price BETWEEN 100 AND 500 THEN 'Medium'
            WHEN price>500 THEN 'High'
            END AS price_category
FROM STREAM deltaguard.bronze.products_bronze;