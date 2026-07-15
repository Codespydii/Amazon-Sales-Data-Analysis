DROP TABLE IF EXISTS amazon_sales;

CREATE TABLE amazon_sales (
    order_id VARCHAR(100),
    `date` DATE,
    status VARCHAR(100),
    fulfilment VARCHAR(100),
    sales_channel VARCHAR(100),
    ship_service_level VARCHAR(100),
    style VARCHAR(100),
    sku VARCHAR(100),
    category VARCHAR(100),
    size VARCHAR(50),
    asin VARCHAR(100),
    courier_status VARCHAR(100),
    qty INT,
    currency VARCHAR(20),
    amount DECIMAL(12,2),
    ship_city VARCHAR(100),
    ship_state VARCHAR(100),
    ship_postal_code VARCHAR(20),
    ship_country VARCHAR(100),
    promotion_ids VARCHAR(255),
    b2b TINYINT(1),
    fulfilled_by VARCHAR(100),
    total_revenue DECIMAL(12,2)
);

-- Use load_dataset.sql to import Amazon_Sales_Clean.csv after creating the table.
