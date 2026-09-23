/*
===========================================================================================================================
File Name  : 09_Freight_Analysis.sql
Description: Measures freight cost relative to product value and compares the shipping burden across states.
Author     : Israa Mustafa
Project    : E-Commerce Analytics SQL Project
===========================================================================================================================
*/

/*
Business Question:
How significant are freight costs compared with product sales value?

Analysis Objective:
Calculate total product sales value, total freight cost, average freight
cost per order, and the percentage of freight cost relative to product
sales value.

This analysis helps evaluate the overall financial impact of shipping
costs on customer purchases.
===========================================================================================================================
*/

SELECT  
    COUNT(DISTINCT order_id) AS Total_Orders,

    SUM(price) AS Total_Product_Value,

    SUM(freight_value) AS Total_Freight_Cost,

    CAST(
        ROUND(
            SUM(freight_value) /
            COUNT(DISTINCT order_id),
            2
        )
        AS DECIMAL(10,2)
    ) AS Average_Freight_Per_Order,

    CAST(
        ROUND(
            100.0 * SUM(freight_value) /
            NULLIF(SUM(price), 0),
            2
        )
        AS DECIMAL(10,2)
    ) AS Freight_To_Product_Percentage

FROM Order_Items;

/*
===========================================================================================================================
Result:
- The Order_Items table contained 98,666 distinct orders.
- Total Product Sales Value was 13,591,643.70 BRL.
- Total Freight Cost was 2,251,909.54 BRL.
- Average Freight Cost per order was 22.82 BRL.
- Freight Cost represented 16.57% of total Product Sales Value.

Business Insight:
Freight costs represented a meaningful additional expense relative to
the value of products sold.

For every 100 BRL in product sales value, customers paid approximately
16.57 BRL in freight costs. The average freight cost was 22.82 BRL per
order.

This indicates that shipping costs may have a noticeable influence on
the customer's total purchase cost, particularly for lower-value
products and orders.

Further geographic analysis is required to determine whether freight
costs vary significantly across customer states.
===========================================================================================================================
*/


/*
===========================================================================================================================
Business Question:
Which customer states have the highest freight costs relative to their
product purchases?

Analysis Objective:
Compare states based on order volume, product sales value, freight cost,
average freight cost per order, and freight cost as a percentage of
product value.

This analysis helps identify geographic markets where shipping creates
the greatest additional cost for customers.
===========================================================================================================================
*/


SELECT TOP 10
    c.customer_state AS Customer_State,
    COUNT(DISTINCT oi.order_id) AS Order_Count,
    SUM(oi.price) AS Product_Value,
	SUM(oi.freight_value) AS Freight_Cost,
	    CAST(
        ROUND(
            SUM(oi.freight_value) /
            COUNT(DISTINCT oi.order_id),
            2
        )
        AS DECIMAL(10,2)
    ) AS Average_Freight_Per_Order,

    CAST(
        ROUND(
            100.0 * SUM(oi.freight_value) /
            NULLIF(SUM(oi.price), 0),
            2
        )
        AS DECIMAL(10,2)
    ) AS Freight_To_Product_Percentage
FROM Order_Items oi

INNER JOIN Orders o
    ON oi.order_id = o.order_id

INNER JOIN Customers c
    ON o.customer_id = c.customer_id

	GROUP BY
    c.customer_state
	ORDER BY
    Freight_To_Product_Percentage DESC;
	/*
===========================================================================================================================
Result:
- Roraima (RR) recorded the highest freight-to-product percentage at
  28.55%, with an Average Freight Cost of 48.59 BRL per order.
- Maranhão (MA) ranked second at 26.35%, based on 740 orders.
- Rondônia (RO), Amazonas (AM), and Piauí (PI) also recorded freight
  percentages above 24%.
- Pernambuco (PE) had the highest order volume among the top ten
  states, with 1,648 orders, and the highest total freight cost at
  59,449.66 BRL.
- All ten states recorded freight-to-product percentages above the
  overall business rate of 16.57%.

Business Insight:
Freight costs varied substantially across customer states.

In Roraima, freight costs were equivalent to 28.55% of product value,
meaning that customers paid approximately 28.55 BRL in freight for
every 100 BRL spent on products. However, this result should be
interpreted cautiously because it was based on only 46 orders.

Maranhão also recorded a high freight burden at 26.35%, supported by
a larger sample of 740 orders, making the result more representative.

Pernambuco generated the highest total freight cost among the top ten
states because of its larger order volume, even though its average and
relative freight costs were lower than those of several other states.

The results indicate that customers in some geographic markets face a
substantially higher shipping burden. However, further analysis of
seller locations, delivery distance, and product characteristics would
be required to determine the exact causes.
===========================================================================================================================
*/
