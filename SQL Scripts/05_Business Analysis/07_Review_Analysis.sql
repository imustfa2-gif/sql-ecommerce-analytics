/*
===========================================================================================================================
File Name  : 07_Review_Analysis.sql
Description: Analyzes review-score distribution and the relationship between delivery timing and satisfaction.
Author     : Israa Mustafa
Project    : E-Commerce Analytics SQL Project
===========================================================================================================================
*/

/*
Business Question:
Do late deliveries receive lower customer review scores than orders
delivered on time?

Analysis Objective:
Compare the average review score of on-time and late deliveries to
evaluate the relationship between delivery performance and customer
satisfaction.
===========================================================================================================================
*/



WITH Review_Per_Order AS
(
    SELECT
        order_id,

        AVG(
            CAST(review_score AS DECIMAL(10,2))
        ) AS Order_Review_Score

    FROM Order_Reviews

    GROUP BY
        order_id
)

SELECT
    CASE
        WHEN CAST(o.order_delivered_customer_date AS DATE)
             <= CAST(o.order_estimated_delivery_date AS DATE)
        THEN 'On Time'
        ELSE 'Late'
    END AS Delivery_Status,

    COUNT(*) AS Reviewed_Orders,

    CAST(
        AVG(r.Order_Review_Score)
        AS DECIMAL(10,2)
    ) AS Average_Review_Score

FROM Orders o

INNER JOIN Review_Per_Order r
    ON o.order_id = r.order_id

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY
    CASE
        WHEN CAST(o.order_delivered_customer_date AS DATE)
             <= CAST(o.order_estimated_delivery_date AS DATE)
        THEN 'On Time'
        ELSE 'Late'
    END

ORDER BY
    Delivery_Status;


/*
===========================================================================================================================
Result:
- 89,443 on-time delivered orders had customer reviews, with an
  Average Review Score of 4.29 out of 5.
- 6,381 late delivered orders had customer reviews, with an
  Average Review Score of 2.27 out of 5.
- Late deliveries received an Average Review Score that was
  2.02 points lower than on-time deliveries.

Business Insight:
Orders delivered on time received substantially higher customer review
scores than orders delivered after the estimated delivery date.

The Average Review Score decreased from 4.29 for on-time deliveries to
2.27 for late deliveries. This indicates a strong association between
delivery performance and customer satisfaction.

Although the results do not prove that delivery delays are the only
cause of lower ratings, the size of the difference suggests that
improving on-time delivery performance could meaningfully improve the
customer experience.

Not every delivered order had a customer review. Therefore, this
analysis includes only delivered orders with available review records.
===========================================================================================================================
*/


/*
===========================================================================================================================
Business Question:
How are customer review scores distributed across the five rating
levels?

Analysis Objective:
Measure the number and percentage of customer reviews for each score
from 1 to 5 to understand the overall level of customer satisfaction.
===========================================================================================================================
*/


	SELECT
			review_score AS Review_Score,
			COUNT (*) AS Review_Count,
			CAST(
			ROUND(
				100.0 * COUNT(*) / SUM(COUNT(*)) OVER(),
				2
			)
			AS DECIMAL(10,2)
		) AS Review_Percentage
	FROM Order_Reviews
	GROUP BY review_score
	ORDER BY review_score;


/*
===========================================================================================================================
Result:
- Five-star reviews were the most common, accounting for 57.78% of
  all review records.
- Four-star reviews represented 19.29%.
- Three-star reviews represented 8.24%.
- Two-star reviews represented 3.18%.
- One-star reviews represented 11.51%.
- Positive reviews (scores 4-5) represented 77.07% of all reviews.
- Negative reviews (scores 1-2) represented 14.69%.

Business Insight:
Overall customer satisfaction was relatively strong, with 77.07% of
reviews receiving a score of four or five.

Five-star reviews alone represented more than half of all customer
reviews, indicating that most reviewed transactions resulted in a
positive customer experience.

However, 14.69% of reviews were negative. One-star reviews were
substantially more common than two-star reviews, suggesting that
dissatisfied customers often selected the lowest possible rating.

Combined with the earlier delivery analysis, the lower average rating
among late deliveries indicates that logistics performance may be an
important contributor to negative customer experiences.
===========================================================================================================================
*/
