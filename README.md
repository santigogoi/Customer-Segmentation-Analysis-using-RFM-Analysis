# Customer Segmentation Analysis Using RFM Analysis

## 📌 Project Overview
This project focuses on analysing customer behaviours for a banking dataset containing over 1 million transactions. By implementing the RFM (Recency, Frequency, Monetary) framework, it segmented the customer base into actionable groups. This analysis enables the bank to identify high-value "Champions," target "At Risk" customers for retention, and optimise marketing spend through data-driven insights.

### Business Problem: Optimising Customer Engagement and Retention
The Challenge: The bank possesses a massive dataset of over 1 million transactions, but it lacks a structured way to differentiate between its diverse customer base. Currently, marketing efforts are "one-size-fits-all," leading to:
1.	High Marketing Waste: Spending resources on low-value or inactive customers.
2.	Customer Churn: Failing to identify high-value customers who are becoming inactive (lapsing) before they leave for a competitor.
3.	Missed Revenue: Inability to identify "Loyal" customers who have high engagement but low spend, representing a missed opportunity for premium product upselling.

The Objective: The goal of this project is to implement an RFM (Recency, Frequency, Monetary) Analysis framework to segment customers into distinct behavioural groups. By quantifying how recently, how often, and how much a customer spends, the bank can transition from generic broadcasting to data-driven, personalised marketing strategies that maximise Customer Lifecycle Value (CLV) and reduce churn.

## 🛠️ Tech Stack & Tools
•	Language: Python (Pandas, NumPy)

•	Database: MySQL (SQLAlchemy for integration)

•	Environment: Jupyter Notebook

•	Concepts: Data Cleaning, Feature Engineering, RFM Segmentation, SQL Querying

## 📁 Data Source
The analysis was performed on a Bank Transactions Dataset consisting of:

•	Size: 1,000,000+ records.

•	Key Features: CustomerID, TransactionDate, TransactionAmount (INR), CustAccountBalance, Gender, and Location.

## 📊 Actionable Business Insights:
o	Identified VIP Lapsed Customers (High balance, low recency) for personalised retention.

o	Mapped Geographical Hotspots (Mumbai, Delhi, Bangalore) where the highest-value customers are concentrated.

o	Determined the "Golden Window" (avg. 16.5 days) for follow-up marketing to new customers.

## 📂 Project Structure
1.	Data Cleaning: Handling null values and converting date formats.

2.	RFM Calculation: 

• Recency: Days since the last transaction.

•	Frequency: Number of transactions.

•	Monetary: Total value of transactions.

3.	Scoring: Assigning 1–5 scores using quintiles.

4.	Segmentation: Mapping scores to labels like Champions, Loyal Customers, At Risk, and New Customers.

5.	SQL Analysis: Answering complex business questions using optimised SQL joins.

## 📈 Sample Business Questions Solved
•	What is the gender distribution among our most loyal tiers?

•	Which locations contribute the most revenue from 'Champion' customers?

•	How does the average account balance differ between 'At Risk' and 'Active' segments?
