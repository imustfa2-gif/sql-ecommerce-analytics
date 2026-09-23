/*
===========================================================================================================================
Validation File : Products_Validation.sql
Table Name      : Category_Translation
Project         : E-Commerce Analytics SQL Project
Author          : Israa Mustafa
Purpose         : Validate imported data quality, integrity, relationships, and business rules.
Created On      : 2026-07-11
===========================================================================================================================
Validation Results:

✔ Total Rows = 32,951

✔ Product ID is unique.

✔ Only 2 records (0.01%) have missing product weight values.

✔ The percentage of missing values is negligible and is not expected to significantly impact product or shipping analysis.

✔ Table is ready for analysis.
*/

USE EcommerceAnalytics;
GO



SELECT COUNT(*) AS TotalRows
FROM dbo.Products;

SELECT TOP (10) *
FROM dbo.Products;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT product_id) AS Distinct_Product_id
FROM dbo.Products;

SELECT
    COUNT(*) AS TotalProducts,
    SUM(CASE WHEN product_weight_g IS NULL THEN 1 ELSE 0 END) AS MissingWeight,
    ROUND(
        100.0 * SUM(CASE WHEN product_weight_g IS NULL THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS MissingPercentage
FROM dbo.Products;

