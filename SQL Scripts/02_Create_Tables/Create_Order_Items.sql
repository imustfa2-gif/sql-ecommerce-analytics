/*
===========================================================================================================================
Table Name	: Order_Items
Description : Stores individual products included in customer orders.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On    : 2026-07-7
============================================================================================================================
Business Notes

- Stores individual products included in customer orders.
- One order can contain multiple order items.
- Each order item is associated with one product and one seller.
- Uses a composite primary key to uniquely identify each item within an order.
============================================================================================================================
Relationships

- Orders (1) ---- (Many) Order_Items
- Products (1) ---- (Many) Order_Items
- Sellers (1) ---- (Many) Order_Items
============================================================================================================================
Dependencies : Orders, Products, Sellers
*/

USE EcommerceAnalytics;
GO

IF OBJECT_ID('Order_Items', 'U') IS NOT NULL
	DROP TABLE Order_Items;
	GO

CREATE TABLE Order_Items
(
	order_id VARCHAR(32) NOT NULL,
	order_item_id int NOT NULL,
	product_id VARCHAR(32) NOT NULL,
	seller_id VARCHAR(32) NOT NULL,
	shipping_limit_date DATETIME NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	freight_value DECIMAL(10,2) NOT NULL,

	CONSTRAINT PK_Orders_Items
		PRIMARY KEY (order_id, order_item_id),

	CONSTRAINT FK_Order_Items
		FOREIGN KEY (order_id)
		REFERENCES Orders(order_id),

	CONSTRAINT FK_Products_Items
		FOREIGN KEY (product_id)
		REFERENCES Products(product_id),

	CONSTRAINT FK_Sellers_Items
		FOREIGN KEY (seller_id)
		REFERENCES Sellers(seller_id)
);