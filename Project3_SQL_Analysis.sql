
-- ============================================================
--
--  Dataset columns:
--  OrderID, Date, CustomerID, Product, Quantity, UnitPrice,
--  ShippingAddress, PaymentMethod, OrderStatus, TrackingNumber,
--  ItemsInCart, CouponCode, ReferralSource, TotalPrice
-- ============================================================


-- ============================================================
-- TASK 1: View All Orders
-- Just looking at the whole table first to understand the data
-- ============================================================

SELECT *
FROM [dbo].[Dataset for Data Analytics(2)];

-- This just shows everything in the table.
-- Good starting point before writing any specific queries.


-- ============================================================
-- TASK 2: Select Specific Columns
-- I only need a few columns, not the whole table
-- ============================================================

SELECT OrderID, CustomerID, Product, TotalPrice, OrderStatus
FROM [dbo].[Dataset for Data Analytics(2)];

-- Cleaner view - only showing the columns that actually matter
-- for a quick order summary.


-- ============================================================
-- TASK 3: Filter Delivered Orders
-- ============================================================
SELECT OrderID, CustomerID, Product, TotalPrice
FROM [dbo].[Dataset for Data Analytics(2)]
WHERE OrderStatus = 'Delivered';

-- Filters out everything except delivered orders.
-- Useful when you want to see completed sales only.


-- ============================================================
-- TASK 4: Find High-Value Orders (over $1000)
-- ============================================================
SELECT OrderID, CustomerID, Product, TotalPrice
FROM [dbo].[Dataset for Data Analytics(2)]
WHERE TotalPrice > 1000
ORDER BY TotalPrice DESC;

-- Pulls orders above $1000 and sorts them highest first.
-- Good for identifying big spenders.


-- ============================================================
-- TASK 5: Orders That Were Cancelled
-- ============================================================

SELECT OrderID, CustomerID, Product, TotalPrice, PaymentMethod
FROM [dbo].[Dataset for Data Analytics(2)]
WHERE OrderStatus = 'Cancelled';

-- Just cancelled orders. Could be useful to see which products
-- or payment methods are linked to cancellations.


-- ============================================================
-- TASK 6: Filter by Product - Laptop Orders Only
-- ============================================================

SELECT OrderID, CustomerID, Quantity, UnitPrice, TotalPrice
FROM [dbo].[Dataset for Data Analytics(2)]
WHERE Product = 'Laptop'
ORDER BY TotalPrice DESC;

-- All laptop orders sorted by total price.
-- Good if you're tracking performance of a specific product.


-- ============================================================
-- TASK 7: Orders Paid by Credit Card
-- ============================================================

SELECT OrderID, CustomerID, Product, TotalPrice
FROM [dbo].[Dataset for Data Analytics(2)]
WHERE PaymentMethod = 'Credit Card';

-- Simple filter to see only credit card transactions.


-- ============================================================
-- TASK 8: Multiple Conditions - Delivered Laptop Orders
-- ============================================================

SELECT OrderID, CustomerID, TotalPrice
FROM [dbo].[Dataset for Data Analytics(2)]
WHERE Product = 'Laptop' AND OrderStatus = 'Delivered';

-- Combining two conditions with AND.
-- Only shows laptop orders that actually got delivered.


-- ============================================================
-- TASK 9: Orders from Instagram or Facebook Referrals
-- ============================================================

SELECT OrderID, CustomerID, Product, ReferralSource, TotalPrice
FROM [dbo].[Dataset for Data Analytics(2)]
WHERE ReferralSource = 'Instagram' OR ReferralSource = 'Facebook';

-- Filtering for social media referrals.
-- Helpful to understand which platform brings in orders.


-- ============================================================
-- TASK 10: Orders with a Coupon Applied
-- ============================================================

SELECT OrderID, CustomerID, Product, CouponCode, TotalPrice
FROM [dbo].[Dataset for Data Analytics(2)]
WHERE CouponCode IS NOT NULL
ORDER BY TotalPrice DESC;

-- Shows all orders where a coupon was used.
-- Sorted by price to see which coupon users spent the most.


-- ============================================================
-- TASK 11: Sort All Orders by Date (Newest First)
-- ============================================================

SELECT OrderID, Date, CustomerID, Product, TotalPrice
FROM [dbo].[Dataset for Data Analytics(2)]
ORDER BY Date DESC;

-- Orders sorted from newest to oldest.
-- Quick way to see the most recent activity.


-- ============================================================
-- TASK 12: Top 10 Most Expensive Orders
-- ============================================================

SELECT TOP 10 OrderID, CustomerID, Product, Quantity, TotalPrice
FROM [dbo].[Dataset for Data Analytics(2)]
ORDER BY TotalPrice DESC;


-- Top 10 highest-value orders in the whole dataset.


-- ============================================================
-- TASK 13: Count Total Number of Orders
-- ============================================================

SELECT COUNT(*) AS total_orders
FROM [dbo].[Dataset for Data Analytics(2)]

-- Basic count of all rows = total number of orders.


-- ============================================================
-- TASK 14: Count Orders by Status
-- ============================================================

SELECT OrderStatus, COUNT(*) AS order_count
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY OrderStatus;

-- Groups orders by their status and counts each group.
-- Nice overview of how many are delivered, cancelled, etc.


-- ============================================================
-- TASK 15: Count Orders by Product
-- ============================================================

SELECT Product, COUNT(*) AS total_orders
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY Product
ORDER BY total_orders DESC;

-- Which product has the most orders?
-- Sorted so the most popular product shows up first.


-- ============================================================
-- TASK 16: Total Revenue per Product
-- ============================================================

-- summing up revenue for each product
SELECT Product,
       SUM(TotalPrice) AS total_revenue
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY Product
ORDER BY total_revenue DESC;

