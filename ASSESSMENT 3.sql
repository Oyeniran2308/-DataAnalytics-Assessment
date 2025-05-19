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
    AND DATEDIFF(CURDATE(), pp.last_charge_date) > 365;
    
/* 
FINDINGS
893 account have not been active for the past 365days and above, following the categorization that 
was stated in the query 69 account type are Investment, 542 were savings while 282 are unknown.
(CASE 
        WHEN pp.is_regular_savings = 1 THEN 'Savings'
        WHEN pp.is_a_fund = 1 THEN 'Investment'
        ELSE 'Unknown'
    END AS type),

RECOMMENDATION
1. Further investigation be carried out to understand why a large portion (542) of savings account holders 
have been inactive for over a year.

2. The 282 accounts labeled as "Unknown" should be reviewed to determine why they could not be categorized and to ensure data consistency and completeness.
*/


    