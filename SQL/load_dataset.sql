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

LOAD DATA LOCAL INFILE 'Amazon_Sales_Clean.csv'
INTO TABLE amazon_sales
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@order_id, @order_date, @status, @fulfilment, @sales_channel, @ship_service_level, @style, @sku, @category, @size, @asin, @courier_status, @qty, @currency, @amount, @ship_city, @ship_state, @ship_postal_code, @ship_country, @promotion_ids, @b2b, @fulfilled_by)
SET
    order_id = @order_id,
    `date` = STR_TO_DATE(@order_date, '%Y-%m-%d'),
    status = @status,
    fulfilment = @fulfilment,
    sales_channel = @sales_channel,
    ship_service_level = @ship_service_level,
    style = @style,
    sku = @sku,
    category = @category,
    size = @size,
    asin = @asin,
    courier_status = @courier_status,
    qty = NULLIF(@qty, ''),
    currency = @currency,
    amount = NULLIF(@amount, ''),
    ship_city = @ship_city,
    ship_state = @ship_state,
    ship_postal_code = @ship_postal_code,
    ship_country = @ship_country,
    promotion_ids = @promotion_ids,
    b2b = CASE
        WHEN LOWER(@b2b) IN ('1', 'true', 't', 'yes', 'y') THEN 1
        ELSE 0
    END,
    fulfilled_by = @fulfilled_by,
    total_revenue = COALESCE(NULLIF(@qty, '') + 0, 0) * COALESCE(NULLIF(@amount, '') + 0, 0);
