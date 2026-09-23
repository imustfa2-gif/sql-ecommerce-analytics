/*
===========================================================================================================================
Table Name	: Products
Description : Stores product information.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On  : 2026-07-1
============================================================================================================================

Business Notes

- Stores product details used in customer orders.
- One product can appear in many order items.
- Product category comes from the category translation table.
- Product dimensions are used for shipping analytics.
============================================================================================================================
Relationships

Products (1) ---- (Many) Order_Items
Category_Translation (1) ---- (Many) Products
============================================================================================================================
Dependencies : Category_Translation
*/

USE EcommerceAnalytics;
GO

IF OBJECT_ID('Products', 'U') IS NOT NULL
	DROP TABLE Products;
	GO

CREATE TABLE Products
(
	product_id VARCHAR(32) NOT NULL,
	product_category_name VARCHAR(100),
	product_name_length int,
	product_description_length int,
	product_photos_qty int,
	product_weight_g int, 
	product_length_cm int, 
	product_height_cm int, 
	product_width_cm int,
	
	CONSTRAINT PK_Products
		PRIMARY KEY (product_id),

	CONSTRAINT FK_Products_category
		FOREIGN KEY (product_category_name)
		REFERENCES Category_Translation(product_category_name)
);