# E-commerce Customer Behaviour & Revenue Analysis

## 1. Project Overview
This project analyses Google Merchandise Store sample e-commerce activity using Google Analytics 4 (GA4) event data.

The analysis covers **1 November 2020 to 31 January 2021** and focuses on website activity, shopping events, product performance, purchase revenue, devices, monthly revenue and first-acquisition traffic sources.

## 2. Business Questions
- Which website activities happen most frequently?
- How many users perform key shopping events?
- Which device category generates the highest purchase revenue?
- Which products and categories generate the most revenue?
- Which month generated the highest purchase revenue?
- Which first-acquisition sources are associated with the most purchasing users and revenue?

## 3. Dataset
- **Source table:** `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
- **Platform:** Google BigQuery Public Datasets
- **Data:** GA4 sample e-commerce event data
- **Period analysed:** November 2020 – January 2021

This is an **obfuscated sample dataset**, not confidential data from a live company's store.

## 4. Tools and SQL Skills
- Google BigQuery
- SQL: `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, `LIMIT`
- Aggregations: `COUNT`, `COUNT DISTINCT`, `SUM`
- Conditional ordering using `CASE`
- Nested and repeated data using `UNNEST`
- Date formatting and parsing using `FORMAT_DATE` and `PARSE_DATE`
- Missing-label handling using `COALESCE`

## 5. Analysis Performed
- Website event summary and distinct-user counts.
- Summary of product views, add-to-cart, checkout and purchase events.
- Purchase revenue by device category.
- Top 10 products by revenue and units sold.
- Revenue and units sold by product category.
- Monthly purchase revenue trend.
- Purchase revenue by users' first-acquisition traffic source.

## 6. Key Findings
- **Total recorded purchase revenue:** $362,165.
- **Highest-revenue device:** Desktop — $208,815 (57.66% of revenue).
- **Highest-revenue category:** Apparel — $171,727.
- **Highest-revenue product:** Google Zip Hoodie F/C — $13,788.
- **Highest-revenue month:** December 2020 — $160,555.
- **Largest reported first-acquisition source by revenue:** Google — $104,831.

## 7. Project Files
- `sql/All_SQL_Queries.sql` – Seven SQL queries with business questions.
- `reports/Business_Findings.md` – Summary of analysis, findings and recommendations.
