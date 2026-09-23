/*
===========================================================================================================================
Validation File : Sellers_Validation.sql
Table Name      : Category_Translation
Project         : E-Commerce Analytics SQL Project
Author          : Israa Mustafa
Purpose         : Validate imported data quality, integrity, relationships, and business rules.
Created On      : 2026-07-11
===========================================================================================================================
Validation Results:

✔ Total Rows = 3,095

✔ Data imported successfully.

✔ Seller ID is unique with no duplicate values detected.

✔ Sample records were reviewed and matched the expected table structure.

✔ Table passed all validation checks and is ready for analysis.
*/

USE EcommerceAnalytics;
GO


SELECT COUNT(*) AS TotalRows
FROM dbo.Sellers;

SELECT TOP (10) *
FROM dbo.Sellers;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT seller_id) AS Distinct_seller_id
FROM dbo.Sellers;