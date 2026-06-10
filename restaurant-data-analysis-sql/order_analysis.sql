-- OBJECTIVE 2: EXPLORE THE ORDERS TABLE

-- 1. View the order_details table.

-- INSIGHT: Get a full overview of all columns — order_id, item_id, order_date etc.
SELECT * FROM order_details;

-- 2. What is the date range of the table?

-- INSIGHT: Tells us how long the data has been collected (start and end date)
SELECT MIN(order_date) AS first_order, MAX(order_date) AS last_order 
FROM order_details;

-- 3. How many orders were made within this date range?

-- INSIGHT: Total unique orders placed — gives us the business volume
SELECT COUNT(DISTINCT order_id) AS total_orders FROM order_details;

-- 4. How many items were ordered within this date range?

-- INSIGHT: Total items ordered — will be higher than orders since each order has multiple items
SELECT COUNT(*) AS total_items FROM order_details;

-- 5. Which orders had the most number of items?

-- INSIGHT: Large orders may indicate group dining or special occasions
SELECT order_id, COUNT(item_id) AS num_items FROM order_details
GROUP BY order_id
ORDER BY num_items DESC;

-- 6. How many orders had more than 12 items?

-- INSIGHT: Identifies unusually large orders worth investigating further
SELECT COUNT(*) AS orders_over_12 FROM
(SELECT order_id, COUNT(item_id) AS num_items FROM order_details
GROUP BY order_id
HAVING num_items > 12) AS num_orders;