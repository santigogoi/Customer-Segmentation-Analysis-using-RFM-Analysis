CREATE DATABASE rfm_project;
USE rfm_project;

-- To creates a "map" so that the database can find CustomerIDs instantly
CREATE INDEX idx_cust_id_segments ON customer_segments(customerid);
CREATE INDEX idx_cust_id_trans ON bank_transactions(customerid);

SELECT * FROM customer_segments;
SELECT COUNT(*) FROM customer_segments;

SELECT * FROM bank_transactions;
SELECT COUNT(*) FROM bank_transactions;

-- 1. What is the exact percentage and count of customers in each defined segment?
SELECT segment AS Segment,
       COUNT(customerid) AS Customer_Count,
       ROUND(COUNT(customerid)*100.0/ (SELECT COUNT(*) FROM customer_segments), 2) AS Percentage
FROM customer_segments
GROUP BY segment
ORDER BY Customer_Count DESC;

-- 2. Which segment contributes the highest total monetary value? What is the average monetary value per customer for the top 3 segments?
SELECT segment AS Segment,
       SUM(monetary) AS Total_Revenue,
       AVG(monetary) AS Avg_Revenue_Per_Customer
FROM customer_segments
GROUP BY segment
ORDER BY Total_Revenue DESC
LIMIT 3;

-- 3. What is the average Recency, Frequency and Monetary for 'At Risk/Hibernating' customers?
SELECT 
    AVG(recency) AS Avg_recency,
    MIN(recency) AS Min_recency,
    MAX(recency) AS Max_recency,
    AVG(monetary) AS Avg_monetary,
    AVG(frequency) AS Avg_frequency
FROM customer_segments
WHERE segment = 'At Risk/Hibernating';

-- 4. How do the average R, F, and M scores differ across segments (e.g., compare the average R_Score of 'Champions' vs. 'Promising' customers)?
SELECT segment AS Segment,
       AVG(R_score) AS Avg_R,
       AVG(F_score) AS Avg_F,
       AVG(M_score) AS Avg_M
FROM customer_segments
GROUP BY segment;

-- 5. What is the Recency (in days) that separates the top 20% of customers (R_Score = 5) from the rest?
SELECT R_score,
       MIN(recency) AS Min_days,
       MAX(recency) AS Max_days,
       COUNT(*) AS Customer_Count
FROM customer_segments
GROUP BY R_score
ORDER BY R_score desc;

-- 6. What percentage of all transactions (total Frequency) were made by the top 10% of customers?
WITH FrequencyRank AS (
    SELECT 
        frequency,
        PERCENT_RANK() OVER(ORDER BY frequency DESC) AS p_rank
    FROM customer_segments
)
SELECT 
    SUM(frequency) AS Top_10_Percent_Transactions,
    (SELECT SUM(frequency) FROM customer_segments) AS Total_Transactions,
    ROUND(SUM(frequency) * 100.0 / (SELECT SUM(frequency) FROM customer_segments), 2) AS Percentage_Contribution
FROM FrequencyRank
WHERE p_rank <= 0.10;

-- 7. What is the median transaction amount for the top Monetary quintile (M_Score = 5) compared to the bottom quintile (M_Score = 1)?
SELECT 
    M_score, 
    ROUND(AVG(monetary), 2) AS Avg_Spending,
    MIN(monetary) AS Min_Spending,
    MAX(monetary) AS Max_Spending
FROM customer_segments
GROUP BY M_score
ORDER BY M_score DESC;

-- 8. Which customers in the 'Can't Lose Them' segment have an account balance higher than the average, making them high-priority targets for special offers?
SELECT 
    s.customerid AS Customer_ID, 
    t.custaccountbalance AS Customer_Acc_Balance, 
    s.monetary AS Monetary
FROM customer_segments s
JOIN bank_transactions t ON s.customerid = t.customerid
WHERE s.segment = 'Can\'t Lose Them' 
  AND t.custaccountbalance > (SELECT AVG(custaccountbalance) FROM bank_transactions)
ORDER BY t.custaccountbalance DESC
LIMIT 5;

-- 9. Which 5 locations (cities) have the highest total spend from our 'Champions' segment?
SELECT 
    t.custlocation AS Location, 
    SUM(s.monetary) AS Total_Spend
FROM customer_segments s
JOIN bank_transactions t ON s.customerid = t.customerid
WHERE s.segment = 'Champions'
GROUP BY t.custlocation
ORDER BY Total_Spend DESC
LIMIT 5;

-- 10. How long is the average time between the first and second transaction for customers in the 'New Customers' segment?
WITH TransOrdered AS (
    SELECT 
        customerid, 
        transactiondate,
        ROW_NUMBER() OVER(PARTITION BY customerid ORDER BY transactiondate) AS trans_rank
    FROM bank_transactions
),
FirstTwo AS (
    SELECT 
        t1.customerid,
        DATEDIFF(t2.transactiondate, t1.transactiondate) AS gap
    FROM TransOrdered t1
    JOIN TransOrdered t2 ON t1.customerid = t2.customerid
        AND t1.trans_rank = 1 AND t2.trans_rank = 2
)
SELECT AVG(gap) AS Avg_Days_To_Second_Transaction FROM FirstTwo;