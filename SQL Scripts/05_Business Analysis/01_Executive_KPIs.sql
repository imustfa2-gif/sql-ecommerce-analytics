/*
===========================================================================================================================
File Name  : 01_Executive_KPIs.sql
Description: Contains SQL queries used to calculate key business performance indicators
             for the E-Commerce Analytics Project.
Author     : Israa Mustafa
Project    : E-Commerce Analytics SQL Project
Created On : 2026-08-08
===========================================================================================================================

Purpose
- Analyze overall order and revenue performance.
- Calculate key business performance indicators (KPIs).
- Provide a foundation for the Power BI dashboard.

KPIs Covered
- Total Orders
- Delivered Orders
- Total Revenue
- Delivery Rate
- Cancellation Rate
- Average Order Value
===========================================================================================================================
*/


/*
Business Question:
How many orders have been successfully delivered, and what is the
total revenue generated from delivered orders?
*/
SELECT
    COUNT(DISTINCT o.order_id) AS Delivered_Orders,
    SUM(p.payment_value) AS Delivered_Orders_Revenue
FROM Orders o
INNER JOIN Payments p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered';
/*
Data Consistency Note:
The Orders table contains 96,478 delivered orders, while an INNER JOIN
with Payments returned 96,477 delivered orders.

Investigation showed that one delivered order exists in Orders without
a corresponding payment record.

Therefore, Orders is used as the source of truth for order-status KPIs,
while Payments is used for revenue and payment-related analysis.
*/


/*
Business Question:
How many orders are recorded in the dataset, regardless of their status?
*/
SELECT COUNT (*) as Total_Orders
FROM Orders ;


/*
Business Question:
What percentage of all orders were successfully delivered?
*/
SELECT
    COUNT(CASE WHEN order_status = 'delivered' THEN 1 END) AS Delivered_Orders,
    COUNT(*) AS Total_Orders,

    ROUND(
    CAST(COUNT(CASE WHEN order_status = 'delivered' THEN 1 END) AS DECIMAL(10,2))
    / COUNT(*) * 100,
    2
) AS Delivery_Rate
FROM Orders;



/*
===========================================================================================================================
Business Question:
What percentage of orders were cancelled?

Purpose:
Measure the cancellation rate among all orders.
===========================================================================================================================
*/
SELECT
    COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) AS canceled_Orders,
    COUNT(*) AS Total_Orders,

    ROUND(
    CAST(COUNT(CASE WHEN order_status = 'canceled' THEN 1 END) AS DECIMAL(10,2))
    / COUNT(*) * 100,
    2
) AS canceled_Rate
FROM Orders;
/*
===========================================================================================================================
Result:
- Canceled Orders: 625
- Total Orders: 99,441
- Cancellation Rate: 0.63%

Business Insight:
625 orders were cancelled, representing 0.63% of all orders.
This indicates a relatively low cancellation rate. However, other
non-delivered order statuses should be analyzed to understand the
overall order fulfillment performance.
===========================================================================================================================
*/



/*
Business Question:
How are orders distributed across the different order statuses?

Purpose:
Identify the number and percentage of orders in each status
to understand the overall order lifecycle and fulfillment performance.
*/

SELECT
    order_status,
    COUNT(*) AS Order_Count,

    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
        2
    ) AS Order_Percentage

FROM Orders
GROUP BY order_status
ORDER BY Order_Count DESC;
/*
===========================================================================================================================
Result:
- Delivered: 96,478 orders (97.02%)
- Shipped: 1,107 orders (1.11%)
- Canceled: 625 orders (0.63%)
- Unavailable: 609 orders (0.61%)
- Invoiced: 314 orders (0.32%)
- Processing: 301 orders (0.30%)
- Created: 5 orders (0.01%)
- Approved: 2 orders (<0.01%)

Business Insight:
Delivered orders represent 97.02% of all orders, indicating that the
vast majority of orders reached the delivered stage.

The remaining 2.98% are distributed across multiple order statuses.
These statuses do not necessarily represent failed orders, as some
indicate intermediate stages of the order lifecycle, such as shipped,
processing, and invoiced.

Further analysis is required to distinguish between pending,
intermediate, and unsuccessful orders.
===========================================================================================================================
*/

/*
===========================================================================================================================
Data Quality Check:
Identify delivered orders that do not have a corresponding payment record.
===========================================================================================================================
*/

SELECT
    o.order_id
FROM Orders o
LEFT JOIN Payments p
    ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
  AND p.order_id IS NULL;

/*
Result:
- One delivered order did not have a corresponding payment record.

Data Quality Note:
This explains why the Orders table contains 96,478 delivered orders,
while joining delivered orders with Payments returns 96,477 orders.

Therefore, Orders is used as the source of truth for order-status KPIs,
while Payments is used for revenue and payment-related calculations.
*/


/*
===========================================================================================================================
Business Question:
What is the average revenue generated per order?

Purpose:
Measure the average payment value across all recorded orders.
===========================================================================================================================
*/

SELECT
    CAST(
        ROUND(
            (SELECT SUM(payment_value) FROM Payments)
            /
            (SELECT COUNT(*) FROM Orders),
            2
        )
        AS DECIMAL(10,2)
    ) AS Average_Order_Value;

/*
===========================================================================================================================
Result:
- Average Order Value: 160.99 BRL

Business Insight:
The average order generated approximately 160.99 BRL in payment value.

This KPI provides a baseline for evaluating customer spending and can
be used to compare order value across time periods, product categories,
customer groups, payment methods, and geographic markets.
===========================================================================================================================
*/
	
