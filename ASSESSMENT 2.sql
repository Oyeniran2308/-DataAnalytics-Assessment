 /*Transaction Frequency Analysis
Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
Task: Calculate the average number of transactions per customer per month and categorize them:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month) */

WITH monthly_transaction AS (
    SELECT 
        owner_id,
        MONTH(transaction_date) AS trx_month,
        COUNT(*) AS monthly_trx_per_customer
    FROM 
        savings_savingsaccount AS ss 
    JOIN 
        users_customuser AS uc ON ss.owner_id = uc.id
    GROUP BY 
        owner_id, MONTH(transaction_date)
),
average_per_customer AS (
    SELECT 
        owner_id,
        AVG(monthly_trx_per_customer) AS avg_monthly_trx
    FROM 
        monthly_transaction
    GROUP BY 
        owner_id
)
SELECT 
    CASE 
        WHEN avg_monthly_trx >= 10 THEN 'High Frequency'
        WHEN avg_monthly_trx BETWEEN 3 AND 9 THEN 'Medium Frequency'
        WHEN avg_monthly_trx <= 2 THEN 'Low Frequency'
        ELSE 'Uncategorized'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_monthly_trx), 2) AS avg_transactions_per_month
FROM 
    average_per_customer
GROUP BY 
    frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');

/* FINDINGS 
The Customer transaction Frequency was majorly categorise into three (four if the condition is 
not mets; High Frequency for monthly transaction ≥10, 
Medium Frequency for monthly transaction between 3-9, Low Frequency for transaction ≤2, 
and Uncategorized for transaction that does not fall in the category.
For High Frequency, there are  173 customer with an average of 77.74 transaction per month
Medium Frequency, there are  174 customer with an average of 4.78 transaction per month
Low Frequency, there are  485 customer with an average of 1.26 transaction per month
*/