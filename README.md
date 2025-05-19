👨‍🦱 NAME: OYENIRAN TOBI 

📩 EMAIL: OYENIRANTOBI@GMAIL.COM

📱 PHONE NUMBER: 08147670931

# -DataAnalytics-Assessment
Cowrywise SQL Proficiency Assessment

### 1. High-Value Customers with Multiple Products
Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).
Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

##### Findings: 
From our database it was discovered that no customer have a saving plan and an investment plan.
 
##### PROCESS AND PROCEDURES
1. JOINS: The "users_customuser" table represented as "uc" was joined to "plans_plan " represented as "pp" 
using the unique key "id" and "owners_id" which was then joined to the "savings_savingsaccount" represented as "s"
2. WHERE CLAUSE: "pp.is_regular_savings > 0 AND is_a_fund > 0" this query filters customer with who have at least open
	a savings account or an investment account
3. GROUP BY: "uc.id , name" was used to group the returned values
4. SELECT: The select statement was used to identify the required fields, 
and some calculated aggregated function

### 2. Transaction Frequency Analysis
Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).
Task: Calculate the average number of transactions per customer per month and categorize them:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month)

##### FINDINGS 
The Customer transaction Frequency was categorise into four ; 
* High Frequency for monthly transaction ≥10

* Medium Frequency for monthly transaction between 3-9

* Low Frequency for transaction ≤2 

* Uncategorized for transaction that does not fall in the category.

For High Frequency, there are  173 customer with an average of 77.74 transaction per month
Medium Frequency, there are  174 customer with an average of 4.78 transaction per month
Low Frequency, there are  485 customer with an average of 1.26 transaction per month

### 3.  Account Inactivity Alert
Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .

##### Findings
A total of 893 accounts have not recorded any activity for the past 365 days or more. Based on the categorization logic:

69 accounts are classified as Investment accounts

542 accounts fall under Savings

282 accounts are categorized as Unknown

(CASE 
        WHEN pp.is_regular_savings = 1 THEN 'Savings'
        WHEN pp.is_a_fund = 1 THEN 'Investment'
        ELSE 'Unknown'
    END AS type),

##### RECOMMENDATION

Further investigation be carried out to understand why a large portion (542) of savings account holders have been inactive for over a year.

The 282 accounts labeled as "Unknown" should be reviewed to determine why they could not be categorized and to ensure data consistency and completeness.


### 4. Customer Lifetime Value (CLV) Estimation
Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).
Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
Account tenure (months since signup)
Total transactions
Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Order by estimated CLV from highest to lowest

###### Findings
Out of the 873 returned customers, Chima Ataman (Customer ID: 1909df3eba2548cfa3b9c270112bd262) 
stands out with the 🥇 highest estimated Customer Lifetime Value (CLV). Over a tenure of 33 months, 
Chima has completed 2,383 transactions, making him the top contributor in terms of long-term value to the business.




