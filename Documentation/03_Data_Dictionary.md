# Data Dictionary

## Overview

The Data Dictionary provides a detailed description of every table and column in the database.

Its purpose is to help developers, analysts, and business users understand the structure of the database without examining the SQL scripts directly.

---

# Customers

### Description

Stores customer information.

| Column | Data Type | Description |
|---------|----------|-------------|
| customer_id | VARCHAR(32) | Unique identifier for each customer. |
| customer_unique_id | VARCHAR(32) | Permanent customer identifier across multiple orders. |
| customer_zip_code_prefix | VARCHAR(10) | Customer ZIP code prefix. |
| customer_city | VARCHAR(100) | Customer city. |
| customer_state | CHAR(2) | Customer state abbreviation. |

---

# Orders

### Description

Stores customer orders.

| Column | Data Type | Description |
|---------|----------|-------------|
| order_id | VARCHAR(32) | Unique order identifier. |
| customer_id | VARCHAR(32) | Customer who placed the order. |
| order_status | VARCHAR(15) | Current order status. |
| order_purchase_timestamp | DATETIME | Date and time when the order was placed. |
| order_approved_at | DATETIME | Date and time when payment was approved. |
| order_delivered_carrier_date | DATETIME | Date when the carrier received the order. |
| order_delivered_customer_date | DATETIME | Date when the customer received the order. |
| order_estimated_delivery_date | DATETIME | Estimated delivery date. |

---
# Products

### Description

Stores product information available in the e-commerce platform.

| Column | Data Type | Description |
|---------|----------|-------------|
| product_id | VARCHAR(32) | Unique identifier for each product. |
| product_category_name | VARCHAR(100) | Product category name in Portuguese. |
| product_name_length | INT | Number of characters in the product name. |
| product_description_length | INT | Number of characters in the product description. |
| product_photos_qty | INT | Number of product images available. |
| product_weight_g | INT | Product weight in grams. |
| product_length_cm | INT | Product length in centimeters. |
| product_height_cm | INT | Product height in centimeters. |
| product_width_cm | INT | Product width in centimeters. |

---
# Category_Translation

### Description

Translates product category names from Portuguese to English.

| Column | Data Type | Description |
|---------|----------|-------------|
| product_category_name | VARCHAR(100) | Product category name in Portuguese. |
| product_category_name_english | VARCHAR(100) | Product category name in English. |

---
# Sellers

### Description

Stores seller information.

| Column | Data Type | Description |
|---------|----------|-------------|
| seller_id | VARCHAR(32) | Unique identifier for each seller. |
| seller_zip_code_prefix | VARCHAR(10) | Seller ZIP code prefix. |
| seller_city | VARCHAR(100) | Seller city. |
| seller_state | CHAR(2) | Seller state abbreviation. |

---
# Geolocation

### Description

Stores geographic location information based on ZIP code prefixes.

| Column | Data Type | Description |
|---------|----------|-------------|
| geolocation_zip_code_prefix | VARCHAR(10) | ZIP code prefix. |
| geolocation_lat | DECIMAL(9,6) | Latitude coordinate. |
| geolocation_lng | DECIMAL(9,6) | Longitude coordinate. |
| geolocation_city | VARCHAR(100) | City name. |
| geolocation_state | CHAR(2) | State abbreviation. |

---
# Payments

### Description

Stores payment information for customer orders.

| Column | Data Type | Description |
|---------|----------|-------------|
| order_id | VARCHAR(32) | Identifier of the related order. |
| payment_sequential | INT | Sequence number of the payment for the order. |
| payment_type | VARCHAR(32) | Payment method used by the customer. |
| payment_installments | INT | Number of payment installments. |
| payment_value | DECIMAL(10,2) | Total payment amount. |

---
# Order_Items

### Description

Stores individual products included in customer orders.

| Column | Data Type | Description |
|---------|----------|-------------|
| order_id | VARCHAR(32) | Identifier of the related order. |
| order_item_id | INT | Item sequence number within the order. |
| product_id | VARCHAR(32) | Purchased product identifier. |
| seller_id | VARCHAR(32) | Seller responsible for the product. |
| shipping_limit_date | DATETIME | Shipping deadline for the seller. |
| price | DECIMAL(10,2) | Product price. |
| freight_value | DECIMAL(10,2) | Shipping cost charged for the item. |

---
# Order_Reviews

### Description

Stores customer reviews submitted for completed orders.

| Column | Data Type | Description |
|---------|----------|-------------|
| review_id | VARCHAR(32) | Review identifier. |
| order_id | VARCHAR(32) | Identifier of the reviewed order. |
| review_score | INT | Customer satisfaction rating (1–5). |
| review_comment_title | VARCHAR(100) | Review title provided by the customer. |
| review_comment_message | VARCHAR(MAX) | Review comment submitted by the customer. |
| review_creation_date | DATETIME | Date when the review was created. |
| review_answer_timestamp | DATETIME | Date and time when the review was submitted. |

---