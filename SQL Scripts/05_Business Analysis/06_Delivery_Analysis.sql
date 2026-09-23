/*
===========================================================================================================================
File Name  : 06_Delivery_Analysis.sql
Description: Analyzes delivery duration, outliers, on-time performance, and delay severity.
Author     : Israa Mustafa
Project    : E-Commerce Analytics SQL Project
===========================================================================================================================
*/

/*
Business Question:
How long does it take, on average, for delivered orders to reach
customers?

Analysis Objective:
Calculate the average, minimum, and maximum delivery duration for
successfully delivered orders.

This analysis provides a baseline for evaluating logistics performance
and identifying unusually long delivery periods.
===========================================================================================================================
*/


SELECT
    COUNT(*) AS Delivered_Orders,

    CAST(
        AVG(
            CAST(
                DATEDIFF(
                    DAY,
                    order_purchase_timestamp,
                    order_delivered_customer_date
                ) AS DECIMAL(10,2)
            )
        ) AS DECIMAL(10,2)
    ) AS Average_Delivery_Days,

    MIN(
        DATEDIFF(
            DAY,
            order_purchase_timestamp,
            order_delivered_customer_date
        )
    ) AS Minimum_Delivery_Days,

    MAX(
        DATEDIFF(
            DAY,
            order_purchase_timestamp,
            order_delivered_customer_date
        )
    ) AS Maximum_Delivery_Days

FROM Orders

WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;


  /*
Data Quality Check:
Count delivered orders with a missing customer delivery date.
*/

SELECT
    COUNT(*) AS Delivered_Orders_Missing_Delivery_Date
FROM Orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NULL;


  /*
Data Quality Investigation:
Identify orders with the longest recorded delivery durations.
*/

SELECT TOP 10
    order_id,
    order_purchase_timestamp,
    order_delivered_customer_date,

    DATEDIFF(
        DAY,
        order_purchase_timestamp,
        order_delivered_customer_date
    ) AS Delivery_Days

FROM Orders

WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL

ORDER BY
    Delivery_Days DESC;


/*
Business Question:
How are delivered orders distributed across different delivery-duration
ranges, and how common are unusually long delivery times?

Analysis Objective:
Measure the number and percentage of delivered orders in each delivery
duration range to determine whether extreme delivery times represent
common logistics performance or a small number of outliers.
*/

WITH Delivery_Duration AS
(
    SELECT
        order_id,

        DATEDIFF(
            DAY,
            order_purchase_timestamp,
            order_delivered_customer_date
        ) AS Delivery_Days

    FROM Orders

    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
),

Delivery_Groups AS
(
    SELECT
        order_id,
        Delivery_Days,

        CASE
            WHEN Delivery_Days <= 7  THEN '01. 0-7 Days'
            WHEN Delivery_Days <= 14 THEN '02. 8-14 Days'
            WHEN Delivery_Days <= 30 THEN '03. 15-30 Days'
            WHEN Delivery_Days <= 60 THEN '04. 31-60 Days'
            WHEN Delivery_Days <= 90 THEN '05. 61-90 Days'
            ELSE '06. More Than 90 Days'
        END AS Delivery_Range

    FROM Delivery_Duration
)

SELECT
    Delivery_Range,
    COUNT(*) AS Order_Count,

    CAST(
        ROUND(
            100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
            2
        )
        AS DECIMAL(10,2)
    ) AS Order_Percentage

FROM Delivery_Groups

GROUP BY
    Delivery_Range

ORDER BY
    Delivery_Range;


/*
===========================================================================================================================
Result:
- 31.82% of delivered orders arrived within 0-7 days.
- 39.37% arrived within 8-14 days.
- A total of 71.19% of orders were delivered within 14 days.
- 95.55% of orders were delivered within 30 days.
- Only 0.31% of orders took more than 60 days.
- 77 orders, representing 0.08%, took more than 90 days.

Business Insight:
Most delivered orders reached customers within a reasonable period,
with 71.19% arriving within 14 days and 95.55% arriving within 30 days.

Extremely long delivery durations were uncommon. Only 0.31% of orders
took more than 60 days, while 0.08% exceeded 90 days.

Therefore, the longest delivery durations represent a small group of
outliers rather than typical delivery performance. Although these
outliers increase the overall average to some extent, their impact is
limited because they represent a very small percentage of delivered
orders.

Several of the longest-duration orders also shared similar recorded
delivery dates, which may indicate delayed batch updates or another
data-recording issue. The dataset alone does not confirm the cause.
===========================================================================================================================
*/


