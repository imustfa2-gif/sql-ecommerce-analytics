/*
===========================================================================================================================
Table Name	: Payments
Description : Stores order payment information.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On    : 2026-07-7
============================================================================================================================

Business Notes
- Stores payment information for customer orders.
- One order can have multiple payment records.
- Supports multiple payment methods per order.
- Uses a Composite Primary Key to uniquely identify each payment record within an order.
============================================================================================================================
Relationships
- Orders (1) ---- (Many) Payments
============================================================================================================================
Dependencies : Orders
*/

USE EcommerceAnalytics;
GO

IF OBJECT_ID('Payments', 'U') IS NOT NULL
	DROP TABLE Payments;
	GO

CREATE TABLE Payments
(
	order_id VARCHAR(32) NOT NULL,
	payment_sequential int NOT NULL,
	payment_type VARCHAR(32) NOT NULL,
	payment_installments INT NOT NULL,
	payment_value DECIMAL(10,2) NOT NULL,


	CONSTRAINT PK_Payments
		PRIMARY KEY (order_id, payment_sequential),

	CONSTRAINT FK_Orders_Payments
		FOREIGN KEY (order_id)
		REFERENCES Orders(order_id)

);