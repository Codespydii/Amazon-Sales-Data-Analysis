# Amazon Sales Data Analysis (MySQL Project)

## Author
**Codespydii**

## Project Overview
This project focuses on analyzing Amazon sales data using MySQL.
The goal is to uncover insights such as total revenue, orders, top products, sales trends, and more.

The dataset is loaded into a MySQL database, basic data checks are performed, and SQL queries are used to generate KPIs and business insights.

## Project Structure
```text
.
├── amazon_sales_sql_analysis.docx   # Reference schema, KPIs & example outputs
├── load_dataset.sql                 # Script to create table and load CSV
├── project_setup.sql                # Alternate setup script
├── sql_code.sql                     # SQL queries for KPIs and analysis
```

## Setup

### 1. Create Database
```sql
CREATE DATABASE amazon_sales_db;
USE amazon_sales_db;
```

### 2. Run Schema and Load Data
```sql
SOURCE load_dataset.sql;
```

This will:
- Drop any existing table
- Create a new `amazon_sales` table
- Load data from `Amazon_Sales_Clean.csv`

### 3. Verify Data
```sql
SELECT COUNT(*) FROM amazon_sales;
```

## Key Queries
- Total orders
- Total revenue
- Average order value
- Revenue by month
- Top products by revenue
- Category-wise revenue
- B2B vs B2C split
- Fulfilment channel performance
- Order status distribution
- Average items per order
- Revenue by city
