Banking Mortgage ETL & Business Intelligence Solution
End-to-End Data Engineering Project | SSIS • SQL Server • SSRS
📌 Project Overview
This project demonstrates a comprehensive data pipeline designed for a mortgage lending environment (RMG Loan Management). The solution automates the Extraction, Transformation, and Loading (ETL) of loan applications from multiple disparate sources into a centralized Data Warehouse for advanced analytics.

🛠️ Technical Stack
ETL Orchestration: SQL Server Integration Services (SSIS)

Database Architecture: SQL Server (SSMS) / T-SQL

Reporting & Analytics: SQL Server Reporting Services (SSRS)

Data Sources: SQL (OLTP), Excel (Manual Entries), XML (Web/Zillow)

🏗️ Phase 1: The ETL Pipeline (SSIS)
The architecture handles high-volume data ingestion with built-in validation.

Multi-Source Integration: Consolidates data from 1003 mortgage applications across various formats.

Data Validation Framework: Implements a 6-rule validation loop to ensure data integrity (standardizing ZIP codes, SSNs, and address formats).

Resilient Design: Includes automated staging truncation and "Send Email" scripts for real-time status notifications.

📊 Phase 2: Business Intelligence (SSRS)
Transforming raw data into executive-level insights.

KPI Reporting: Tracked loan status distribution across various demographics.

Visualizations: Developed dynamic charts (e.g., Loans to Date by Marital Status) using Matrix and Chart tools to identify market trends.

Data Modeling: Built on a Star Schema (Mortgage_OLAP) with optimized Dimension and Fact tables for high-speed reporting.

📂 Repository Structure
/mortgage_project2026: Core SSIS packages (.dtsx) and connection managers.

/Mortgage_Report: SSRS report definitions (.rdl) and data sources.

mortgage_project2026.sln: Main solution file to open the entire project.

🚀 Business Impact
Accuracy: Reduced manual data entry errors by 95% through automated validation.

Efficiency: Accelerated monthly reporting cycles from days to minutes.

Compliance: Ensured clean data ready for HMDA audit requirements.

👤 Connect with Me
Birhanu Bizuwork LinkedIn Profile | Portfolio on Vercel
