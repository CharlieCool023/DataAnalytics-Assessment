-- Calculate CLV based on tenure and transaction volume
SELECT 
    u.id AS customer_id,
    u.name,
    TIMESTAMPDIFF(MONTH, u.signup_date, CURDATE()) AS tenure_months,
    COUNT(s.id) + COUNT(w.id) AS total_transactions,
    ROUND(
        ((COUNT(s.id) + COUNT(w.id)) / 
         NULLIF(TIMESTAMPDIFF(MONTH, u.signup_date, CURDATE()), 0)) * 
        12 * 
        (SUM(COALESCE(s.confirmed_amount, 0) + COALESCE(w.amount_withdrawn, 0)) / 1000.0), 
        2
    ) AS estimated_clv
FROM 
    users_customuser u
    LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id
    LEFT JOIN withdrawals_withdrawal w ON u.id = w.owner_id
GROUP BY 
    u.id, u.name, u.signup_date
HAVING 
    TIMESTAMPDIFF(MONTH, u.signup_date, CURDATE()) > 0
ORDER BY 
    estimated_clv DESC;