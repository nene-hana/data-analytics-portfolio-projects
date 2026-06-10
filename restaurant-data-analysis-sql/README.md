# 🍽️ Restaurant customer behavior data Analysis

> Exploring menu performance and customer behaviour using SQL to drive data-informed business decisions for a multi-cuisine café.

---

## 📌 Project Background

**Taste of the World Café** is a restaurant with diverse menu offerings that debuted a brand-new menu at the start of the year. As the appointed Data Analyst, the task was to dig into the café's customer and menu data to answer key business questions:

- Which menu items are performing well ,and which aren't?
- What do the highest-spending customers prefer?
- What actionable changes can the café make based on the data?

---

## 🗃️ Dataset

**Database:** `restaurant_db`

| Table | Description |
|-------|-------------|
| `menu_items` | Item names, cuisine categories, and prices |
| `order_details` | Order IDs, item IDs, and order dates |

---

## 🎯 Objectives & Approach

### Objective 1 : Explore the Menu Items Table
Understand the structure and composition of the new menu.

**Questions answered:**
- How many items are on the menu?
- What are the least and most expensive items overall?
- How many Italian dishes exist, and what is their price range?
- How many dishes are in each category?
- What is the average price per category?

---

### Objective 2 : Explore the Order Details Table
Understand the scope and scale of orders collected.

**Questions answered:**
- What is the date range of the data?
- How many unique orders were placed?
- How many total items were ordered?
- Which orders had the most items?
- How many orders exceeded 12 items?

---

### Objective 3 : Analyze Customer Behaviour
Combine both tables and extract meaningful business insights.

**Questions answered:**
- What were the least and most ordered items, and which categories do they belong to?
- Which 5 orders had the highest total spend?
- What did the highest-spending order consist of?
- Across the top 5 spending orders, which category dominates?

---

## 💡 Key Insights

### 🗂️ Menu Composition
- The menu spans four cuisine categories: **American, Asian, Mexican, and Italian**
- **Italian dishes carry the highest average price**, positioning the category as the café's premium offering
- Dish count varies significantly across categories, revealing where the café has placed its strategic focus

### 📦 Order Patterns
- The dataset covers a defined multi-month period, providing a reliable performance snapshot of the new menu
- A high total item count relative to order count suggests customers consistently order multiple items , group dining is common
- A notable portion of orders exceeded **12 items**, confirming that group tables are a significant revenue source

### 👥 Customer Behaviour
- A clear performance gap exists between the most and least ordered items , some dishes are significantly underperforming
- **Least ordered items** are strong candidates for menu removal or recipe rework
- **Top spending orders overwhelmingly feature Italian dishes**, confirming it as the category of choice among high-value customers
- This pattern suggests the café should **prioritise, expand, and promote the Italian section** to maximise revenue from big spenders

---

## 🔧 Tools & Technologies

| Tool | Usage |
|------|-------|
| MySQL | Database management and querying |
| MySQL Workbench | Query execution and result visualization |

---

## 🧠 SQL Concepts Applied

- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- `JOIN` (LEFT JOIN across two tables)
- `GROUP BY`, `HAVING`
- Aggregate functions: `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `ROUND`
- Subqueries
- `UNION`
- Column aliasing with `AS`

---

## 🚀 How to Run

1. Clone or download this repository
2. Open **MySQL Workbench** and connect to your local server
3. Import and run `restaurant_db.sql` to set up the database *(if provided)*
4. Run each objective `.sql` file in order
5. Review query outputs alongside the comments for full context

---
##  Acknowledgements

Dataset and project brief sourced from **[Maven Analytics](https://www.mavenanalytics.io/)**.  
This project was completed as a guided practice exercise to build real-world SQL analysis skills.



---

> *This project is part of an ongoing data analytics portfolio built to demonstrate real-world SQL problem-solving and business insight generation.*
