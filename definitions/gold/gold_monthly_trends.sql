CREATE OR REFRESH MATERIALIZED VIEW gold_monthly_trends AS
SELECT 
        transaction_month,
        COUNT(txn_id) AS txn_count,
        SUM(amount) AS monthly_revenue,
        SUM(CASE
                WHEN high_value_flag = TRUE THEN 1
                ELSE 0
                END) AS high_value_txn
FROM deltaguard.silver.transactions_silver
GROUP BY transaction_month
ORDER BY transaction_month;