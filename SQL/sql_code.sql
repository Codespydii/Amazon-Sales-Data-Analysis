SELECT * FROM amazon_sales;

-- Data quality checks
SELECT
    COUNT(*) AS total_rows,
    COUNT(order_id) AS rows_with_order_id,
    COUNT(`date`) AS rows_with_order_date,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS null_amount_count
FROM amazon_sales;

-- Find malformed rows
SELECT * FROM amazon_sales WHERE qty < 0 OR amount < 0 LIMIT 50;

-- KPI 1 -> Total Revenue
SELECT
    SUM(total_revenue) AS total_revenue,
    SUM(amount) AS sum_amount
FROM amazon_sales;

-- KPI 2 -> Total Orders
SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM amazon_sales;

-- KPI 3 -> Units Sold
SELECT
    SUM(qty) AS total_units_sold
FROM amazon_sales;

-- KPI 4 -> Average Order Value
SELECT
    ROUND(SUM(total_revenue) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM amazon_sales;

SELECT
    ROUND(SUM(total_revenue) / NULLIF(COUNT(*), 0), 2) AS avg_order_value
FROM amazon_sales;

-- KPI 5 -> Revenue by Month
SELECT
    DATE_FORMAT(`date`, '%Y-%m-01') AS month,
    SUM(total_revenue) AS monthly_revenue
FROM amazon_sales
GROUP BY DATE_FORMAT(`date`, '%Y-%m-01')
ORDER BY month;

SELECT
    DATE_FORMAT(`date`, '%Y-%m-01') AS month,
    DATE_FORMAT(`date`, '%Y-%m') AS month_name,
    COUNT(*) AS orders,
    ROUND(SUM(total_revenue), 2) AS revenue,
    ROUND(SUM(total_revenue) / NULLIF(COUNT(*), 0), 2) AS aov
FROM amazon_sales
GROUP BY DATE_FORMAT(`date`, '%Y-%m-01'), DATE_FORMAT(`date`, '%Y-%m')
ORDER BY month;

-- KPI 6 -> Top 10 Products by Revenue
SELECT
    sku,
    asin,
    SUM(total_revenue) AS revenue,
    SUM(qty) AS total_quantity
FROM amazon_sales
GROUP BY sku, asin
ORDER BY revenue DESC
LIMIT 10;

-- KPI 7 -> Top Categories by Revenue
SELECT
    category,
    SUM(total_revenue) AS revenue,
    SUM(qty) AS total_quantity
FROM amazon_sales
GROUP BY category
ORDER BY revenue DESC;

-- KPI 8 -> B2B vs B2C Revenue Split
SELECT
    CASE WHEN b2b = 1 THEN 'B2B' ELSE 'B2C' END AS customer_segment,
    COUNT(*) AS orders,
    SUM(total_revenue) AS revenue
FROM amazon_sales
GROUP BY customer_segment;

-- KPI 9 -> Fulfilment Channel Performance
SELECT
    fulfilled_by,
    COUNT(*) AS orders_count,
    SUM(total_revenue) AS revenue
FROM amazon_sales
GROUP BY fulfilled_by
ORDER BY orders_count DESC;

-- KPI 10 -> Order Status Distribution
SELECT
    status,
    COUNT(*) AS count_orders,
    SUM(total_revenue) AS revenue
FROM amazon_sales
GROUP BY status
ORDER BY count_orders DESC;

-- KPI 11 -> Average Items per Order
SELECT
    ROUND(AVG(qty), 2) AS avg_items_per_order
FROM amazon_sales;

-- KPI 12 -> Revenue by City
SELECT
    ship_city,
    ship_state,
    SUM(total_revenue) AS revenue,
    SUM(qty) AS quantity
FROM amazon_sales
GROUP BY ship_city, ship_state
ORDER BY revenue DESC
LIMIT 20;
