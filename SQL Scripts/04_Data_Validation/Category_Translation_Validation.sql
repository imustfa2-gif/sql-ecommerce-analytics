/*
===========================================================================================================================
Validation File : Category_Translation_Validation.sql
Table Name      : Category_Translation
Project         : E-Commerce Analytics SQL Project
Author          : Israa Mustafa
Purpose         : Validate imported data quality, integrity, relationships, and business rules.
Created On      : 2026-07-11
===========================================================================================================================
Validation Results:

✔ Total Categories = 71

✔ No duplicate category names found.

✔ No NULL values detected.

✔ Table is ready for use as a lookup table.
*/

USE EcommerceAnalytics;
GO

SELECT COUNT(*) AS TotalRows
FROM dbo.Category_Translation;

SELECT TOP (10) *
FROM dbo.Category_Translation;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT product_category_name) AS DistinctCategories
FROM dbo.Category_Translation;

SELECT
    SUM(CASE WHEN product_category_name IS NULL THEN 1 ELSE 0 END) AS NullCategory,
    SUM(CASE WHEN product_category_name_english IS NULL THEN 1 ELSE 0 END) AS NullEnglishCategory
FROM dbo.Category_Translation;

