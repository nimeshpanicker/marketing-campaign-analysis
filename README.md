# Marketing Campaign Analysis

![Excel](https://img.shields.io/badge/Microsoft%20Excel-Data%20Preparation-green)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)
![Data Analysis](https://img.shields.io/badge/Data%20Analysis-Marketing-blue)
![Data Visualization](https://img.shields.io/badge/Data%20Visualization-Power%20BI-orange)

A 360° marketing campaign performance analysis project using **Microsoft Excel and Power BI** to evaluate advertising spend, reach, engagement, conversions, revenue, and campaign efficiency across products, categories, marketing channels, and time.

---

# 📌 Project Overview

This project analyzes **1,000 marketing campaign records** covering the period from **12 November 2024 to 9 February 2025**.

The analysis evaluates campaign performance through:

- Advertising spend
- Revenue
- Impressions
- Clicks
- Conversions
- CTR
- Conversion Rate
- CPM
- ROAS
- Product performance
- Category performance
- Marketing channel performance
- Monthly trends

The project transforms campaign-level data into an interactive **Power BI dashboard** that allows stakeholders to explore marketing performance and compare different categories.

---

# 🎯 Business Objective

Marketing teams need a consolidated view of where advertising budget is being spent and how efficiently that spending generates revenue.

The objective of this project is to provide a single analytical view that helps stakeholders:

- Monitor overall marketing campaign performance
- Evaluate advertising efficiency
- Track the marketing funnel
- Compare monthly performance
- Analyze category performance
- Compare marketing channels
- Identify high- and low-performing products
- Monitor ROAS, CTR, conversion rate and CPM
- Explore performance through an interactive Power BI dashboard

---

# ❓ Business Questions

The analysis addresses the following questions:

1. How much advertising spend was used across the campaign period?
2. How much revenue was attributed to the campaigns?
3. What was the overall ROAS?
4. How efficiently did impressions convert into clicks?
5. How efficiently did clicks convert into sales?
6. Which marketing channels generated stronger ROAS?
7. Which categories generated stronger revenue and conversion performance?
8. Which products generated the highest revenue?
9. Which products had lower ROAS?
10. How did campaign performance change month by month?
11. How does marketing spend compare with revenue and conversions?
12. Which areas require further investigation?

---

# 📊 Dataset Overview

The dataset contains:

- **1,000 campaign records**
- **11 columns**
- **25 products**
- **5 categories**
- **5 marketing channels**
- Campaign period: **12 November 2024 – 9 February 2025**

Each row represents a tracked campaign for a product on a marketing channel on a specific date. :contentReference[oaicite:1]{index=1}

## Categories

- Beverages
- Groceries
- Household
- Personal Care
- Snacks

## Marketing Channels

- Google Ads
- Referral
- Instagram Ads
- Influencer Marketing
- Email Campaign

## Main Dataset Columns

| Column | Description |
|---|---|
| Campaign ID | Unique campaign identifier |
| Product Name | Product promoted |
| Category | Product category |
| Ad Spend (INR) | Advertising cost |
| Impressions | Number of ad impressions |
| Clicks | Number of clicks |
| Conversions | Number of conversions |
| Revenue (INR) | Revenue attributed to the campaign |
| ROI | Return on investment recorded per campaign |
| Campaign Date | Date of campaign |
| Marketing Channel | Channel used for the campaign |

---

# 🧹 Data Preparation & Validation

The dataset was reviewed and prepared before building the Power BI dashboard.

The preparation process included:

- Reviewing all 11 columns
- Checking data types
- Checking missing values
- Checking duplicate campaign records
- Validating numeric fields
- Validating campaign dates
- Standardizing category values
- Standardizing marketing channel values
- Preparing the dataset as the Power BI source table

### Data Quality Results

- **0 missing values**
- **0 duplicate campaign records**
- All **1,000 Campaign IDs are unique**
- Numeric values were checked for valid non-negative values
- Funnel relationship was validated:

```text
Conversions ≤ Clicks ≤ Impressions
