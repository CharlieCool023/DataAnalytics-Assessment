-- Find customers with both funded savings and investment plans, sorted by total deposits
SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(CASE WHEN p.is_regular_savings = 1 THEN 1 END) AS savings_count,
    COUNT(CASE WHEN p.is_a_fund = 1 THEN 1 END) AS investment_count,
    SUM(s.confirmed_amount) / 100.0 AS total_deposits
FROM 
    users_customuser u
    INNER JOIN savings_savingsaccount s ON u.id = s.owner_id
    INNER JOIN plans_plan p ON s.plan_id = p.id
WHERE 
    s.confirmed_amount > 0
GROUP BY 
    u.id, u.name
HAVING 
    COUNT(CASE WHEN p.is_regular_savings = 1 THEN 1 END) > 0
    AND COUNT(CASE WHEN p.is_a_fund = 1 THEN 1 END) > 0
ORDER BY 
    total_deposits DESC;