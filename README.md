# DataAnalytics-Assessment
This repository contains SQL solutions for the Cowrywise Data Analyst Assessment.
Question 1: High-Value Customers with Multiple Products

Approach: Joined users_customuser, savings_savingsaccount, and plans_plan to find customers with funded savings and investment plans. Summed deposits (in naira) and filtered for both plan types.
Notes: Assumes users_customuser.name exists.

Question 2: Transaction Frequency Analysis

Approach: Calculated average monthly transactions using TIMESTAMPDIFF and categorized into High, Medium, or Low frequency.
Notes: Handles single-month users with +1 in tenure.

Question 3: Account Inactivity Alert

Approach: Identified active plans with no transactions in 365+ days using TIMESTAMPDIFF and COALESCE for deposit/withdrawal dates.
Notes: Filters for is_deleted = 0.

Question 4: Customer Lifetime Value (CLV) Estimation

Approach: Computed tenure, transaction count, and CLV using transaction values (in kobo) and TIMESTAMPDIFF.
Notes: Assumes users_customuser.signup_date exists.

General Notes

Amounts are in kobo, converted to naira where needed.
users_customuser schema assumed (id, name, signup_date) due to missing details.
Queries use MySQL syntax (e.g., TIMESTAMPDIFF, CURDATE).
Solutions crafted independently.

