/*
===========================================================================================================================
Table Name	: Category_Translation
Description : Stores English translations for product categories.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On    : 2026-07-2
============================================================================================================================
Business Notes
- Stores English translations for product categories.
- One product category can be associated with many products.
- Used as a lookup table for category names.

============================================================================================================================
Relationships
- Category_Translation (1) ---- (Many) Products

*/

USE EcommerceAnalytics;
GO

IF OBJECT_ID('Category_Translation', 'U') IS NOT NULL
	DROP TABLE Category_Translation;
	GO

CREATE TABLE Category_Translation
(
	product_category_name VARCHAR (100) NOT NULL,
	product_category_name_english VARCHAR (100) NOT NULL,

	CONSTRAINT PK_Category_Translation
		PRIMARY KEY (product_category_name)

);