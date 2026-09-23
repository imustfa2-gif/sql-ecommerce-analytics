/*
===========================================================================================================================
File Name  : 04_Customer_Analysis.sql
Description: Analyzes unique customers, repeat purchasing, top spenders, and geographic revenue.
Author     : Israa Mustafa
Project    : E-Commerce Analytics SQL Project
===========================================================================================================================
*/

/*
Business Question

How many unique customers are represented in the dataset, and how does this compare with customer records?

Analysis Objective

Determine the size of the customer base and identify whether customers may have multiple customer records.
*/

SELECT 
	COUNT (customer_id) as Order_Customer,
	COUNT (DISTINCT customer_unique_id) as Customer_No
	FROM Customers;

/*
How many customers are repeat customers?
*/
SELECT
    customer_unique_id,
    COUNT(customer_id) AS Customer_Orders
FROM Customers
GROUP BY
    customer_unique_id
HAVING COUNT(customer_id) > 1
ORDER BY
    Customer_Orders DESC;

	/*
	How many unique customers placed more than one order?
	*/
	SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS Order_Count
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY
    Order_Count DESC;

/*
Result & Business Insight:

The analysis identified 2,997 unique customers who placed more than
one order, out of 96,096 unique customers in total.

This represents a Repeat Customer Rate of approximately 3.12%.

Therefore, the majority of customers (approximately 96.88%) placed
only one order during the observed period.

The low repeat purchase rate may indicate an opportunity to improve
customer retention and encourage repeat purchases. However, further
analysis is required to understand whether this pattern is related
to product characteristics, customer behavior, or the business model.
*/



/*
Business Question:
What percentage of unique customers placed more than one order?

Analysis Objective:
Measure customer retention by calculating the percentage of
unique customers who placed multiple orders.
*/

WITH Customer_Order_Count AS
(
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS Order_Count
    FROM Customers c
    INNER JOIN Orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_unique_id
)
SELECT
    COUNT(*) AS Total_Unique_Customers,

    COUNT(
        CASE
            WHEN Order_Count > 1 THEN 1
        END
    ) AS Repeat_Customers,

   CAST(
    ROUND(
        100.0 *
        COUNT(CASE WHEN Order_Count > 1 THEN 1 END)
        / COUNT(*),
        2
    )
    AS DECIMAL(10,2)
) AS Repeat_Customer_Rate
FROM Customer_Order_Count;

/*
===========================================================================================================================
Result:
- Total Unique Customers: 96,096
- Repeat Customers: 2,997
- Repeat Customer Rate: 3.12%

Business Insight:
Only 3.12% of unique customers placed more than one order during
the observed period, while approximately 96.88% placed only one order.

This indicates a low level of repeat purchasing and highlights a
potential opportunity to improve customer retention. However, further
analysis is required to determine whether this behavior is influenced
by product characteristics, customer needs, or the marketplace
business model.
===========================================================================================================================
*/

/*
===========================================================================================================================
Business Question:
Which customers generated the highest total spending, and was their
spending driven by repeat purchases or by high-value individual orders?

Analysis Objective:
Identify the top ten customers based on total payment value and compare
their number of orders and Average Order Value (AOV).

This analysis helps determine whether the highest customer spending is
primarily driven by frequent purchases or by a small number of
high-value transactions.
===========================================================================================================================
*/

SELECT TOP 10
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS Order_Count,
    SUM(p.payment_value) AS Total_Spent,

    CAST(
        ROUND(
            SUM(p.payment_value) /
            COUNT(DISTINCT o.order_id),
            2
        )
        AS DECIMAL(10,2)
    ) AS Average_Order_Value

FROM Customers c

INNER JOIN Orders o
    ON o.customer_id = c.customer_id

INNER JOIN Payments p
    ON p.order_id = o.order_id

GROUP BY
    c.customer_unique_id

ORDER BY
    Total_Spent DESC;

	/*
===========================================================================================================================
Result:
- The highest-spending customer generated 13,664.08 BRL from a single order.
- The second-highest customer generated 9,553.02 BRL from three orders,
  with an Average Order Value of 3,184.34 BRL.
- The third-highest customer generated 7,571.63 BRL from two orders,
  with an Average Order Value of 3,785.82 BRL.
- Eight of the top ten customers placed only one order.

Business Insight:
The analysis shows that high customer spending was primarily driven
by high-value individual orders rather than frequent purchases.

The highest-spending customer placed only one order worth 13,664.08 BRL.
Although the second- and third-highest customers placed multiple orders,
most customers in the top ten made only one purchase.

This indicates that the highest customer values are generally associated
with large transactions, while repeat purchasing plays a smaller role
among the top-spending customers.
===========================================================================================================================
*/


/*
===========================================================================================================================
Business Question:
Which customer states generate the highest revenue?

Analysis Objective:
Compare customer states based on the number of unique customers,
number of orders, total payment value, and Average Order Value (AOV).

This analysis helps identify the geographic markets that contribute
the most to business revenue and determine whether their performance
is driven by a larger customer base or higher-value orders.
===========================================================================================================================
*/

SELECT TOP 10
    c.customer_state AS Customer_State,
    COUNT(DISTINCT c.customer_unique_id) AS Unique_Customers,
    COUNT(DISTINCT o.order_id) AS Order_Count,
    SUM(p.payment_value) AS Total_Revenue,

    CAST(
        ROUND(
            SUM(p.payment_value) /
            COUNT(DISTINCT o.order_id),
            2
        )
        AS DECIMAL(10,2)
    ) AS Average_Order_Value

FROM Customers c

INNER JOIN Orders o
    ON o.customer_id = c.customer_id

INNER JOIN Payments p
    ON p.order_id = o.order_id

GROUP BY
    c.customer_state

ORDER BY
    Total_Revenue DESC;

/*
===========================================================================================================================
Result:
- São Paulo (SP) generated the highest revenue at 5,998,226.96 BRL,
  from 41,745 orders and 40,301 unique customers.
- Rio de Janeiro (RJ) ranked second with 2,144,379.69 BRL from
  12,852 orders.
- Minas Gerais (MG) ranked third with 1,872,257.26 BRL from
  11,635 orders.
- Bahia (BA) recorded the highest Average Order Value among the
  top ten states at 182.44 BRL.

Business Insight:
São Paulo generated the highest total revenue primarily because of its
large customer base and order volume, rather than a high Average Order
Value.

Although São Paulo's Average Order Value was the lowest among the top
ten states at 143.69 BRL, its 41,745 orders substantially exceeded the
order volume of every other state.

In contrast, states such as Bahia and Goiás recorded higher Average
Order Values but generated less total revenue because of their smaller
customer bases and lower order volumes.

This indicates that geographic revenue performance is influenced mainly
by market size and order volume, while some smaller markets demonstrate
higher spending per order.
===========================================================================================================================
*/
