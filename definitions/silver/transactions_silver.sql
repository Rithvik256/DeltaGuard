CREATE OR REFRESH STREAMING TABLE deltaguard.silver.transactions_silver
(
    CONSTRAINT valid_amount EXPECT (amount>0) ON VIOLATION DROP ROW,
    CONSTRAINT valid_customer EXPECT (customer_id IS NOT NULL) ON VIOLATION DROP ROW,
    CONSTRAINT valid_timestamp EXPECT (txn_time IS NOT NULL)
)
AS
SELECT
        DISTINCT txn_id,
        customer_id,
        CAST(amount AS DOUBLE) AS amount,
        CAST(timestamp AS TIMESTAMP) AS txn_time,
        DATE_FORMAT(TO_DATE(timestamp),'MM') AS transaction_month,
        product_id,
        CASE
            WHEN amount>1000 THEN TRUE
            ELSE FALSE
            END AS high_value_flag
FROM STREAM deltaguard.bronze.transactions_bronze;