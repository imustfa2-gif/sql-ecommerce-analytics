/*
===========================================================================================================================
Validation File : Order_Items_Validation.sql
Table Name      : Category_Translation
Project         : E-Commerce Analytics SQL Project
Author          : Israa Mustafa
Purpose         : Validate imported data quality, integrity, relationships, and business rules.
Created On      : 2026-07-11
===========================================================================================================================
Validation Results:

✔ Total Rows = 112,650

✔ Data imported successfully.

✔ Composite Primary Key (order_id, order_item_id) is unique.

✔ All order items are linked to valid orders.

✔ All order items reference valid products.

✔ All order items reference valid sellers.

✔ No negative values were found in product prices or freight charges.

✔ Shipping limit dates are logically consistent with order purchase dates.

✔ 4,124 records have freight charges greater than the product price. This is considered a business observation rather than a data quality issue, as shipping costs may exceed product prices for low-cost items or long-distance deliveries.

✔ Sample records were reviewed and matched the expected table structure.

✔ Table passed all validation checks and is ready for analysis.
*/

USE EcommerceAnalytics;
GO



SELECT COUNT(*) AS TotalRows
FROM dbo.Order_Items;

SELECT TOP (10) *
FROM dbo.Order_Items;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT CONCAT(order_id, '-', order_item_id)) AS DistinctCompositeKey
FROM Order_Items;

SELECT COUNT(*) AS OrphanOrderItem
FROM Order_Items oi
LEFT JOIN Orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS OrphanProducts
FROM Order_Items oi
LEFT JOIN Products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*) AS OrphanSellers
FROM Order_Items oi
LEFT JOIN Sellers s
ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

SELECT *
FROM Order_Items
WHERE price < 0;

SELECT *
FROM Order_Items
WHERE freight_value < 0;

SELECT *
FROM Order_Items oi
JOIN Orders o
ON oi.order_id = o.order_id
WHERE oi.shipping_limit_date < o.order_purchase_timestamp;

SELECT *
FROM Order_Items
WHERE price = 0;

SELECT *
FROM Order_Items
WHERE freight_value > price;