-- Shows how much total revenue each product has generated.
-- Gives a clear picture of which products make the most money.


-- ============================================================
-- TASK 17: Average Order Value per Product
-- ============================================================

SELECT Product,
       AVG(TotalPrice) AS avg_order_value
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY Product
ORDER BY avg_order_value DESC;

-- Average spend per order for each product.
-- Useful for understanding pricing and customer behavior.


-- ============================================================
-- TASK 18: Total Revenue by Payment Method
-- ============================================================

SELECT PaymentMethod,
       COUNT(*) AS num_orders,
       SUM(TotalPrice) AS total_revenue
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY PaymentMethod
ORDER BY total_revenue DESC;

-- Groups by how customers paid and shows order count + revenue.
-- Helps understand which payment method is most used/profitable.


-- ============================================================
-- TASK 19: Orders and Revenue by Referral Source
-- ============================================================

SELECT ReferralSource,
       COUNT(*) AS orders_from_source,
       SUM(TotalPrice) AS revenue_from_source
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY ReferralSource
ORDER BY revenue_from_source DESC;

-- Breakdown of orders and revenue by where customers came from.
-- Shows which marketing channel is performing best.


-- ============================================================
-- TASK 20: Average Quantity Ordered per Product
-- ============================================================

SELECT Product, AVG(Quantity) AS avg_quantity
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY Product;

-- On average, how many units does a customer order per product?


-- ============================================================
-- TASK 21: Total Revenue from Delivered Orders Only
-- ============================================================

SELECT SUM(TotalPrice) AS delivered_revenue
FROM [dbo].[Dataset for Data Analytics(2)]
WHERE OrderStatus = 'Delivered';

-- Total revenue but only counting orders that were delivered.
-- More realistic than counting cancelled/returned ones too.


-- ============================================================
-- TASK 22: Count of Orders Per Payment Method for Delivered Orders
-- ============================================================

SELECT PaymentMethod, COUNT(*) AS delivered_orders
FROM [dbo].[Dataset for Data Analytics(2)]
WHERE OrderStatus = 'Delivered'
GROUP BY PaymentMethod
ORDER BY delivered_orders DESC;

-- Filtering first for delivered orders, then grouping by payment.
-- Combining WHERE and GROUP BY together.


-- ============================================================
-- TASK 23: Find Products with More Than 150 Orders
-- Using HAVING to filter grouped results
-- ============================================================

SELECT Product, COUNT(*) AS total_orders
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY Product
HAVING COUNT(*) > 150;

-- HAVING filters after grouping (unlike WHERE which filters before).
-- This shows only products that have over 150 orders total.


-- ============================================================
-- TASK 24: Payment Methods with Total Revenue Over $50,000
-- ============================================================

SELECT PaymentMethod, SUM(TotalPrice) AS total_revenue
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY PaymentMethod
HAVING SUM(TotalPrice) > 50000
ORDER BY total_revenue DESC;

-- Filters payment methods that generated more than $50k.
-- HAVING is needed here because we're filtering on an aggregate.


-- ============================================================
-- TASK 25: Monthly Order Count (by Year-Month)
-- ============================================================

SELECT
    FORMAT([Date], 'yyyy-MM') AS year_month,
    COUNT(*) AS orders_per_month
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY FORMAT([Date], 'yyyy-MM')
ORDER BY year_month;

-- Groups orders by month and counts them.
-- Good for spotting seasonal trends in the data.
-- (use DATE_FORMAT in MySQL instead of strftime)


-- ============================================================
-- TASK 26: Revenue by Month
-- ============================================================

SELECT
    FORMAT([Date], 'yyyy-MM') AS year_month,
    SUM(TotalPrice) AS monthly_revenue
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY FORMAT([Date], 'yyyy-MM')
ORDER BY year_month;

-- Monthly revenue trend over time.


-- ============================================================
-- TASK 27: Total Revenue from Coupon Users vs Non-Coupon Users
-- ============================================================
SELECT
    CASE 
        WHEN CouponCode IS NOT NULL THEN 'Used Coupon' 
        ELSE 'No Coupon' 
    END AS coupon_used,
    COUNT(*) AS orders,
    SUM(TotalPrice) AS total_revenue,
    AVG(TotalPrice) AS avg_order_value
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY 
    CASE 
        WHEN CouponCode IS NOT NULL THEN 'Used Coupon' 
        ELSE 'No Coupon' 
    END;

-- Compares orders where a coupon was used vs not.
-- Can see if coupon users actually spend more or less on average.


-- ============================================================
-- TASK 28: Most Common Items in Cart
-- ============================================================

SELECT ItemsInCart, COUNT(*) AS frequency
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY ItemsInCart
ORDER BY ItemsInCart ASC;

-- How often do customers have 1 item, 2 items, 3 items etc in cart?


-- ============================================================
-- TASK 29: Top 5 Products by Total Revenue
-- ============================================================

SELECT TOP 5 Product, SUM(TotalPrice) AS total_revenue
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY Product
ORDER BY total_revenue DESC


-- Quick top-5 ranking of products by revenue.


-- ============================================================
-- TASK 30: Full Summary Report
-- One query to get a complete product-level overview
-- ============================================================

SELECT
    Product,
    COUNT(*) AS total_orders,
    SUM(Quantity) AS total_units_sold,
    SUM(TotalPrice) AS total_revenue,
    AVG(TotalPrice) AS avg_order_value,
    AVG(UnitPrice) AS avg_unit_price
FROM [dbo].[Dataset for Data Analytics(2)]
GROUP BY Product
ORDER BY total_revenue DESC;

-- This is the main summary query.
-- Combines COUNT, SUM, and AVG together for a full product report.
-- Shows total orders, units sold, revenue, and averages all at once.

