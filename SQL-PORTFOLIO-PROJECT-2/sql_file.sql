/* ============================================================
   PROJECT : Retail Sales Analysis - SQL Data Analysis Portfolio
   TOOLS   : PostgreSQL (pgAdmin 4)
   OBJECTIVE
     Explore, clean, and analyze a retail sales transactions
     dataset to uncover patterns in customer demographics,
     product category performance, and sales trends across
     time (month / year / shift).
   ============================================================ */


/* ------------------------------------------------------------
   1. DATABASE SETUP
   ------------------------------------------------------------ */

-- Drop the table first if it already exists, so this script
-- can be re-run cleanly from scratch (idempotent setup).
DROP TABLE IF EXISTS retail_sales;

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


/* ------------------------------------------------------------
   2. INITIAL DATA CHECK
   ------------------------------------------------------------ */

-- Quick sanity check: confirm data loaded successfully
SELECT * FROM retail_sales
LIMIT 10;

-- Total row count in the raw dataset
SELECT COUNT(*) AS total_rows FROM retail_sales;


/* ------------------------------------------------------------
   3. DATA CLEANING
   ------------------------------------------------------------ */

-- Identify rows with missing (NULL) values in any key column.
-- Incomplete records like these can skew aggregate calculations
-- (averages, totals) and should be reviewed before analysis.
SELECT * FROM retail_sales
WHERE
    transactions_id IS NULL
    OR sale_date      IS NULL
    OR sale_time      IS NULL
    OR customer_id    IS NULL
    OR gender         IS NULL
    OR age             IS NULL
    OR category        IS NULL
    OR quantity        IS NULL
    OR price_per_unit  IS NULL
    OR cogs             IS NULL
    OR total_sale        IS NULL;

-- Remove the incomplete rows identified above.
-- Insight: [Fill in after running — e.g., "X rows (Y% of the
-- dataset) were removed due to missing values, mostly in the
-- ___ column."]
DELETE FROM retail_sales
WHERE
    transactions_id IS NULL
    OR sale_date      IS NULL
    OR sale_time      IS NULL
    OR customer_id    IS NULL
    OR gender         IS NULL
    OR age             IS NULL
    OR category        IS NULL
    OR quantity        IS NULL
    OR price_per_unit  IS NULL
    OR cogs             IS NULL
    OR total_sale        IS NULL;


/* ------------------------------------------------------------
   4. DATA EXPLORATION
   ------------------------------------------------------------ */

-- How many sales transactions remain after cleaning?
SELECT COUNT(*) AS total_sales FROM retail_sales;

-- How many unique customers made purchases?
SELECT COUNT(DISTINCT customer_id) AS total_unique_customers
FROM retail_sales;


/* ------------------------------------------------------------
   5. BUSINESS ANALYSIS & KEY FINDINGS
   ------------------------------------------------------------
   Each query below answers a specific business question.
   ------------------------------------------------------------ */

-- ----------------------------------------------------------------
-- Q1. Retrieve all transactions made on a specific date (2022-11-05)
-- Business use: spot-check daily sales activity / audit a single day.
-- ----------------------------------------------------------------
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';


-- ----------------------------------------------------------------
-- Q2. Find Clothing transactions with quantity > 4 sold in Nov 2022
-- Business use: identify bulk-purchase behavior within a category
-- and month — useful for inventory and restocking decisions.
-- ----------------------------------------------------------------
SELECT *
FROM retail_sales
WHERE
    category = 'Clothing'
    AND sale_date >= '2022-11-01'
    AND sale_date <  '2022-12-01'
    AND quantity > 4;


-- ----------------------------------------------------------------
-- Q3. Calculate total sales (revenue) for each category
-- Business use: identify top revenue-generating categories to
-- prioritize in marketing and inventory investment.
-- ----------------------------------------------------------------
SELECT
    category,
    SUM(total_sale) AS net_sale
FROM retail_sales
GROUP BY category
ORDER BY net_sale DESC;
/*
 Insight: Electronics generated the highest revenue at $313,810 (≈34.4% of total sales), closely followed by Clothing 
at $311,070 (≈34.1%), with Beauty trailing at $286,840 (≈31.5%). The near-even split across all three categories
suggests a balanced product mix ,no single category dominates, which lowers risk if one category underperforms.
*/


