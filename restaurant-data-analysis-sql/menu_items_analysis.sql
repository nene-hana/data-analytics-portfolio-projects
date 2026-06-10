/* You've just been hired as a Data Analyst for the Taste of the World Café, a restaurant that has diverse menu offerings and serves generous portions
The Taste of the World Café debuted a new menu at the start of the year. You've been asked to dig into the customer data to see which menu items are doing well / not well and what the top customers seem to like best
Explore the menu_items table to get an idea of what's on the new menu
Explore the order_details table to get an idea of the data that's been collected
Use both tables to understand how customers are reacting to the new menu */

-- OBJECTIVE 1: EXPLORE THE ITEMS TABLE
USE restaurant_db;

-- 1. View the menu_items table
-- INSIGHT: Get a full overview of all columns and data available

SELECT * FROM menu_items;

-- 2. Find the number of items on the menu.
-- INSIGHT: Tells us how large the menu is overall

SELECT COUNT(*) FROM menu_items;

-- 3. What are the least and most expensive items on the menu?
-- INSIGHT: Shows the price range of the entire menu
SELECT item_name, price FROM menu_items

WHERE price = (SELECT MIN(price) FROM menu_items)
   OR price = (SELECT MAX(price) FROM menu_items);

-- 4. How many Italian dishes are on the menu?
-- INSIGHT: Helps us understand how much focus is given to Italian cuisine

SELECT COUNT(*) FROM menu_items WHERE category = 'Italian';

-- 5. What are the least and most expensive Italian dishes on the menu?
-- INSIGHT: Shows the price range specifically within the Italian category

(SELECT *, 'cheapest' AS label FROM menu_items
WHERE category = 'Italian'
ORDER BY price
LIMIT 1)
UNION
(SELECT *, 'most expensive' AS label FROM menu_items
WHERE category = 'Italian'
ORDER BY price DESC
LIMIT 1);

-- 6. How many dishes are in each category?
-- INSIGHT: Shows which cuisine type has the most variety on the menu

SELECT category, COUNT(*) AS num_of_dishes FROM menu_items
GROUP BY category;

-- 7. What is the average dish price within each category?
-- INSIGHT: Helps identify which categories are premium vs budget-friendly

SELECT category, ROUND(AVG(price), 2) AS average_price FROM menu_items
GROUP BY category;