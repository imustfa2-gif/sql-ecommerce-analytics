# Data Validation

## Overview

After loading the data into SQL Server, a comprehensive validation process was performed to verify data quality, consistency, and integrity before starting the analysis phase.

Each table was validated independently using SQL queries designed to detect potential issues.

---

## Validation Objectives

The validation process focused on verifying:

- Successful data loading.
- Record counts.
- Primary Key uniqueness.
- Composite Primary Key uniqueness.
- Missing values.
- Foreign Key consistency.
- Duplicate records.
- Logical consistency.
- Data readiness for analysis.

---

## Validation Process

For each table, the following validation steps were performed when applicable:

1. Verify the total number of imported records.
2. Preview sample records.
3. Check Primary Key uniqueness.
4. Check Composite Primary Key uniqueness.
5. Identify missing values in important columns.
6. Validate Foreign Key relationships.
7. Verify business logic.
8. Investigate abnormal or unexpected values.

---

## Validation Results

| Table | Validation Status |
|---------|------------------|
| Customers | Passed |
| Orders | Passed |
| Products | Passed |
| Sellers | Passed |
| Payments | Passed |
| Order_Items | Passed |
| Order_Reviews | Passed |
| Geolocation | Passed |
| Category_Translation | Passed |

---

## Key Validation Checks

Examples of validation checks include:

- Duplicate Primary Key detection.
- Composite Key verification.
- NULL value analysis.
- Record count verification.
- Foreign Key validation.
- Logical date validation.
- Business rule verification.

---

## Outcome

The validation process confirmed that all tables were successfully imported and satisfied the required quality checks.

Any issues discovered during validation were investigated, documented, and resolved before proceeding to the analysis phase.

---

## Summary

Data validation ensured that the database was accurate, consistent, and ready for SQL analysis and reporting.