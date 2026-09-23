/*
===========================================================================================================================
Script Name : Load_Geolocation.sql
Description : Imports olist_geolocation_dataset.csv CSV file into the EcommerceAnalytics database.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On  : 2026-07-09
===========================================================================================================================
*/

USE EcommerceAnalytics;
GO


BULK INSERT dbo.Geolocation
FROM 'D:\SQLData\olist_geolocation_dataset.csv'
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
GO