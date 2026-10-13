# 📊 Sales Data Exploratory Data Analysis (EDA)

This repository contains SQL analysis scripts and dashboard visualization specs for conducting Exploratory Data Analysis (EDA) on retail/e-commerce sales performance. 

The project analyzes transactional sales data across customer demographics, product hierarchies, geographical regions, order seasonality, and profitability margins.

---

## 📂 Project Structure

```text
.
├── EDA_Sales_Analysis.sql                # Primary SQL queries for core metrics and exploratory analysis
├── Exploring the sales data.lvdash.json  # Databricks Lakeview Dashboard spec
└── assets/                               # Dashboard charts & visuals
    ├── Sales_Amount_Distribution.png     
    ├── Total_Orders_by_Month.png        
    ├── Order_Volume_Growth_Rate.png     
    └── YoY_Order_Comparison.png
```


## 🗄️ Data Model Architecture
The analytics layer is structured as a Star Schema, optimized for analytical queries, aggregation, and reporting. It consists of central fact tables surrounded by descriptive dimension tables.

```
+-------------------+
                  |   dim_customers   |
                  +-------------------+
                  | PK  customer_key  |
                  |     country       |
                  |     gender        |
                  |     marital_status|
                  +---------+---------+
                            |
                            | 1:N
                            v
+-------------------+     +-------------------+
|   dim_products    |     |    fact_sales     |
+-------------------+     +-------------------+
| PK  product_key   |1:N  | PK  sales_key     |
|     product_name  |<----+ FK  product_key   |
|     category      |     | FK  customer_key  |
|     subcategory   |     |     order_date    |
|     product_line  |     |     shipping_date |
|     cost          |     |     order_number  |
+-------------------+     |     sales_amount  |
                          |     quantity      |
                          +-------------------+
```
## 🔍 Key Insights & Analysis Covered
### 1. Revenue & Category Breakdown
Dominant Category: The vast majority of sales (96.46%) are driven by the Bikes category, with Accessories and Clothing accounting for the remaining share.

### 2. Monthly Trends & Growth
Revenue Acceleration: Monthly sales saw exponential growth starting in early 2013, peaking at over $1.8M/month in late 2013 before a tapering period in early 2014.

Order Volumes: Monthly order volume followed a similar trajectory, expanding from under ~500 orders/month in 2011–2012 to upwards of 2,000+ orders/month in 2013.

### 3. SQL Analysis Modules Included (EDA_Sales_Analysis.sql)
Summary Statistics: Overall revenue, transaction counts, average order values (AOV), and min/max sale boundaries.

Product Hierarchy Drill-down: Performance analysis across product categories, subcategories, and top 10 products by revenue.

Profitability Analysis: Category-level gross profit and margin percentages (sales_amount - quantity * cost).

Demographics & Geography: Sales split by customer country, gender, and marital status.

Operational Performance: Fulfillment efficiency and shipping lag calculations (DATEDIFF(shipping_date, order_date)).


## Import Databricks Dashboard
Import Exploring the sales data.lvdash.json into Databricks Lakeview Dashboards to reproduce the visual dashboards.

## 🛠️ Prerequisites
### SQL Engine: Databricks SQL, Apache Spark SQL, PostgreSQL, or Snowflake.

### Dashboard Platform: Databricks Lakeview / AI/BI Dashboards.
