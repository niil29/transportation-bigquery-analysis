# transportation-bigquery-analysis
End-to-end transportation analytics project using BigQuery and SQL


# Transportation Demand & Performance Analysis using BigQuery

## 📊 Project Overview
This project analyzes real-world transportation data from NYC Yellow Taxi trips to uncover demand patterns, congestion behavior, revenue drivers, and operational performance. The project was built using Google BigQuery (Sandbox) and focuses on writing scalable, production-style SQL.

The goal is to demonstrate end-to-end analytical thinking:
- Data profiling
- Data cleaning & transformation
- Business-driven analysis
- Advanced SQL techniques

---

## 📂 Dataset
- **Source:** NYC Taxi & Limousine Commission (Public BigQuery Dataset)
- **Table:** `bigquery-public-data.new_york.tlc_yellow_trips_2016`
- **Records:** Millions of trip-level records
- **Supplementary Data:** Taxi zone lookup (uploaded as dimension table)

---

## 🧹 Data Cleaning & Transformation
A cleaned analytical layer was created using a BigQuery **view**, applying the following rules:
- Valid passenger counts (1–8)
- Positive trip distance and revenue
- Valid trip duration (1–400 minutes)
- Removed incorrect timestamps
- Derived features:
  - Trip duration (minutes)
  - Pickup date
  - Pickup hour

---

## 🗂 Data Model
- **Fact View:** `clean_trips`
- **Dimension Table:** `taxi_zone_lookup`

This follows a **star-schema approach** for readable and scalable analytics.

---

## 📈 Analysis Performed
### Core Analysis
- Daily and monthly demand trends
- Peak hour analysis
- Revenue vs demand comparison
- Top pickup locations and routes
- Weekday vs weekend behavior

### Advanced Analysis
- Average speed & congestion detection
- Percentile analysis (P50, P90, P99)
- Anomaly detection (outlier trips)
- High-value route identification
- Rolling 7-day demand trends
- Trip segmentation (short, medium, long)

---

## 🛠 SQL & BigQuery Concepts Used
- CTEs
- Views
- Window functions
- Percentile analysis (`APPROX_QUANTILES`)
- Fact–dimension joins
- Time-series analysis
- Cost-aware querying principles

---

## 🔍 Key Insights
- Peak demand aligns with commute hours
- Revenue patterns differ from trip volume
- Manhattan zones dominate pickup activity
- Congestion significantly impacts trip duration during peak hours
- Percentile analysis provides better performance insights than averages

---

## 🚀 How This Would Scale in Production
- Partition fact tables by pickup date
- Cluster by pickup location
- Materialize clean layers
- Cache dimension tables
- Monitor query cost and performance

---

## 📌 Tools
- Google BigQuery (Sandbox)
- SQL

---

## 📂 Repository Structure
- `sql/01_data_profiling.sql` – Initial data exploration
- `sql/02_data_cleaning.sql` – Cleaning & transformation logic
- `sql/03_core_analysis.sql` – Business analysis queries
- `sql/04_advanced_analysis.sql` – Advanced analytics & window functions

---

## 👤 Author
Indranil Mukherjee  
(Data Analyst / SQL & BigQuery)
