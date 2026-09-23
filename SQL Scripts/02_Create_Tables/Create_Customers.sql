/*
===========================================================================================================================
Table Name	: Customers
Description : Stores customer information.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On    : 2026-06-28
============================================================================================================================
Business Notes:

- Stores customer profile information.
- One customer can place multiple orders.
- customer_unique_id identifies the actual customer across multiple accounts.
============================================================================================================================
*/

USE EcommerceAnalytics;
GO


IF OBJECT_ID('Customers', 'U') IS NOT NULL
	DROP TABLE Customers;
	GO

CREATE TABLE Customers
(
	customer_id VARCHAR(32) NOT NULL,
	customer_unique_id VARCHAR(32) NOT NULL,
	customer_zip_code_prefix VARCHAR(10) NOT NULL,
	customer_city VARCHAR(100) NOT NULL,
	customer_state CHAR(2) NOT NULL,
	
	CONSTRAINT PK_Customers
		PRIMARY KEY (customer_id)
);