WITH Delivery_Duration AS
(
    SELECT
        DATEDIFF(
            DAY,
            order_purchase_timestamp,
            order_delivered_customer_date
        ) AS Delivery_Days
    FROM Orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
)

SELECT
    CAST(
        AVG(CAST(Delivery_Days AS DECIMAL(10,2)))
        AS DECIMAL(10,2)
    ) AS Average_All_Orders,

    CAST(
        AVG(
            CASE
                WHEN Delivery_Days <= 90
                THEN CAST(Delivery_Days AS DECIMAL(10,2))
            END
        )
        AS DECIMAL(10,2)
    ) AS Average_Excluding_Over_90_Days

FROM Delivery_Duration;

/*
Impact of Delivery Outliers:

The average delivery duration was 12.50 days when all valid delivered
orders were included.

After excluding the 77 orders that took more than 90 days, the average
decreased slightly to 12.40 days.

The difference was only 0.10 day, or approximately 2.4 hours. Therefore,
extreme delivery-duration outliers had a limited impact on the overall
average because they represented only 0.08% of delivered orders.

The official Average Delivery Duration remains 12.50 days because the
long-duration orders are valid records in the dataset and were not
removed from the main KPI.
*/


/*
===========================================================================================================================
Business Question:
What percentage of delivered orders arrived after the estimated
delivery date?

Analysis Objective:
Compare the actual customer delivery date with the estimated delivery
date to measure on-time delivery performance and calculate the late
delivery rate.
===========================================================================================================================
*/


SELECT
    COUNT(*) AS Evaluated_Orders,

    COUNT(
        CASE
            WHEN CAST(order_delivered_customer_date AS DATE)
                 <= CAST(order_estimated_delivery_date AS DATE)
            THEN 1
        END
    ) AS On_Time_Orders,

    COUNT(
        CASE
            WHEN CAST(order_delivered_customer_date AS DATE)
                 > CAST(order_estimated_delivery_date AS DATE)
            THEN 1
        END
    ) AS Late_Orders,

    CAST(
        ROUND(
            100.0 *
            COUNT(
                CASE
                    WHEN CAST(order_delivered_customer_date AS DATE)
                         > CAST(order_estimated_delivery_date AS DATE)
                    THEN 1
                END
            )
            / COUNT(*),
            2
        )
        AS DECIMAL(10,2)
    ) AS Late_Delivery_Rate

FROM Orders

WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;


/*
Business Question:
When an order is delivered late, how many days late is it on average?

Analysis Objective:
Calculate the average, minimum, and maximum number of delay days among
orders delivered after their estimated delivery date.
*/


SELECT
    COUNT(*) AS Late_Orders,

    CAST(
        AVG(
            CAST(
                DATEDIFF(
                    DAY,
                    order_estimated_delivery_date,
                    order_delivered_customer_date
                ) AS DECIMAL(10,2)
            )
        )
        AS DECIMAL(10,2)
    ) AS Average_Delay_Days,

    MIN(
        DATEDIFF(
            DAY,
            order_estimated_delivery_date,
            order_delivered_customer_date
        )
    ) AS Minimum_Delay_Days,

    MAX(
        DATEDIFF(
            DAY,
            order_estimated_delivery_date,
            order_delivered_customer_date
        )
    ) AS Maximum_Delay_Days

FROM Orders

WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
  AND CAST(order_delivered_customer_date AS DATE)
      > CAST(order_estimated_delivery_date AS DATE);


/*
===========================================================================================================================
Result:
- 96,470 delivered orders had sufficient delivery-date information
  for evaluation.
- 89,936 orders were delivered on or before the estimated delivery date.
- 6,534 orders were delivered late.
- The Late Delivery Rate was 6.77%, corresponding to an On-Time
  Delivery Rate of 93.23%.
- Late orders were delayed by an average of 10.62 days.
- The minimum recorded delay was 1 day, while the maximum was 188 days.

Business Insight:
Overall delivery performance was relatively strong, with 93.23% of
evaluated orders reaching customers on or before the estimated date.

However, when delays occurred, they were meaningful rather than minor.
Late orders arrived an average of 10.62 days after the estimated
delivery date, which may negatively affect customer satisfaction.

The maximum delay of 188 days represents an extreme case and should
not be considered typical delivery performance.

Although the Late Delivery Rate was limited to 6.77%, reducing the
duration of delays could still provide a significant improvement in
customer experience.
===========================================================================================================================
*/
