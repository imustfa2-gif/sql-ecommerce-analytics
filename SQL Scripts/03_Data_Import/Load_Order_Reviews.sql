/*
===========================================================================================================================
Script Name : Load_Order_Reviews.sql
Description : Imports olist_order_reviews_dataset.csv CSV file into the EcommerceAnalytics database.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On  : 2026-07-09
===========================================================================================================================
*/
USE EcommerceAnalytics;
GO

BULK INSERT Order_Reviews
FROM 'D:\SQLData\olist_order_reviews_dataset.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    CODEPAGE = '65001',
    TABLOCK
);
