/*
===========================================================================================================================
Validation File : Customers_Validation.sql
Table Name      : Category_Translation
Project         : E-Commerce Analytics SQL Project
Author          : Israa Mustafa
Purpose         : Validate imported data quality, integrity, relationships, and business rules.
Created On      : 2026-07-11
===========================================================================================================================

Validation Results:

✔ Total Rows = 99,441

✔ customer_id is unique.

✔ customer_unique_id contains duplicates (Expected).

✔ No NULL values found in key columns.
*/

USE EcommerceAnalytics;
GO


SELECT COUNT(*) AS TotalCustomers
FROM dbo.Customers;

SELECT TOP (10) *
FROM dbo.Customers;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT customer_id) AS DistinctCustomerID,
    COUNT(DISTINCT customer_unique_id) AS DistinctCustomerUniqueID
FROM dbo.Customers;

SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS NullCustomerID,
    SUM(CASE WHEN customer_unique_id IS NULL THEN 1 ELSE 0 END) AS NullCustomerUniqueID,
    SUM(CASE WHEN customer_city IS NULL THEN 1 ELSE 0 END) AS NullCity
FROM dbo.Customers;
