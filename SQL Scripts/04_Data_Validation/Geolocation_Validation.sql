/*
===========================================================================================================================
Validation File : Geolocation_Validation.sql
Table Name      : Category_Translation
Project         : E-Commerce Analytics SQL Project
Author          : Israa Mustafa
Purpose         : Validate imported data quality, integrity, relationships, and business rules.
Created On      : 2026-07-11
===========================================================================================================================
Validation Results:

✔ Total Rows = 1,000,163

✔ Distinct ZIP Code Prefix = 19015

✔ Data imported successfully.

✔ No Primary Key is defined by design.

✔ Duplicate ZIP code prefixes exist in the source dataset.

✔ The table is used as a lookup/reference table for geographic analysis.

✔ Ready for analysis.
*/

USE EcommerceAnalytics;
GO


SELECT COUNT(*) AS TotalRows
FROM dbo.Geolocation;

SELECT TOP (10) *
FROM dbo.Geolocation;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT geolocation_zip_code_prefix) AS DistinctZipCodes
FROM dbo.Geolocation;

