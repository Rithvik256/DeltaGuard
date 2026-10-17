CREATE OR REFRESH STREAMING TABLE deltaguard.silver.customers_silver
(
    CONSTRAINT valid_customer EXPECT (customer_id IS NOT NULL) ON VIOLATION FAIL UPDATE,
    CONSTRAINT valid_email EXPECT (email IS NOT NULL AND email LIKE '%@%') ON VIOLATION DROP ROW,
    CONSTRAINT valid_signup EXPECT (signup_date IS NOT NULL)
)
AS
SELECT
        customer_id,
        INITCAP(TRIM(name)) AS name,
        lower(email) AS email,
        TO_DATE(signup_date) AS signup_date,
        DATE_FORMAT(TO_DATE(signup_date),'yyyy-MM') AS signup_year_month
FROM STREAM deltaguard.bronze.customers_bronze;