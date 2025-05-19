/* Account Inactivity Alert
Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .
*/

SELECT 
    pp.id AS plan_id,
    pp.owner_id,
    CASE 
        WHEN pp.is_regular_savings = 1 THEN 'Savings'
        WHEN pp.is_a_fund = 1 THEN 'Investment'
        ELSE 'Unknown'
    END AS type,
    pp.last_charge_date AS last_transaction_date,
    DATEDIFF(CURDATE(), pp.last_charge_date) AS inactivity_days
FROM 
    plans_plan pp
WHERE 
    pp.last_charge_date IS NOT NULL
    AND DATEDIFF(CURDATE(), pp.last_charge_date) > 365