/*
===========================================================================================================================
File Name  : 08_Seller_Analysis.sql
Description: Compares seller sales, order volume, customer ratings, and late-delivery performance.
Author     : Israa Mustafa
Project    : E-Commerce Analytics SQL Project
===========================================================================================================================
*/

/*
Business Question:
Which sellers generate the highest product sales value, and is their
performance driven by order volume or higher-value sales?

Analysis Objective:
Identify the top ten sellers based on product sales value and compare
their number of orders, number of items sold, and average sales value
per order.
===========================================================================================================================
*/


SELECT TOP 10

    seller_id AS Seller_ID,
    COUNT(DISTINCT order_id) AS Order_Count,
	COUNT (*) AS Items_Sold,
	SUM(price) AS Product_Sales_Value,
	CAST(
    ROUND(
        SUM(price) / COUNT(DISTINCT order_id),
        2
    )
    AS DECIMAL(10,2)
) AS Average_Sales_Per_Order

FROM Order_Items
GROUP BY
    seller_id
ORDER BY
    Product_Sales_Value DESC;


/*
===========================================================================================================================
Result:
- Seller 4869f7... generated the highest product sales value at
  229,472.63 BRL from 1,132 orders, with average sales of
  202.71 BRL per order.
- Seller 532435... ranked second with 222,776.05 BRL from only
  358 orders, recording the highest average among the top sellers
  at 622.28 BRL per order.
- Seller 4a3ca9... recorded the highest order volume among the top
  ten sellers, with 1,806 orders, but ranked third in sales value
  because its average sales per order were lower at 111.00 BRL.
- Seller 7e93a4... also demonstrated a high-value sales model, with
  average sales of 525.09 BRL per order.

Business Insight:
Top seller performance was driven by different business models.

Some sellers generated strong sales through high order volume, while
others achieved comparable sales values from substantially fewer,
higher-value orders.

The highest-selling seller demonstrated a relatively balanced
combination of order volume and average sales value. In contrast,
seller 532435... relied more heavily on high-value transactions, while
seller 4a3ca9... relied primarily on a larger number of orders.

This confirms that seller performance should be evaluated using both
sales value and order volume rather than either metric alone.
===========================================================================================================================
*/


/*
===========================================================================================================================
Business Question:
Do the highest-selling sellers also receive high customer review scores?

Analysis Objective:
Compare the top ten sellers by product sales value with their average
customer review scores to evaluate both financial performance and
customer satisfaction.
===========================================================================================================================
*/


WITH Seller_Order AS
(
    SELECT
        seller_id,
        order_id,
        SUM(price) AS Order_Sales_Value
    FROM Order_Items
    GROUP BY
        seller_id,
        order_id
),

Review_Per_Order AS
(
    SELECT
        order_id,
        AVG(CAST(review_score AS DECIMAL(10,2))) AS Order_Review_Score
    FROM Order_Reviews
    GROUP BY
        order_id
)

SELECT TOP 10
    so.seller_id AS Seller_ID,
    COUNT(DISTINCT so.order_id) AS Order_Count,
    SUM(so.Order_Sales_Value) AS Product_Sales_Value,
    COUNT(r.Order_Review_Score) AS Reviewed_Orders,

    CAST(
        AVG(r.Order_Review_Score)
        AS DECIMAL(10,2)
    ) AS Average_Review_Score

FROM Seller_Order so

LEFT JOIN Review_Per_Order r
    ON so.order_id = r.order_id

GROUP BY
     so.seller_id

ORDER BY
    Product_Sales_Value DESC;



/*
===========================================================================================================================
Result:
- The two highest-selling sellers each recorded an Average Review
  Score of 4.13.
- Seller fa1c13... ranked fourth in product sales value but achieved
  the highest Average Review Score among the top ten sellers at 4.34.
- Seller 7c67e1... ranked fifth in product sales value but recorded
  the lowest Average Review Score among the group at 3.49.
- Seller 4a3ca9..., which had the highest order volume, recorded an
  Average Review Score of 3.83.
- Most orders associated with the top sellers had available reviews.

Business Insight:
High sales performance did not consistently correspond with higher
customer satisfaction.

Some sellers combined strong sales with high review scores. However,
other high-performing sellers recorded lower customer ratings despite
generating substantial sales value and order volume.

Seller fa1c13... demonstrated the strongest customer satisfaction among
the top-selling sellers, while seller 7c67e1... may require further
investigation because its review score was notably lower than those of
the other leading sellers.

These results show that seller performance should be evaluated using
both financial measures and customer-experience indicators.
===========================================================================================================================
*/


