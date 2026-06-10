-- OBJECTIVE 3: ANALYZE CUSTOMER BEHAVIOUR

-- 1. Combine the menu_items and order_details tables into a single table.

-- INSIGHT: Creates a unified view linking each order to its menu item details
SELECT * FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items? What categories were they in?

-- INSIGHT: Identifies best and worst performing dishes — helps decide which items
-- to keep, promote, or remove from the menu
SELECT item_name, category, COUNT(order_details_id) AS num_purchases 
FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_purchases;

-- 3. What were the top 5 orders that spent the most money?

-- INSIGHT: High spend orders may represent large groups or loyal big spenders
-- worth targeting for promotions or loyalty rewards
SELECT order_id, SUM(price) AS total_spend 
FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER BY total_spend DESC
LIMIT 5;

-- 4. View the details of the highest spend order.

-- INSIGHT: Order 440 is the highest spending order. Breakdown by category reveals
-- which cuisine type drove the most spend in this order , indicating customer
-- preference for that cuisine among high spenders
SELECT category, COUNT(item_id) AS num_items 
FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;

-- 5. BONUS: View the details of the top 5 highest spend orders.

-- INSIGHT: Looking across all 5 top orders reveals a pattern, if one category
-- (e.g. Italian or American) consistently appears across these orders, it signals
-- that category is most popular among high spending customers.
-- This can guide menu pricing, promotions, and what to feature prominently.
SELECT order_id, category, COUNT(item_id) AS num_items 
FROM order_details od LEFT JOIN menu_items mi
    ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;

/*
OVERALL CONCLUSION:
- The new menu has a good spread across categories but some items are clearly 
  underperforming and may need to be reconsidered
- High spend orders tend to favour specific categories, suggesting the café 
  should prioritise and promote those cuisines
- Large orders (12+ items) indicate group dining is common , bundle deals or 
  group menus could increase revenue further
- Top customers consistently order from certain categories, which can guide 
  personalised marketing and menu decisions
*/