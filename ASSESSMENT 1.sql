/* ASSESSMENT 1
High-Value Customers with Multiple Products
Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
*/

SELECT 
    uc.id AS owner_id,
    CONCAT(uc.first_name, ' ', uc.last_name) AS name,
    COUNT(DISTINCT CASE
            WHEN pp.is_regular_savings = 1 THEN pp.id
        END) AS savings_count,
    COUNT(DISTINCT CASE
            WHEN pp.is_a_fund = 1 THEN pp.id
        END) AS investment_count,
    SUM(s.amount) AS total_deposits
FROM
    users_customuser uc
        JOIN
    plans_plan pp ON uc.id = pp.owner_id
        JOIN
    savings_savingsaccount s ON uc.id = s.owner_id
WHERE
    pp.is_regular_savings > 0
        AND is_a_fund > 0
GROUP BY uc.id , name
ORDER BY total_deposits DESC;

/* FINDINGS
From our database it was discovered that no customer have a saving plan and an investment plan.
 
 PROCESS AND PROCEDURES
1. JOINS: The "users_customuser" table represented as "uc" was joined to "plans_plan " represented as "pp" 
using the unique key "id" and "owners_id" which was then joined to the "savings_savingsaccount" represented as "s"
2. WHERE CLAUSE: "pp.is_regular_savings > 0 AND is_a_fund > 0" this query filters customer with who have at least open
	a savings account or an investment account
3. GROUP BY: "uc.id , name" was used to group the returned values
4. SELECT: The select statement was used to identify the required fields, 
and some calculated aggregated function */