/*
===========================================================================================================================
Business Question:
What are the late delivery rates of the top-selling sellers?

Analysis Objective:
Compare the top ten sellers based on product sales value and late
delivery rate to determine whether strong financial performance is
also associated with reliable delivery performance.
===========================================================================================================================
*/


WITH Seller_Order AS
(
    SELECT
        seller_id,
        order_id,
        SUM(price) AS Order_Sales_Value
    FROM Order_Items
    GROUP BY
        seller_id,
        order_id
)

SELECT TOP 10
    so.seller_id AS Seller_ID,
    COUNT(DISTINCT so.order_id) AS Order_Count,
    SUM(so.Order_Sales_Value) AS Product_Sales_Value,

    COUNT(
        CASE
            WHEN o.order_status = 'delivered'
             AND o.order_delivered_customer_date IS NOT NULL
             AND o.order_estimated_delivery_date IS NOT NULL
            THEN 1
        END
    ) AS Evaluated_Deliveries,

    COUNT(
        CASE
            WHEN o.order_status = 'delivered'
             AND o.order_delivered_customer_date IS NOT NULL
             AND o.order_estimated_delivery_date IS NOT NULL
             AND CAST(o.order_delivered_customer_date AS DATE)
                 > CAST(o.order_estimated_delivery_date AS DATE)
            THEN 1
        END
    ) AS Late_Orders,

    CAST(
        ROUND(
            100.0 *
            COUNT(
                CASE
                    WHEN o.order_status = 'delivered'
             AND o.order_delivered_customer_date IS NOT NULL
             AND o.order_estimated_delivery_date IS NOT NULL
             AND CAST(o.order_delivered_customer_date AS DATE)
                 > CAST(o.order_estimated_delivery_date AS DATE)
                    THEN 1
                END
            )
            /
            NULLIF(
                COUNT(
                    CASE
                        WHEN o.order_status = 'delivered'
             AND o.order_delivered_customer_date IS NOT NULL
             AND o.order_estimated_delivery_date IS NOT NULL
                        THEN 1
                    END
                ),
                0
            ),
            2
        )
        AS DECIMAL(10,2)
    ) AS Late_Delivery_Rate

FROM Seller_Order so

INNER JOIN Orders o
    ON so.order_id = o.order_id

GROUP BY
    so.seller_id

ORDER BY
    Product_Sales_Value DESC;


/*
===========================================================================================================================
Result:
- The highest-selling seller, 4869f7..., recorded the highest Late
  Delivery Rate among the top ten sellers at 10.50%, with 118 late
  orders out of 1,124 evaluated deliveries.
- Seller 532435... recorded the lowest Late Delivery Rate among the
  group at 3.45%.
- Seller 7e93a4... also demonstrated relatively strong delivery
  performance, with a Late Delivery Rate of 4.70%.
- Several top sellers recorded Late Delivery Rates above the overall
  business rate of 6.77%.
- Seller fa1c13... achieved the highest Average Review Score despite
  having a relatively high Late Delivery Rate of 9.17%.

Business Insight:
Delivery performance varied considerably among the top-selling sellers.

The highest-selling seller recorded a Late Delivery Rate of 10.50%,
which was higher than the overall business rate of 6.77%. Delivery
delays may have influenced its customer experience, although its
Average Review Score remained relatively positive at 4.13.

The results do not show a perfectly consistent relationship between
seller-level delivery rates and review scores. For example, seller
fa1c13... maintained the highest review score despite a relatively high
Late Delivery Rate.

Therefore, delivery performance may contribute to customer ratings,
but other factors such as product quality, packaging, and seller
service are also likely to influence customer satisfaction.
===========================================================================================================================
*/
