select *
from dim_customers;

-- Total orders over time
select order_date,
       count(*) as total_orders
from fact_sales
group by order_date
order by order_date;

-- total sales over month
select date_trunc('month', order_date) as orderdate,
       sum(sales_amount) as total_sales
from fact_sales
group by orderdate
order by orderdate;



-- 1. How much total sales are there for each category
SELECT
    SUM(sales_amount) AS Sales,
    p.category AS category
FROM fact_sales f
LEFT JOIN dim_products p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY Sales DESC;


-- 2. Sales amount frequency distribution
SELECT
  sales_amount,
  COUNT(*) as frequency
FROM
  fact_sales
GROUP BY
  sales_amount
ORDER BY sales_amount asc;


-- 3. Overall sales summary statistics
SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT order_number) AS total_orders,
    SUM(sales_amount) AS total_revenue,
    AVG(sales_amount) AS avg_sales_per_transaction,
    MIN(sales_amount) AS min_sale,
    MAX(sales_amount) AS max_sale,
    SUM(quantity) AS total_quantity_sold,
    AVG(quantity) AS avg_quantity_per_transaction
FROM fact_sales;


-- 4. Sales by subcategory (drill-down from category)
SELECT
    p.category,
    p.subcategory,
    SUM(f.sales_amount) AS total_sales,
    COUNT(*) AS num_transactions,
    AVG(f.sales_amount) AS avg_sale
FROM fact_sales f
LEFT JOIN dim_products p
    ON f.product_key = p.product_key
GROUP BY p.category, p.subcategory
ORDER BY total_sales DESC;


-- 5. Sales by product line
SELECT
    p.product_line,
    SUM(f.sales_amount) AS total_sales,
    COUNT(*) AS num_transactions,
    AVG(f.sales_amount) AS avg_sale
FROM fact_sales f
LEFT JOIN dim_products p
    ON f.product_key = p.product_key
GROUP BY p.product_line
ORDER BY total_sales DESC;


-- 6. Top 10 products by total revenue
SELECT
    p.product_name,
    p.category,
    SUM(f.sales_amount) AS total_revenue,
    SUM(f.quantity) AS total_quantity,
    COUNT(*) AS num_transactions
FROM fact_sales f
LEFT JOIN dim_products p
    ON f.product_key = p.product_key
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;


-- 7. Monthly sales trend
SELECT
    DATE_TRUNC('month', order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT order_number) AS num_orders,
    AVG(sales_amount) AS avg_sale_per_transaction
FROM fact_sales
GROUP BY order_month
ORDER BY order_month;


-- 8. Profit analysis by category (revenue minus cost)
SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue,
    SUM(f.quantity * p.cost) AS total_cost,
    SUM(f.sales_amount - f.quantity * p.cost) AS total_profit,
    ROUND(SUM(f.sales_amount - f.quantity * p.cost) / SUM(f.sales_amount) * 100, 2) AS profit_margin_pct
FROM fact_sales f
LEFT JOIN dim_products p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_profit DESC;


-- 9. Sales by customer country
SELECT
    c.country,
    SUM(f.sales_amount) AS total_sales,
    COUNT(DISTINCT f.customer_key) AS num_customers,
    COUNT(DISTINCT f.order_number) AS num_orders,
    AVG(f.sales_amount) AS avg_sale
FROM fact_sales f
LEFT JOIN dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_sales DESC;


-- 10. Shipping delay analysis (days from order to ship)
SELECT
    DATEDIFF(shipping_date, order_date) AS shipping_days,
    COUNT(*) AS num_orders,
    ROUND(AVG(sales_amount), 2) AS avg_sale
FROM fact_sales
WHERE shipping_date IS NOT NULL AND order_date IS NOT NULL
GROUP BY shipping_days
ORDER BY shipping_days;


-- 11. Sales by customer gender and marital status
SELECT
    c.gender,
    c.marital_status,
    SUM(f.sales_amount) AS total_sales,
    COUNT(DISTINCT f.customer_key) AS num_customers,
    AVG(f.sales_amount) AS avg_sale
FROM fact_sales f
LEFT JOIN dim_customers c
    ON f.customer_key = c.customer_key
GROUP BY c.gender, c.marital_status
ORDER BY total_sales DESC;


-- 12. Yearly sales summary
SELECT
    YEAR(order_date) AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT order_number) AS num_orders,
    SUM(quantity) AS total_quantity,
    AVG(sales_amount) AS avg_sale
FROM fact_sales
GROUP BY order_year
ORDER BY order_year;
