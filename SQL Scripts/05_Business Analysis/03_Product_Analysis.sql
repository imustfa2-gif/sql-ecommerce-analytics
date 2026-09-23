/*
===========================================================================================================================
File Name  : 03_Product_Analysis.sql
Description: Analyzes product category and individual product performance
             based on sales value, order volume, and average value per order.
Author     : Israa Mustafa
Project    : E-Commerce Analytics SQL Project
Created On : 2026-09-23
===========================================================================================================================

Purpose:
- Identify the highest-performing product categories.
- Compare category sales value, order volume, and average value per order.
- Identify the highest-selling individual products.
- Determine whether product performance is driven by order volume
  or by higher-value purchases.

Analyses Covered:
- Top Product Categories by Sales Value
- Category Order Volume
- Average Value per Order by Category
- Top Individual Products
- Product Sales Value versus Order Volume
===========================================================================================================================
*/


/*
Business Question:
Which product categories generate the highest revenue?

Purpose:
Identify the product categories that contribute the most to product sales value.
*/

SELECT TOP 5
    SUM (o.price) AS Product_Sales_Value,
	product_category_name_english as Product_Name

FROM Order_Items o
INNER JOIN Products p
    ON o.product_id = p.product_id

INNER JOIN Category_Translation c
    ON c.product_category_name = p.product_category_name

GROUP BY 
	product_category_name_english

ORDER BY
     Product_Sales_Value DESC;
/*
Result & Business Insight:

Health & Beauty generated the highest product sales value at
1,258,681.34 BRL, followed by Watches & Gifts at 1,205,005.68 BRL.

The five highest-performing categories were Health & Beauty,
Watches & Gifts, Bed, Bath & Table, Sports & Leisure, and
Computers & Accessories.

However, product sales value alone does not explain what drives
the performance of each category. Further analysis of order volume
and average order value is required to determine whether higher
sales are driven by a larger number of orders or higher-value purchases.
*/


/*
===========================================================================================================================
File Name  : 03_Product_Analysis.sql
Description: Analyzes product-category and individual-product sales performance.
Author     : Israa Mustafa
Project    : E-Commerce Analytics SQL Project
===========================================================================================================================
*/

/*
Business Question:

Are the highest-revenue product categories also the categories with the highest order volume?

Analysis Objective:

Determine whether category sales performance is primarily driven by the number of orders or by the value of products purchased.
*/

SELECT TOP 5
    SUM (o.price) AS Product_Sales_Value,
	product_category_name_english as Product_Name,
	COUNT (DISTINCT order_id) AS Products_Order_count

FROM Order_Items o
INNER JOIN Products p
    ON o.product_id = p.product_id

INNER JOIN Category_Translation c
    ON c.product_category_name = p.product_category_name

GROUP BY 
	product_category_name_english

ORDER BY
     Product_Sales_Value DESC;

	 /*
Business Question:

Which product categories have the highest Average Order Value (AOV)?

Analysis Objective:

Determine whether categories with higher sales value achieve their performance through a higher number of orders or through higher-value orders.
*/
SELECT TOP 5
    SUM (o.price) AS Product_Sales_Value,
	product_category_name_english as Product_Name,
	ROUND(
    SUM(o.price) / COUNT(DISTINCT o.order_id),
    2
) AS Average_Order_Value

FROM Order_Items o
INNER JOIN Products p
    ON o.product_id = p.product_id

INNER JOIN Category_Translation c
    ON c.product_category_name = p.product_category_name

GROUP BY 
	product_category_name_english

ORDER BY
     Product_Sales_Value DESC;

 /*
Result & Business Insight:

Watches & Gifts recorded the highest Average Order Value among
the top five product categories, at approximately 215 BRL per order.

Despite having the lowest order volume among these categories
(5,624 orders), it generated the second-highest product sales
value at 1,205,005.68 BRL.

This indicates that the category's strong sales performance was
primarily supported by higher-value orders rather than high order
volume.

In contrast, Bed, Bath & Table recorded the highest order volume
(9,417 orders) but ranked third in product sales value, confirming
that order volume alone does not determine category revenue.
*/

 /*
Business Question

Which individual products generate the highest sales value?

Analysis Objective

Identify the individual products contributing the most to product sales value and determine which products have the strongest sales performance.

*/
SELECT TOP 10
    o.product_id AS Product_ID,
    SUM(o.price) AS Product_Sales_Value,
    ROUND(
        SUM(o.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS Avg_Product_Value_Per_Order
FROM Order_Items o
GROUP BY
    o.product_id
ORDER BY
    Product_Sales_Value DESC;
/*
Result & Business Insight:

The top-selling product generated 63,885.00 BRL in product sales value,
while other high-performing products achieved similar sales values
through different average values per order.

Product d616... recorded an average value per order of approximately
1,397.12 BRL despite generating 48,899.34 BRL in total sales value.
Similarly, product 25c385... recorded an average value per order of
1,023.88 BRL.

This indicates that product sales performance is driven by different
factors: some products achieve high sales through higher sales volume,
while others generate substantial sales value through higher-value
orders.
*/


/*
Business Question:

Which individual products generate the highest sales value, and how does their performance relate to order volume?

Analysis Objective:

Compare the top products by sales value, order volume, and average product value per order to understand what drives their sales performance.
*/

SELECT TOP 10
    o.product_id AS Product_ID,
    SUM(o.price) AS Product_Sales_Value,
    ROUND(
        SUM(o.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS Avg_Product_Value_Per_Order,
    COUNT(DISTINCT o.order_id) AS Order_Count
FROM Order_Items o
GROUP BY
    o.product_id
ORDER BY
    Product_Sales_Value DESC;

/*
Result & Business Insight:

The analysis shows that top product sales performance is driven by
different factors.

Some products achieved high sales value through a high number of orders.
For example, product 99a478... generated 43,025.56 BRL from 467 orders,
with an average product value of 92.13 BRL per order.

In contrast, product d616... generated a higher sales value of 48,899.34 BRL
from only 35 orders, with an average product value of 1,397.12 BRL per order.

This indicates that product sales performance can be driven either by
high order volume or by higher-value products, highlighting the importance
of analyzing both metrics rather than relying on sales value alone.
*/


