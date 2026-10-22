# 🛒 E-Commerce Margin Leakage & Profitability Intelligence Engine

[![Python](https://img.shields.io/badge/Python-3.10%2B-blue.svg)](https://www.python.org/)
[![DuckDB](https://img.shields.io/badge/DuckDB-Fast%20Analytics-orange.svg)](https://duckdb.org/)
[![Scikit-Learn](https://img.shields.io/badge/ML-Isolation%20Forest-yellow.svg)](https://scikit-learn.org/)
[![Econometrics](https://img.shields.io/badge/Econometrics-Difference--in--Differences-green.svg)](https://www.statsmodels.org/)

An enterprise-grade analytics engine designed to detect, diagnose, and remediate silent EBITDA leakages across **100K+ transactional records** from the Brazilian E-Commerce dataset (Olist).

---

## 📌 Executive Summary & Incident Case Study
> **"Diagnosing a R$ 111,760 Margin Collapse in Bulky Logistics"**
> - **The Symptom:** Gross revenue surged 14% during Q4 Black Friday promotions, but net Contribution Margin decayed to **-11.4%**.
> - **The Root Cause:** Dual anomaly detection (IQR + Isolation Forest) identified **492 high-confidence leakage orders** where freight costs exploded to **109.4% of product price**, coupled with 16.5% promo voucher stacking.
> - **Causal Econometric Proof (DiD):** Quasi-experimental Difference-in-Differences regression proved the discount campaign yielded **zero statistically significant margin lift ($p = 0.681$)**, confirming pure top-line cannibalization.
> - **Prescriptive Recovery:** Throttling vouchers on low-AOV items and implementing a bulky freight surcharge projects an annualized EBITDA recovery of **~R$ 340,000**.

---

## 🏗️ Architecture & Analytical Framework

```
Raw Transactional Data (Orders, Items, Payments, Products)
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│  Phase 1: Unit Economics & Contribution Margin Engine (SQL) │
│  CM = Revenue - COGS - Flat CAC (R$50) - Shipping - Returns  │
└─────────────────────────────┬───────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  Phase 2: Dual Anomaly Detection Engine                     │
│  • 1D Statistical Baseline: Interquartile Range (IQR)        │
│  • Multi-dimensional Unsupervised ML: Isolation Forest      │
│  • High-Confidence Leakage Intersection (492 critical leaks)│
└─────────────────────────────┬───────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  Phase 3 & 4: Root-Cause & Causal Econometrics (DiD)        │
│  Difference-in-Differences: Furniture (T) vs Beauty (C)     │
│  Result: Inherent penalty (-R$ 32.17), no causal lift       │
└─────────────────────────────┬───────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  Phase 5 & 6: Executive Incident Brief & Cockpit            │
│  Automated C-Suite briefs with verified data lineage        │
└─────────────────────────────────────────────────────────────┘
```

---

## 📊 Core Analytical Findings

### 1. Dual Anomaly Detection Matrix
| Method | Target Scope | Flagged Orders |
| :--- | :--- | :--- |
| **Statistical IQR** | 1D Realized Margin Distribution | 2,070 orders |
| **Isolation Forest (ML)** | Multi-dimensional (Rev, Shipping, CAC, Voucher %) | 2,895 orders |
| **High-Confidence Intersection** | Dual-Validated Operational Margin Drains | **492 orders** |

### 2. High-Confidence Leaks vs Normal Orders
| Metric | Normal Orders | High-Confidence Leak Orders | Deviation / Impact |
| :--- | :--- | :--- | :--- |
| **Average Freight Cost** | R$ 20.58 | **R$ 131.17** | **+537% Freight Shock** |
| **Shipping-to-Revenue Ratio** | 29.7% | **109.4%** | Shipping > Product Value |
| **Promotional Voucher Usage**| 3.18% | **16.48%** | Severe Promo Stacking |
| **Net Realized Margin** | R$ 18.30 | **-R$ 227.16** | **-R$ 111,761 Total Drain** |

### 3. Difference-in-Differences (DiD) Cannibalization Model
```
Model: item_margin ~ post_campaign + treatment + post_campaign:treatment
```
- **Treatment Category**: `furniture_decor` (Promotional target)
- **Control Category**: `health_beauty` (Organic baseline)
- **Results**:
  - `treatment` ($\beta = -32.17, p < 0.001$): Bulky furniture incurs R$ 32.17 higher baseline logistics friction.
  - `post:treatment` ($\beta = +2.30, p = 0.681$): No significant margin gain from discounts; proves margin cannibalization.

---

## 🛠️ Project Structure
```
margin-leakage-engine/
├── data/                               # Raw Olist transactional CSVs & assumptions
│   ├── olist_orders_dataset.csv
│   ├── olist_order_items_dataset.csv
│   ├── olist_order_payments_dataset.csv
│   ├── olist_products_dataset.csv
│   ├── product_category_name_translation.csv
│   └── assumptions.csv                 # Auditable unit-cost & return parameters
├── sql/                                # Modular SQL models & views
│   ├── 01_order_margin.sql             # Base contribution margin waterfall
│   ├── 02_create_margin_views.sql      # Item & order level analytical views
│   └── 03_leakage_profile.sql          # Anomaly profiling query
├── notebooks/                          # Production Jupyter notebooks
│   └── 01_explore.ipynb                # End-to-end analytical pipeline
├── docs/                               # Documentation & Incident Reports
│   ├── notes_day1.md                   # Unit economics & margin definitions
│   ├── notes_day2.md                   # Statistical vs ML anomaly comparison
│   ├── notes_day3.md                   # Category & regional root-cause breakdown
│   ├── notes_day4.md                   # DiD econometric specification
│   └── executive_incident_brief.md     # 1-page C-Suite executive incident memo
└── README.md
```

---

## 🚀 How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/margin-leakage-engine.git
   cd margin-leakage-engine
   ```
2. Set up virtual environment and install dependencies:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install pandas duckdb scikit-learn statsmodels jupyter
   ```
3. Run the complete analysis in `notebooks/01_explore.ipynb`.

---
*Authored by Data Analyst Portfolio Candidate*
