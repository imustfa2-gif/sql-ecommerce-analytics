/*
===========================================================================================================================
File Name  : 05_Payment_Analysis.sql
Description: Analyzes payment methods, payment-value contribution, and credit-card installment behavior.
Author     : Israa Mustafa
Project    : E-Commerce Analytics SQL Project
===========================================================================================================================
*/

/*
Business Question:
Which payment methods are used most frequently, and which generate
the highest payment value?

Analysis Objective:
Compare payment methods based on the number of orders, total payment
value, and Average Order Value (AOV).

This analysis helps identify customers' preferred payment methods and
determine whether revenue performance is driven by payment frequency
or by higher-value transactions.
===========================================================================================================================
*/

SELECT 
    payment_type AS Payment_Type,
    COUNT(DISTINCT order_id) AS Order_Count,
    SUM(payment_value) AS Total_Payment_Value,

    CAST(
        ROUND(
            SUM(payment_value) /
            COUNT(DISTINCT order_id),
            2
        )
        AS DECIMAL(10,2)
    ) AS Average_Order_Value,

    CAST(
        ROUND(
            100.0 * SUM(payment_value) /
            SUM(SUM(payment_value)) OVER(),
            2
        )
        AS DECIMAL(10,2)
    ) AS Payment_Value_Percentage

FROM Payments

GROUP BY
    payment_type

ORDER BY
    Total_Payment_Value DESC;

	/*
===========================================================================================================================
Result:
- Credit cards generated the highest total payment value at
  12,542,084.19 BRL, representing 78.34% of all payment value.
- Boleto ranked second, generating 2,869,361.27 BRL and contributing
  17.92% of total payment value.
- Credit cards also recorded the highest Average Order Value at
  163.94 BRL.
- Vouchers generated 379,436.87 BRL, representing 2.37% of total
  payment value, with the lowest Average Order Value among the
  defined payment methods at 98.15 BRL.
- Debit cards contributed only 1.36% of total payment value.
- Three orders had an undefined payment type and zero payment value.

Business Insight:
Credit cards were the dominant payment method, generating 78.34% of
the total payment value and recording the highest number of orders.

Boleto was the second most important payment method but contributed
substantially less payment value than credit cards.

The higher Average Order Value associated with credit cards indicates
that customers using this method generally completed higher-value
transactions. In contrast, voucher payments were associated with
lower-value purchases.

The undefined payment records have no financial impact because their
payment value is zero, but they should be noted as a minor data-quality
issue.
===========================================================================================================================
*/


/*
===========================================================================================================================
Business Question:
Does the Average Order Value increase as the number of payment
installments increases?

Analysis Objective:
Compare installment groups based on the number of orders, total payment
value, and Average Order Value (AOV).

This analysis helps determine whether customers use longer installment
plans for higher-value purchases.
===========================================================================================================================
*/


SELECT
    payment_installments AS Payment_Installments,
    COUNT(DISTINCT order_id) AS Order_Count,
    SUM(payment_value) AS Total_Payment_Value,

    CAST(
        ROUND(
            SUM(payment_value) /
            COUNT(DISTINCT order_id),
            2
        )
        AS DECIMAL(10,2)
    ) AS Average_Order_Value

FROM Payments

WHERE payment_type = 'credit_card'
  AND payment_installments > 0

GROUP BY
    payment_installments

ORDER BY
    payment_installments;

/*
Data Quality Note:
Two credit-card payment records had payment_installments equal to zero.

Both records had payment_sequential equal to 2, but no corresponding
payment record with payment_sequential equal to 1 was found for either
order.

Because zero does not represent a valid installment plan, these records
were excluded from the installment analysis. However, their payment
values were retained in general revenue and payment-method analyses.
*/

/*
Data Quality Check:
Investigate payment records with zero installments.
*/

SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM Payments
WHERE payment_installments = 0;

/*
Data Quality Investigation:
Review all payment records associated with orders that contain
a credit-card payment with zero installments.
*/

SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
FROM Payments
WHERE order_id IN
(
    '1a57108394169c0b47d8f876acc9ba2d',
    '744bade1fcf9ff3f31d860ace076d422'
)
ORDER BY
    order_id,
    payment_sequential;

/*
===========================================================================================================================
Result:
- Single-installment credit-card payments recorded the highest order
  volume, with 25,407 orders and an Average Order Value of 96.05 BRL.
- The Average Order Value generally increased as the number of
  installments increased.
- Orders paid in five installments averaged 183.64 BRL.
- Orders paid in eight installments averaged 308.82 BRL.
- Orders paid in ten installments averaged 416.10 BRL across
  5,315 orders.
- Installment plans above ten payments had substantially fewer orders,
  making their averages less representative.

Business Insight:
The analysis indicates a general relationship between longer installment
plans and higher-value credit-card purchases.

Average Order Value increased from 96.05 BRL for single-installment
payments to 416.10 BRL for ten-installment payments. This suggests that
customers are more likely to divide higher-value purchases into a larger
number of installments.

However, the pattern is not perfectly consistent at every installment
level, indicating that installment count is not the only factor affecting
order value.

Results for installment plans above ten payments should be interpreted
with caution because most of these groups contain very few orders and
may not represent typical customer behavior.

This analysis identifies an association between installment count and
order value, but it does not establish that additional installments
directly cause customers to spend more.
===========================================================================================================================
*/
