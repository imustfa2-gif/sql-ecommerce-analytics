/*
===========================================================================================================================
Table Name	: Order_Reviews
Description : Stores customer review information for each order.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On    : 2026-07-7
============================================================================================================================
Business Notes

- Stores customer reviews submitted for completed orders.
- Each order can have at most one customer review.
- Review scores and comments are used to analyze customer satisfaction.
-The original dataset contains duplicate review_id values. Therefore, a composite primary key (review_id, order_id) was used to preserve all records while maintaining entity integrity.
============================================================================================================================
Relationships

- Orders (1) ---- (0/1) Order_Reviews
============================================================================================================================
Dependencies : Orders
*/

USE EcommerceAnalytics;
GO

IF OBJECT_ID('Order_Reviews', 'U') IS NOT NULL
	DROP TABLE Order_Reviews;
	GO

CREATE TABLE Order_Reviews
(
	review_id VARCHAR(32) NOT NULL,
	order_id VARCHAR(32) NOT NULL,
	review_score int Not Null,
	review_comment_title VARCHAR(100),
	review_comment_message VARCHAR(MAX),
	review_creation_date DATETIME NOT NULL,
	review_answer_timestamp DATETIME NOT NULL,

	CONSTRAINT PK_Order_Reviews
		PRIMARY KEY (review_id, order_id),

	CONSTRAINT FK_Orders_Reviews
		FOREIGN KEY (order_id)
		REFERENCES Orders(order_id)
);