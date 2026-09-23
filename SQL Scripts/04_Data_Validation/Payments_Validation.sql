/*
===========================================================================================================================
Validation File : Payments_Validation.sql
Table Name      : Category_Translation
Project         : E-Commerce Analytics SQL Project
Author          : Israa Mustafa
Purpose         : Validate imported data quality, integrity, relationships, and business rules.
Created On      : 2026-07-11
===========================================================================================================================
Validation Results:

✔ Total Rows = 103,886

✔ Composite Primary Key validation passed.

✔ All payment records reference valid orders.

⚠ Two records (0.002%) have payment_installments = 0.

✔ Due to the very low occurrence, these records were retained and documented without modification.
*/

USE EcommerceAnalytics;
GO


SELECT COUNT(*) AS TotalRows
FROM dbo.Payments;

SELECT TOP (10) *
FROM dbo.Payments;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT CONCAT(order_id, '-', payment_sequential)) AS DistinctCompositeKey
FROM Payments;

SELECT COUNT(*) AS OrphanPayments
FROM Payments p
LEFT JOIN Orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT *
FROM Payments
WHERE payment_value < 0;

SELECT *
FROM Payments
WHERE payment_installments < 1;

SELECT *
FROM Payments
WHERE payment_installments = 0;

SELECT
    payment_type,
    COUNT(*) AS TotalPayments
FROM Payments
GROUP BY payment_type
ORDER BY TotalPayments DESC;
