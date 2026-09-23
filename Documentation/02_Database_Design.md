# Database Design

## Overview

The database was designed following relational database principles to ensure data integrity, minimize redundancy, and support efficient analytical queries.

The schema is based on the Olist Brazilian E-Commerce dataset and consists of nine related tables representing customers, orders, products, sellers, payments, reviews, geolocations, and product category translations.

---

## Database Schema

The database contains the following tables:

| Table | Description |
|------|-------------|
| Customers | Stores customer information. |
| Orders | Stores customer orders. |
| Order_Items | Stores individual products within each order. |
| Products | Stores product information. |
| Sellers | Stores seller information. |
| Payments | Stores payment details for each order. |
| Order_Reviews | Stores customer reviews for completed orders. |
| Geolocation | Stores geographical information using ZIP code prefixes. |
| Category_Translation | Translates product category names from Portuguese to English. |

---

## Design Principles

The database design follows these principles:

- Normalized relational database structure.
- Clear Primary Key and Foreign Key relationships.
- Composite Primary Keys where required.
- Lookup tables used to reduce data redundancy.
- Business rules documented for every table.
- Referential integrity enforced using Foreign Keys.

---

## Primary Key Strategy

Most tables use a single-column Primary Key.

However, some tables required Composite Primary Keys to preserve data integrity.

| Table | Primary Key |
|------|-------------|
| Customers | customer_id |
| Orders | order_id |
| Products | product_id |
| Sellers | seller_id |
| Category_Translation | product_category_name |
| Payments | (order_id, payment_sequential) |
| Order_Items | (order_id, order_item_id) |
| Order_Reviews | (review_id, order_id) |
| Geolocation | (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng) |

---

## Relationship Design

Relationships were implemented using Foreign Keys to maintain referential integrity between related tables.

Examples include:

- Customers → Orders
- Orders → Payments
- Orders → Order_Items
- Orders → Order_Reviews
- Products → Order_Items
- Sellers → Order_Items
- Category_Translation → Products

---

## Design Decisions

Several design decisions were made after examining the actual dataset rather than relying only on theoretical assumptions.

Examples include:

- Geolocation contains duplicate ZIP code prefixes with different coordinates; therefore, a Composite Primary Key was implemented.
- Order_Reviews contains duplicate review IDs, so a Composite Primary Key was used to preserve all review records.
- Product category translation was implemented as a lookup table to simplify reporting and analysis.
- Foreign Keys were used to ensure data consistency across all related tables.

---

## Summary

The final database structure provides a clean and reliable foundation for SQL analysis and Power BI reporting while maintaining data integrity and supporting future analytical requirements.