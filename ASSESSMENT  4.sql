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
