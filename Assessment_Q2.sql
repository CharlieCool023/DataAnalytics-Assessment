-- Calculate average monthly transactions per customer and categorize frequency
WITH TransactionCounts AS (
    SELECT 
        u.id,
        COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.created_at), MAX(s.created_at)) + 1) AS avg_transactions_per_month
    FROM 
        users_customuser u
        LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY 
        u.id
)
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
        ELSE'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    TransactionCounts
GROUP BY 
    frequency_category
ORDER BY 
    avg_transactions_per_month DESC;