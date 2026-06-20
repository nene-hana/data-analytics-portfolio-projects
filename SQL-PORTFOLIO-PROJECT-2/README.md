# 🛍️ Retail Sales Analysis-SQL Data Analysis Project
<img width="1036" height="709" alt="Business Essentials to Help You Enjoy More Long-Term Success" src="https://github.com/user-attachments/assets/56b79ac3-1481-4bb1-8df2-9286e6439431" />


## Project Overview

**Project Title:** Retail Sales Analysis  
**Database:** retail_sales_db  
**Tools:** PostgreSQL, pgAdmin 4

This project demonstrates core SQL skills used by data analysts to set up, clean, explore, and analyze a transactional retail sales dataset. It covers database design, data quality checks, exploratory data analysis (EDA), and business-driven SQL queries that translate raw transaction data into actionable insights , covering revenue performance, customer demographics, seasonality, and operational patterns.

---

## Objectives

1. **Database Setup** : design and create a relational table to store retail transaction data.
2. **Data Cleaning** : identify and remove records with missing/null values to ensure analysis accuracy.
3. **Exploratory Data Analysis (EDA)** : understand the dataset's shape, scale, and structure before deeper analysis.
4. **Business Analysis** : answer 10 specific business questions using SQL, and translate query output into data-driven insights.

---

## Dataset

The dataset contains individual retail sales transactions, including:

| Column            | Description                                  |
|--------------------|-----------------------------------------------|
| `transactions_id`  | Unique transaction identifier (Primary Key)   |
| `sale_date`         | Date of the transaction                       |
| `sale_time`         | Time of the transaction                       |
| `customer_id`       | Unique customer identifier                    |
| `gender`            | Customer gender                               |
| `age`               | Customer age                                  |
| `category`          | Product category (Beauty, Clothing, Electronics) |
| `quantity`          | Number of units sold                          |
| `price_per_unit`    | Price per unit sold                           |
| `cogs`              | Cost of goods sold                            |
| `total_sale`        | Total transaction revenue                     |

---

## Project Structure

### 1. Database Setup

```sql
CREATE TABLE retail_sales (
    transactions_id  INT PRIMARY KEY,
    sale_date        DATE,
    sale_time        TIME,
    customer_id      INT,
    gender           VARCHAR(15),
    age              INT,
    category         VARCHAR(15),
    quantity         INT,
    price_per_unit   INT,
    cogs             FLOAT,
    total_sale       FLOAT
);
```

### 2. Data Cleaning

Checked for and removed records with missing values across all key columns to ensure aggregate calculations (averages, totals) weren't skewed by incomplete data.

```sql
SELECT * FROM retail_sales
WHERE
    transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL
    OR customer_id IS NULL OR gender IS NULL OR age IS NULL
    OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL
    OR cogs IS NULL OR total_sale IS NULL;

DELETE FROM retail_sales
WHERE
    transactions_id IS NULL OR sale_date IS NULL OR sale_time IS NULL
    OR customer_id IS NULL OR gender IS NULL OR age IS NULL
    OR category IS NULL OR quantity IS NULL OR price_per_unit IS NULL
    OR cogs IS NULL OR total_sale IS NULL;
```

**Result:** 13 incomplete rows were removed, leaving a clean dataset for analysis.

### 3. Exploratory Data Analysis (EDA)

```sql
SELECT COUNT(*) AS total_sales FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) AS total_unique_customers FROM retail_sales;
```

### 4. Business Analysis

The following 10 business questions were answered using SQL:

1. Retrieve all transactions made on `2022-11-05`.
2. Retrieve all Clothing transactions with quantity > 4 sold in Nov 2022.
3. Calculate total sales (revenue) for each category.
4. Find the average age of customers who purchased from the Beauty category.
5. Find all transactions where `total_sale` is greater than 1000.
6. Find the total number of transactions by gender within each category.
7. Calculate the average sale per month and identify the best-performing month each year.
8. Find the top 5 customers by total spend.
9. Find the number of unique customers per category.
10. Group orders into shifts (Morning / Afternoon / Evening) and count orders per shift.


---

## Key Findings

**📈 Revenue by Category**
Electronics generated the highest revenue at **$313,810** (≈34.4% of total), with Clothing close behind at **$311,070** (≈34.1%) and Beauty at **$286,840** (≈31.5%). The near-even split across categories points to a balanced product mix rather than reliance on a single dominant category.

**👥 Customer Demographics**
The average Beauty customer is **40.42 years old** : notably older than the commonly assumed younger "beauty product" demographic. This suggests marketing and product positioning should lean toward mid-life consumers rather than Gen Z/teens.

**⚧ Gender Patterns by Category**
Beauty shows the clearest gender skew, with **~54% of transactions from female customers** (330 of 612) vs. 46% male. Clothing (49.5% F / 50.5% M) and Electronics (49.7% F / 50.3% M) are essentially gender-balanced ,meaning gender-targeted marketing matters most for Beauty, while the other two categories likely benefit more from broad, gender-neutral campaigns.

**📅 Seasonality**
**July 2022** was the strongest month, averaging **$541.34** per transaction; **February 2023's** best month averaged $535.53. The top months span different seasons and years, so there's no single obvious seasonal driver ,this would be worth cross-referencing with promotional or campaign data if available.

**💰 Customer Value**
The top 5 customers contributed **$148,470 combined , ≈16.3% of total revenue** ($911,720) despite being a tiny fraction of the total customer base. This is a strong case for a targeted loyalty or retention program for high-value customers.

**🕒 Operational Patterns**
**Evening is by far the busiest shift**, accounting for **~53% of all orders** (1,062 of 1,997) , more than Morning (28%) and Afternoon (19%) combined. Staffing and restocking should be weighted toward evening hours rather than spread evenly across the day.

---

## Conclusion

This project demonstrates an end-to-end SQL workflow , from raw data setup and cleaning through exploratory analysis and business-driven querying , to extract concrete, actionable insights. The findings show a retailer with a balanced category mix, an evening-skewed shopping pattern, a Beauty category with distinct demographic appeal, and a small set of high-value customers worth prioritizing for retention.

---
## Acknowledgments

Dataset structure adapted from the publicly available *Retail Sales Analysis SQL Project* by [Zero Analyst](https://github.com/najirh/Retail-Sales-Analysis-SQL-Project--P1), used here for educational purposes. All queries, data cleaning decisions, and insights in this repository are my own.

---

## Info on Author

Data Analyst | SQL · Python · Power BI · PostgreSQL  
visit : [![GitHub](https://img.shields.io/badge/GitHub-nene--hana-181717?style=flat&logo=github)](https://github.com/nene-hana).

