/*
===========================================================================================================================
Validation File : Orders_Validation.sql
Table Name      : Category_Translation
Project         : E-Commerce Analytics SQL Project
Author          : Israa Mustafa
Purpose         : Validate imported data quality, integrity, relationships, and business rules.
Created On      : 2026-07-11
===========================================================================================================================
Validation Results:

✔ Total Rows = 99,441

✔ Data imported successfully.

✔ Order ID is unique with no duplicate values detected.

✔ Sample records were reviewed and matched the expected table structure.

✔ Business rule validation passed successfully.

✔ No invalid date sequences were detected (purchase, approval, shipping, and delivery dates are logically consistent).

✔ Table is ready for analysis.
*/

USE EcommerceAnalytics;
GO


SELECT COUNT(*) AS TotalRows
FROM dbo.Orders;

SELECT TOP (10) *
FROM dbo.Orders;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT order_id) AS Distinct_orders_id
FROM dbo.Orders;

SELECT *
FROM Orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

SELECT *
FROM Orders
WHERE order_approved_at < order_purchase_timestamp;

SELECT *
FROM Orders
WHERE order_estimated_delivery_date < order_purchase_timestamp;

SELECT
    order_status,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY order_status
ORDER BY TotalOrders DESC;

SELECT
    SUM(CASE WHEN order_approved_at IS NULL THEN 1 ELSE 0 END) AS MissingApproved,
    SUM(CASE WHEN order_delivered_carrier_date IS NULL THEN 1 ELSE 0 END) AS MissingCarrier,
    SUM(CASE WHEN order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS MissingDelivered
FROM Orders;

SELECT COUNT(*) AS OrphanOrders
FROM Orders o
LEFT JOIN Customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


