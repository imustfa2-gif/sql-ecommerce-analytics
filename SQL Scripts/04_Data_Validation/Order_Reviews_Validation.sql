/*
===========================================================================================================================
Validation File : Order_Reviews_Validation.sql
Table Name      : Category_Translation
Project         : E-Commerce Analytics SQL Project
Author          : Israa Mustafa
Purpose         : Validate imported data quality, integrity, relationships, and business rules.
Created On      : 2026-07-11
===========================================================================================================================
Design Decision:

During data loading, it was discovered that review_id is not unique in the original Olist dataset. Approximately 789 duplicate review_id values exist.

To preserve all records while maintaining entity integrity, a composite primary key (review_id, order_id) was implemented instead of using review_id alone.
==============================
Validation Results:

✔ Total Rows = 99,224

✔ Data imported successfully.

✔ Composite Primary Key (review_id, order_id) is unique.

✔ All reviews are linked to valid customer orders.

✔ Review scores are within the valid range (1-5).

✔ Review timestamps are logically consistent (review answer time is not earlier than review creation date).

✔ Sample records were reviewed and matched the expected table structure.

✔ Data Quality Observation.

✔ Table passed all validation checks and is ready for analysis.
*/

USE EcommerceAnalytics;
GO


SELECT COUNT(*) AS TotalRows
FROM dbo.Order_Reviews;

SELECT TOP (10) *
FROM dbo.Order_Reviews;

SELECT review_id, order_id, COUNT(*)
FROM Order_Reviews
GROUP BY review_id, order_id
HAVING COUNT(*) > 1;

SELECT COUNT(*)
FROM Order_Reviews r
LEFT JOIN Orders o
ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT *
FROM Order_Reviews
WHERE review_score NOT BETWEEN 1 AND 5;

SELECT *
FROM Order_Reviews
WHERE review_answer_timestamp < review_creation_date;