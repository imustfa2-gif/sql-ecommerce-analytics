# Business Rules

## Overview

Business rules define how data entities interact within the e-commerce system.

These rules represent real-world business processes and were implemented through database relationships, keys, and constraints to maintain data consistency and integrity.

---

## Customer Rules

- One customer can place multiple orders.
- Each order belongs to one customer.

---

## Order Rules

- Each order has a unique identifier.
- An order can contain one or more products.
- An order may have one or more payment records.
- An order may receive one customer review.
- Every order follows a business lifecycle represented by its status.

---

## Product Rules

- A product can appear in multiple orders.
- Each product belongs to one product category.
- Product categories are translated from Portuguese to English using a lookup table.

---

## Seller Rules

- One seller can sell multiple products.
- A seller may appear in many customer orders.

---

## Payment Rules

- Multiple payments may exist for the same order.
- Different payment methods are supported.
- Installment payments are allowed.

---

## Review Rules

- Customer reviews are linked to completed orders.
- Review scores range from 1 (lowest) to 5 (highest).
- Review comments are optional.

---

## Geolocation Rules

- Multiple geographic coordinates may exist for the same ZIP code prefix.
- Geographic information supports location-based analysis for customers and sellers.

---

## Data Integrity Rules

- Every table has a Primary Key.
- Foreign Keys maintain relationships between related tables.
- Lookup tables reduce data redundancy.
- Composite Primary Keys are used where necessary to preserve data uniqueness.

---

## Summary

These business rules provide the foundation for the relational database design and ensure that the database accurately represents real-world e-commerce operations while maintaining data integrity.