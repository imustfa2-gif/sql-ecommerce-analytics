/*
===========================================================================================================================
Table Name	: Sellers
Description : Stores Seller information.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On    : 2026-07-2
============================================================================================================================
Business Notes

- Stores seller profile and location information.
- Each seller can appear in multiple order items.
- One seller can appear in many customer orders.
- Seller location is used for shipping and logistics analysis.
============================================================================================================================
Relationships

Sellers (1) ---- (Many) Order_Items
*/

USE EcommerceAnalytics;
GO

IF OBJECT_ID('Sellers', 'U') IS NOT NULL
	DROP TABLE Sellers;
	GO

CREATE TABLE Sellers
(
	seller_id VARCHAR (32) NOT NULL,
	seller_zip_code_prefix VARCHAR(10) NOT NULL,
	seller_city VARCHAR(100) NOT NULL,
	seller_state CHAR(2) NOT NULL,

	CONSTRAINT PK_Sellers
		PRIMARY KEY (seller_id)

);