-- Find active accounts with no transactions in the last 365 days
SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
    END AS type,
    MAX(COALESCE(s.created_at, w.created_at)) AS last_transaction_date,
    TIMESTAMPDIFF(DAY, MAX(COALESCE(s.created_at, w.created_at)), CURDATE()) AS inactivity_days
FROM 
    plans_plan p
    LEFT JOIN savings_savingsaccount s ON p.id = s.plan_id
    LEFT JOIN withdrawals_withdrawal w ON p.id = w.plan_id
WHERE 
    p.is_regular_savings = 1 OR p.is_a_fund = 1
    AND p.is_deleted = 0
GROUP BY 
    p.id, p.owner_id, p.is_regular_savings, p.is_a_fund
HAVING 
    TIMESTAMPDIFF(DAY, MAX(COALESCE(s.created_at, w.created_at)), CURDATE()) > 365
    OR MAX(COALESCE(s.created_at, w.created_at)) IS NULL;