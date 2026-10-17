# DeltaGuard: Streaming Medallion Pipeline

## Overview
DeltaGuard implements the Databricks Medallion architecture (Bronze → Silver → Gold) with streaming ingestion, incremental updates, and constraint-based data quality enforcement. It transforms raw JSON datasets into curated Silver tables and business-ready Gold materialized views.

## Architecture
- **Bronze Layer**: Ingests raw JSON files incrementally using Auto Loader (`cloud_files`). Tracks metadata such as processing time and source file.
- **Silver Layer**: Cleans and standardizes data with schema enforcement, deduplication, and constraints:
  - `amount > 0` → DROP ROW  
  - `customer_id IS NOT NULL` → FAIL UPDATE  
  - `timestamp IS NOT NULL` → WARN  
  - Email validation and price checks for Customers and Products.
- **Gold Layer**: Aggregates curated data into materialized views for analytics:
  - Customer Summary (spend, activity, lifecycle)  
  - Product Sales (units sold, revenue, category performance)  
  - Monthly Trends (transaction counts, revenue, high-value flags)

## Datasets
- **Customers**: `customer_id`, `name`, `email`, `signup_date`
- **Transactions**: `txn_id`, `customer_id`, `amount`, `timestamp`, `product_id`
- **Products**: `product_id`, `name`, `price`

## Features
- Incremental ingestion with Auto Loader
- Constraint-based data quality enforcement (warn, drop, fail)
- Derived columns for cohort analysis, transaction trends, and product categorization
- Materialized views for fast, reliable analytics

## Usage
1. Place JSON files in `/Volumes/deltaguard/default/...` directories.
2. Bronze tables ingest files incrementally.
3. Silver tables apply constraints and transformations.
4. Gold tables provide aggregated insights for dashboards and reporting.
