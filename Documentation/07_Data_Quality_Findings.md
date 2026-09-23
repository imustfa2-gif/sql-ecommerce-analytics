# Data Quality Findings

## Overview

During the data loading and validation phases, several data quality observations were identified.

Not all findings represented data errors. Some reflected the real business processes of the e-commerce platform and were therefore preserved.

This document summarizes the most important findings and explains how each case was handled.

---

## Finding 1 – Duplicate ZIP Code Prefixes

### Observation

Multiple records shared the same ZIP code prefix but had different geographic coordinates.

### Decision

A Composite Primary Key consisting of:

- geolocation_zip_code_prefix
- geolocation_lat
- geolocation_lng

was implemented to preserve all valid geographic records.

---

## Finding 2 – Duplicate Review IDs

### Observation

Some review IDs were repeated in the dataset.

### Decision

The table design was updated to use a Composite Primary Key consisting of:

- review_id
- order_id

This preserved all review records without losing data.

---

## Finding 3 – Missing Values

### Observation

Several nullable columns contained missing values.

Examples included:

- Product dimensions
- Product weight
- Review comments
- Order approval dates
- Delivery dates

### Decision

These values were preserved because they accurately represent real business scenarios such as cancelled orders, unavailable product information, or customers choosing not to leave review comments.

---

## Finding 4 – Logical Date Validation

### Observation

Order dates, approval dates, shipping dates, and delivery dates were validated.

### Result

No logical inconsistencies were detected.

The chronological order of events was valid.

---

## Finding 5 – Foreign Key Validation

### Observation

Relationships between related tables were validated.

### Result

No orphan records were identified.

All Foreign Key relationships were successfully maintained.

---

## Finding 6 – Payment Validation

### Observation

A small number of credit card payments contained only one installment.

### Decision

This was considered a valid business scenario rather than a data quality issue.

---

## Finding 7 – Freight Cost Analysis

### Observation

Some order items had shipping costs greater than the product price.

### Decision

These records were retained because they may represent legitimate business situations such as low-cost products shipped over long distances.

---

## Overall Assessment

The dataset demonstrated a high level of quality.

Most validation checks passed successfully, and the identified issues were either resolved through database design decisions or determined to be valid business cases.

The database is considered ready for SQL analysis and Power BI reporting.