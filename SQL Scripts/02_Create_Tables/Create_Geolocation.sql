/*
===========================================================================================================================
Table Name	: Geolocation
Description : Stores geographic location information based on ZIP code prefixes.
Author      : Israa Mustafa
Project     : E-Commerce Analytics SQL Project
Created On    : 2026-07-2
============================================================================================================================

Business Notes
- Stores geographic information for ZIP code prefixes.
- Used as a lookup table for geographic data.
- Multiple customers and sellers can share the same ZIP code prefix.
- Supports geographic, demographic, and logistics analysis..
============================================================================================================================
Relationships

Referenced logically by Customers and Sellers through ZIP code prefixes.
*/

USE EcommerceAnalytics;
GO

IF OBJECT_ID('Geolocation', 'U') IS NOT NULL
	DROP TABLE Geolocation;
	GO

CREATE TABLE Geolocation
(
	geolocation_zip_code_prefix VARCHAR(10) NOT NULL,
	geolocation_lat DECIMAL(9,6),
	geolocation_lng DECIMAL(9,6),
	geolocation_city VARCHAR(100) NOT NULL,
	geolocation_state CHAR(2) NOT NULL,

/*
Note:
The Geolocation table does not define a Primary Key because
the source dataset contains duplicate ZIP code prefixes and
multiple geographic coordinates for the same postal area.
The table is used as a lookup/reference table for location analysis.
*/
);