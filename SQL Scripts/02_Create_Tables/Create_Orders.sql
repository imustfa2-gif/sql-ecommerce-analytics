/*
===========================================================================================================================
Table Name	: Orders
Description : Stores customer order information.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On    : 2026-06-28
============================================================================================================================

Business Notes
- Stores customer order information.
- Each order belongs to one customer.
- One customer can place multiple orders.
- Tracks the complete order lifecycle from purchase to delivery.
- Order timestamps are used to analyze delivery performance and processing time.
============================================================================================================================
Relationships

-  Customers (1) ---- Orders (Many)
============================================================================================================================
Dependencies : Customers
*/

USE EcommerceAnalytics;
GO


IF OBJECT_ID('Orders', 'U') IS NOT NULL
	DROP TABLE Orders;
	GO

CREATE TABLE Orders
(
	order_id VARCHAR(32) NOT NULL,
	customer_id VARCHAR(32) NOT NULL,
	order_status VARCHAR(32) NOT NULL,
	order_purchase_timestamp DATETIME NOT NULL,
	order_approved_at DATETIME,
	order_delivered_carrier_date DATETIME,
	order_delivered_customer_date DATETIME,
	order_estimated_delivery_date DATETIME NOT NULL,

	CONSTRAINT PK_Orders
		PRIMARY KEY (order_id),

	CONSTRAINT FK_Orders_Customers
		FOREIGN KEY (customer_id)
		REFERENCES Customers(customer_id)
);
