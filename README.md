# Olist Brazilian E-Commerce SQL Analytics

## Overview

This portfolio project builds and analyzes a relational SQL Server database using the Olist Brazilian E-Commerce dataset. It covers database design, CSV loading, data validation, business analysis, and preparation for a Power BI dashboard.

## Tools

- Microsoft SQL Server Express
- SQL Server Management Studio (SSMS)
- SQL
- Power BI (planned dashboard phase)

## Dataset

Source: [Olist Brazilian E-Commerce Dataset on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The database contains nine tables:

- `Customers`
- `Orders`
- `Order_Items`
- `Products`
- `Sellers`
- `Payments`
- `Order_Reviews`
- `Geolocation`
- `Category_Translation`

## Project Workflow

1. Create the `EcommerceAnalytics` database.
2. Create normalized tables, keys, and relationships.
3. Load the CSV files with `BULK INSERT`.
4. Validate record counts, keys, missing values, and relationships.
5. Run the topic-based business-analysis scripts.
6. Use the results as the analytical foundation for Power BI.

> Before running the import scripts, update the `D:\SQLData\...` paths to the CSV location accessible to your SQL Server instance.

## Repository Structure

```text
SQL_Ecommerce_Analytics/
├── Dataset/
├── Documentation/
├── Results/
├── Screenshots/
├── SQL Scripts/
│   ├── 01_Create_Database/
│   ├── 02_Create_Tables/
│   ├── 03_Data_Import/
│   ├── 04_Data_Validation/
│   └── 05_Business Analysis/
└── README.md
```

## Business Analysis

The analysis is organized into nine scripts:

1. Executive KPIs
2. Revenue trends
3. Product performance
4. Customer behavior and geography
5. Payment methods and installments
6. Delivery performance
7. Customer reviews
8. Seller performance
9. Freight-cost analysis

See [`SQL Scripts/05_Business Analysis/README.md`](SQL%20Scripts/05_Business%20Analysis/README.md) for the script index.

## Key Findings

- 97.02% of orders were delivered and 0.63% were canceled.
- Average payment value per order was approximately 160.99 BRL.
- Only 3.12% of unique customers placed more than one order.
- Credit cards generated 78.34% of payment value.
- 93.23% of evaluated deliveries arrived on time or early.
- Late deliveries averaged 2.27 stars versus 4.29 stars for on-time deliveries.
- Freight cost equaled 16.57% of product sales value overall.

## Data-Quality Notes

- One delivered order had no matching payment record.
- Eight delivered orders had no recorded customer-delivery date.
- Two credit-card payment records had zero installments and an incomplete payment sequence.
- A small number of very long delivery durations were retained and documented rather than silently removed.

## Author

Israa Mustafa
