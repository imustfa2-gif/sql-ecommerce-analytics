/*
===========================================================================================================================
Script Name : Load_Payments.sql
Description : Imports olist_order_payments_dataset.csv CSV file into the EcommerceAnalytics database.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On  : 2026-07-09
===========================================================================================================================
*/
USE EcommerceAnalytics;
GO


BULK INSERT dbo.Payments
FROM 'D:\SQLData\olist_order_payments_dataset.csv'
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