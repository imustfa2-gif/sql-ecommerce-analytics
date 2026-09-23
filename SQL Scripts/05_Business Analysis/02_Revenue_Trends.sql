/*
===========================================================================================================================
File Name  : 02_Revenue_Trends.sql
Description: Analyzes revenue trends over time, monthly order volume, data coverage, and top-performing months.
Author     : Israa Mustafa
Project    : E-Commerce Analytics SQL Project
===========================================================================================================================
*/

/*
Business Question:
What is the average revenue generated per order?

Purpose:
Measure the average order value across all orders.
*/

SELECT
    ROUND(
        (SELECT SUM(payment_value) FROM Payments)
        /
        (SELECT COUNT(*) FROM Orders),
        2
    ) AS Average_Order_Value;

/*
Result:
- Average Order Value: 160.99 BRL

Business Insight:
The average order generated approximately 160.99 BRL in payment value.
This KPI provides a baseline for evaluating customer spending per order
and can be used later to compare order value across product categories,
customers, payment methods, and other business dimensions.
*/


/*
Business Question:
How does revenue change over time?

Purpose:
Analyze monthly revenue to identify trends and potential seasonality.
*/
SELECT
    YEAR(o.order_purchase_timestamp) AS Order_Year,
    MONTH(o.order_purchase_timestamp) AS Order_Month,
    SUM(p.payment_value) AS Monthly_Revenue

FROM Orders o
INNER JOIN Payments p
    ON p.order_id = o.order_id

GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp)

ORDER BY
    Order_Year,
    Order_Month;

/*
Business Question:
Are the unusual revenue values in the first and last months caused by
a change in the number of orders?

Purpose:
Validate whether the unusual monthly revenue values reflect actual
sales activity or incomplete data.
*/

SELECT
    YEAR(o.order_purchase_timestamp) AS Order_Year,
    MONTH(o.order_purchase_timestamp) AS Order_Month,
    COUNT(DISTINCT o.order_id) AS Order_Count,
    SUM(p.payment_value) AS Monthly_Revenue

FROM Orders o
INNER JOIN Payments p
    ON o.order_id = p.order_id

GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp)

ORDER BY
    Order_Year,
    Order_Month;


/*
Business Question:
What is the actual date range covered by the order data?

Purpose:
Identify the beginning and end of the dataset and assess whether
the first and last months represent complete periods.
*/

SELECT
    MIN(order_purchase_timestamp) AS First_Order_Date,
    MAX(order_purchase_timestamp) AS Last_Order_Date
FROM Orders;


SELECT
    YEAR(order_purchase_timestamp) AS Order_Year,
    MONTH(order_purchase_timestamp) AS Order_Month,
    MAX(order_purchase_timestamp) AS Last_Order_Date,
    COUNT(DISTINCT order_id) AS Order_Count
FROM Orders
GROUP BY
    YEAR(order_purchase_timestamp),
    MONTH(order_purchase_timestamp)
ORDER BY
    Order_Year,
    Order_Month;


SELECT
    order_id,
    order_purchase_timestamp,
    order_status
FROM Orders
WHERE order_purchase_timestamp >= '2018-09-01'
  AND order_purchase_timestamp < '2018-10-01'
ORDER BY order_purchase_timestamp;

/*
===========================================================================================================================
Revenue Trend Analysis — Results & Insights

Key Findings:
- Revenue showed a clear upward trend from 2017 through mid-2018, accompanied by substantial growth in order volume.
- November 2017 recorded the highest monthly revenue in 2017 at 1,194,882.80 BRL.
- April 2018 recorded the highest monthly revenue in the observed period before the sharp decline, at 1,160,785.48 BRL.
- September 2018 recorded only 16 orders, 15 of which were canceled, resulting in revenue of 4,439.54 BRL.
- October 2018 recorded only 4 orders and the data ends on October 17, making this a partial period.

Data Quality / Interpretation Note:
The beginning and end of the dataset contain unusually low order volumes.
The first recorded orders appear in September 2016, with only a small number
of orders during the initial months. This may reflect an early stage of business
activity or limited customer adoption, but the dataset alone cannot confirm the cause.

The sharp decline in September 2018 cannot be attributed solely to an incomplete
month because orders are recorded through September 29. However, 15 of the 16
orders were canceled, indicating unusual activity that requires further
investigation before interpreting the period as a normal business trend.

October 2018 is a partial period, ending on October 17, and should not be used
to evaluate the business's normal monthly performance.
===========================================================================================================================
*/


/*
Business Question:
What factors contributed to the highest monthly revenue?

Purpose:
Determine whether monthly revenue is primarily driven by order volume or by the average value of each order.
*/
SELECT TOP 5
    YEAR(o.order_purchase_timestamp) AS Best_Year,
    MONTH(o.order_purchase_timestamp) AS Best_Month,
    SUM(p.payment_value) AS Monthly_Revenue,
	COUNT(DISTINCT o.order_id) as Orders_No,
	ROUND(
    SUM(p.payment_value) / COUNT(DISTINCT o.order_id),
    2
) AS Average_Order_Value

FROM Orders o
INNER JOIN Payments p
    ON o.order_id = p.order_id

GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp)

ORDER BY
    Monthly_Revenue DESC;

/*
Result & Business Insight:

The analysis shows that high monthly revenue was driven by different
factors across the top-performing months.

November 2017 generated the highest revenue at 1,194,882.80 BRL and
also recorded the highest order volume among the top five months, with
7,544 orders. This suggests that order volume was a major contributor
to its high revenue.

In contrast, April 2018 generated slightly higher revenue than March
2018 despite having 272 fewer orders. This was supported by a higher
Average Order Value (AOV) of 167.28 BRL compared with 160.82 BRL in March.

May 2018 recorded the highest AOV among the top five months at
167.90 BRL, demonstrating that higher revenue does not necessarily
depend only on a higher number of orders.
*/
