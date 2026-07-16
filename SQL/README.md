# Amazon Sales Data Analysis - SQL

This folder contains the SQL scripts used to create the table, load the cleaned dataset, and run the main analysis queries for the Amazon sales project.

## Files
- `project_setup.sql` - table schema and database setup
- `load_dataset.sql` - data import script
- `sql_code.sql` - KPI and analysis queries
- `amazon_sales_sql_analysis.docx` - reference document with schema and sample outputs

## Setup

1. Create the database.
```sql
CREATE DATABASE amazon_sales_db;
USE amazon_sales_db;


```

2. Run the schema and load scripts.
```sql
SOURCE project_setup.sql;
SOURCE load_dataset.sql;
```

3. Verify the table.
```sql
SELECT COUNT(*) FROM amazon_sales;
```

## SQL Questions, Queries, and Outputs

### 1. What is the total number of orders?
```sql
SELECT COUNT(*) AS total_orders
FROM amazon_sales;
```
Output: `120,378` orders

### 2. What is the total revenue?
```sql
SELECT SUM(total_revenue) AS total_revenue
FROM amazon_sales;
```
Output: `76,034,406.00 INR`

### 3. What is the sum of raw amount values?
```sql
SELECT SUM(amount) AS sum_amount
FROM amazon_sales;
```
Output: `78,592,678.00 INR`

### 4. What is the average order value?
```sql
SELECT ROUND(SUM(total_revenue) / NULLIF(COUNT(*), 0), 2) AS avg_order_value
FROM amazon_sales;
```
Output: `631.63 INR`

### 5. How does revenue change by month?
```sql
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       COUNT(*) AS orders,
       ROUND(SUM(total_revenue), 2) AS revenue,
       ROUND(AVG(total_revenue), 2) AS aov
FROM amazon_sales
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;
```
Output: a month-wise summary table with `month`, `month_name`, `orders`, `revenue`, and `aov`

### 6. Which are the top 10 products by revenue?
```sql
SELECT sku, asin, SUM(total_revenue) AS revenue, SUM(qty) AS total_qty
FROM amazon_sales
GROUP BY sku, asin
ORDER BY revenue DESC
LIMIT 10;
```
Output: top 10 SKU / ASIN combinations sorted by revenue

### 7. Which categories generate the most revenue?
```sql
SELECT category, SUM(total_revenue) AS revenue, SUM(qty) AS total_qty
FROM amazon_sales
GROUP BY category
ORDER BY revenue DESC;
```
Output: a category-wise revenue table ranked from highest to lowest

### 8. What is the B2B vs B2C revenue split?
```sql
SELECT CASE WHEN b2b = TRUE THEN 'B2B' ELSE 'B2C' END AS customer_segment,
       COUNT(*) AS orders,
       SUM(total_revenue) AS revenue
FROM amazon_sales
GROUP BY customer_segment;
```
Output: two rows showing order count and revenue for `B2B` and `B2C`

### 9. How does fulfilment channel performance compare?
```sql
SELECT fulfilled_by, COUNT(*) AS orders_count, SUM(total_revenue) AS revenue
FROM amazon_sales
GROUP BY fulfilled_by
ORDER BY orders_count DESC;
```
Output: fulfilment-wise order and revenue summary

### 10. What is the order status distribution?
```sql
SELECT status, COUNT(*) AS count_orders, SUM(total_revenue) AS revenue
FROM amazon_sales
GROUP BY status
ORDER BY count_orders DESC;
```
Output: status-wise order count and revenue table

### 11. What is the average items per order?
```sql
SELECT ROUND(AVG(qty), 2) AS avg_items_per_order
FROM amazon_sales;
```
Output: `0.90` items per order

### 12. Which cities contribute the most revenue?
```sql
SELECT ship_city, ship_state, SUM(total_revenue) AS revenue, SUM(qty) AS quantity
FROM amazon_sales
GROUP BY ship_city, ship_state
ORDER BY revenue DESC
LIMIT 20;
```
Output: top 20 city/state combinations by revenue

## Notes

- The queries are written using MySQL syntax.
- The outputs shown above are sample KPI values generated from the Amazon Sales dataset.
- `sql_code.sql` contains all executable MySQL queries used for the analysis.
