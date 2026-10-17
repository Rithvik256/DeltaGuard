CREATE OR REFRESH MATERIALIZED VIEW deltaguard.gold.customer_activity AS
SELECT
        c.customer_id,
        c.name,
        c.email,
        COUNT(t.txn_id) AS txn_count,
        SUM(t.amount) AS total_spent,
        AVG(t.amount) AS avg_spent,
        MIN(c.signup_date) AS first_txn_date,
        MAX(c.signup_date) AS last_txn_date
FROM deltaguard.silver.customers_silver c
INNER JOIN deltaguard.silver.transactions_silver t
ON c.customer_id=t.customer_id
GROUP BY c.customer_id, c.name, c.email
ORDER BY c.customer_id ASC;