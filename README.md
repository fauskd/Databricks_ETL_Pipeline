# Databricks ETL Pipeline with Unity Catalog

An end-to-end Extract, Transform, Load (ETL) and Data Analysis pipeline built using **Databricks**, **PySpark**, **Delta Lake**, and **Unity Catalog**. This project automates data ingestion, governance-ready schema transformations, Delta table loading, querying, and visualization with robust CI/CD integration.

---

## 🚀 Project Overview

This project demonstrates a production-ready Databricks ETL pipeline utilizing **Unity Catalog** for centralized governance, access control, and metadata management across three core stages:

1. **Extract**: Fetch raw datasets from external REST endpoints or cloud storage into staging storage/volumes.
2. **Transform**: Process and clean raw data using PySpark DataFrames, applying schema definitions and data validation.
3. **Load**: Write output datasets as **Delta Lake** managed or external tables inside a **Unity Catalog** three-level namespace (`catalog.schema.table`).
4. **Query & Analyze**: Run SQL queries against Unity Catalog tables and generate visual data insights (e.g., using Matplotlib/Seaborn).

---

## 🏛️ Unity Catalog Architecture

The pipeline uses Unity Catalog's 3-level namespace to organize and govern data:

```text
[ Catalog: main / dev ]
       └── [ Schema: etl_pipeline ]
              ├── [ Volume: raw_data ]         <-- Staging files
              ├── [ Table: raw_events ]        <-- Bronze Layer
              └── [ Table: processed_metrics ] <-- Silver/Gold Layer
