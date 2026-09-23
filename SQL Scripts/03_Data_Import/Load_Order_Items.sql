/*
===========================================================================================================================
Script Name : Load_Order_Items.sql
Description : Imports CSV olist_order_items_dataset.csv file into the EcommerceAnalytics database.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On  : 2026-07-09
===========================================================================================================================
*/
USE EcommerceAnalytics;
GO


BULK INSERT dbo.Order_Items
FROM 'D:\SQLData\olist_order_items_dataset.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    CODEPAGE = '65001',
    TABLOCK
);