-- ----------------------------------------------------------------
-- Q4. Average age of customers purchasing from the 'Beauty' category
-- Business use: understand the target demographic for a category,
-- useful for tailoring marketing campaigns.
-- ----------------------------------------------------------------
SELECT
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
/* Insight: The average Beauty customer is 40.42 years old , meaningfully older than a typical "beauty product"
stereotype audience (often assumed to skew younger/Gen Z). This suggests marketing and product positioning should lean 
toward mid-life consumers rather than teens/young adults
*/


-- ----------------------------------------------------------------
-- Q5. Find all transactions with total_sale greater than 1000
-- Business use: identify high-value transactions for VIP/loyalty
-- analysis or anomaly review.
-- ----------------------------------------------------------------
SELECT *
FROM retail_sales
WHERE total_sale > 1000;


-- ----------------------------------------------------------------
-- Q6. Total number of transactions by gender within each category
-- Business use: understand gender-based purchasing patterns per
-- category to inform targeted marketing.
-- ----------------------------------------------------------------
SELECT
    category,
    gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
/*Beauty shows the clearest gender skew , 
about 54% of Beauty transactions came from female customers (330 of 612),
versus 46% male. Clothing and Electronics are essentially gender-balanced (Clothing: 49.5% F / 50.5% M; Electronics: 49.7% F / 50.3% M). 
This suggests Beauty is the only category where gender-targeted marketing would meaningfully move the needle ,
Clothing and Electronics likely benefit more from broad, gender-neutral campaigns.

*/

-- ----------------------------------------------------------------
-- Q7. Average sale per month, and the best-performing month each year
-- Business use: identify seasonal sales peaks to plan promotions,
-- staffing, and inventory ahead of high-demand periods.
-- ----------------------------------------------------------------
SELECT
    year,
    month,
    avg_sale
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date)  AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY 1, 2
) AS monthly_sales
WHERE rank = 1
ORDER BY year;
/* Insight: July 2022 was the strongest month, with average sales of $541.34 per transaction, 
while February 2023's best month averaged $535.53. The two top months are close in value and fall
in different seasons (mid-summer vs. late winter) and different years, so there's no obvious single seasonal
driver (like a holiday) — this would be worth digging into further with promotional or campaign data if available
*/


-- ----------------------------------------------------------------
-- Q8. Top 5 customers by total spend
-- Business use: identify highest-value customers for loyalty
-- programs or personalized retention outreach.
-- ----------------------------------------------------------------
SELECT
    customer_id,
    SUM(total_sale) AS total_spent
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;


-- ----------------------------------------------------------------
-- Q9. Number of unique customers per category
-- Business use: measure category reach (how many distinct
-- customers a category attracts, not just transaction volume).
-- ----------------------------------------------------------------
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category
ORDER BY unique_customers DESC;


-- ----------------------------------------------------------------
-- Q10. Number of orders by shift (Morning / Afternoon / Evening)
-- Shift definition: Morning < 12:00, Afternoon 12:00-17:00,
-- Evening > 17:00
-- Business use: align staffing levels with peak shopping hours.
-- ----------------------------------------------------------------
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift
ORDER BY total_orders DESC;
/* Insight: Evening is by far the busiest shift, accounting for ~53% of all orders (1,062 of 1,997),
more than Morning (28%) and Afternoon (19%) combined. This strongly suggests staffing and inventory
restocking should be weighted toward evening hours rather than spread evenly across the day.
*/

/* ============================================================
   KEY FINDINGS SUMMARY 
   ------------------------------------------------------------

   - Revenue:        Electronics generated the highest revenue at
                      $313,810 (≈34.4% of total), with Clothing
                      close behind at $311,070 (≈34.1%) and Beauty
                      at $286,840 (≈31.5%) , a balanced category mix
   - Demographics:   Average customer age is 40.42 for Beauty
                      buyers, skewing toward a mid-life audience
                      rather than the typically assumed younger one
   - Seasonality:    July 2022 was the strongest month ($541.34 avg
                      sale/transaction), with no clear single
                      seasonal driver shared across years
   - Customer value: Top 5 customers contributed $148,470 combined,
                      ≈16.3% of total revenue ($911,720) , a strong
                      case for a targeted loyalty program
   - Operations:     Evening is the dominant shift at ~53% of all
                      orders , staffing should be weighted toward
                      evening hours over morning/afternoon
   ============================================================ */