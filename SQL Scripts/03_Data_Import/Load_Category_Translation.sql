/*
===========================================================================================================================
Script Name : Load_Category_Translation.sql
Description : Imports product_category_name_translation CSV file into the EcommerceAnalytics database.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On  : 2026-07-09
===========================================================================================================================
*/

USE EcommerceAnalytics;
GO

BULK INSERT dbo.Category_Translation
FROM 'D:\SQLData\product_category_name_translation.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);
GO