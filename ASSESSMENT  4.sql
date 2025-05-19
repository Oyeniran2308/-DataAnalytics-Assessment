/* Customer Lifetime Value (CLV) Estimation
Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, 
calculate:
Account tenure (months since signup)
Total transactions
Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Order by estimated CLV from highest to lowest */

SELECT
    uc.id AS customer_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'), DATE_FORMAT(uc.date_joined, '%Y%m')) AS tenure_months,
    COUNT(ss.id) AS total_transactions,
    ROUND((
        (COUNT(ss.id) / 
         NULLIF(PERIOD_DIFF(DATE_FORMAT(CURDATE(), '%Y%m'), DATE_FORMAT(uc.date_joined, '%Y%m')), 0)) * 12
         * (0.001 * AVG(ss.amount))
    ), 2) AS estimated_clv
FROM
    users_customuser uc
JOIN
    savings_savingsaccount ss ON uc.id = ss.owner_id
GROUP BY
    uc.id, name, tenure_months
ORDER BY
    estimated_clv DESC;

/* 
FINDINGS

Out of the 873 returned customers, Chima Ataman (Customer ID: 1909df3eba2548cfa3b9c270112bd262) stands out with the 🥇 highest estimated Customer Lifetime Value (CLV). Over a tenure of 33 months, Chima has completed 2,383 transactions, 
making him the top contributor in terms of long-term value to the business. */