# Data Loading

## Overview

This phase focused on importing the raw CSV files into SQL Server after completing the database design.

The loading process was carefully planned to ensure that all records were imported successfully while preserving data integrity and supporting future analysis.

---

## Data Source

The project uses the **Olist Brazilian E-Commerce Dataset** provided in CSV format.

Each CSV file represents one database table.

---

## Loading Method

The data was imported using SQL Server's **BULK INSERT** statement.

This approach provides:

- High loading performance.
- Direct loading into existing tables.
- Better control over the import process.
- Suitable for large datasets.

---

## Loading Workflow

The following workflow was used for every table:

1. Create the database table.
2. Verify the table structure.
3. Prepare the CSV file.
4. Execute the BULK INSERT statement.
5. Verify the number of imported records.
6. Preview the imported data.
7. Perform data validation.

---

## Challenges Encountered

Several practical issues were encountered during the loading process, including:

- CSV formatting inconsistencies.
- UTF-8 encoding requirements.
- Row terminator configuration.
- Duplicate key values.
- Importing data into incorrect tables during early attempts.
- Bulk loading errors caused by dataset characteristics.

Each issue was investigated and resolved before continuing with the next table.

---

## Outcome

All dataset tables were successfully imported into SQL Server.

The imported data was then validated to confirm:

- Correct record counts.
- Successful loading.
- Data integrity.
- Readiness for SQL analysis.

---

## Summary

Completing the data loading phase established a reliable database containing all required e-commerce data and prepared the project for data validation and business analysis.