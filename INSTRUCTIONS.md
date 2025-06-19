# Case Study at Varengold Bank AG - Data Analyst

## Introduction

Dear applicant,

Thank you for taking your time and agreeing to work on a short case study for us.

In order not to take too much of your time, we have prepared this repository for you. We propose a folder structure and provide some initial code snippets as well as a database with sample banking data that should get you going very quickly. Depending on your prior knowledge, we estimate a working effort of 3h - 5h.

The goal of this test is to evaluate your understanding of SQL, PowerBI, dbt, data analysis, dashboard creation, and business intelligence concepts. You'll be working with realistic banking data to create insights and visualizations that support business decision-making using PowerBI and dbt.

Once you feel ready - please not later than one day before your second interview - send us a link to your own repository and PowerBI files. In the interview, you will guide us briefly through your analysis and findings. Your participation is very much appreciated!

In case you have any problems, questions or feedback, please don't hesitate to approach us right away.

Good luck and have fun,

Your Varengold data team

[Contact us](mailto:v.staack@varengold.de)

### Prerequisites

- Docker
- vscode 
- Git
- **PowerBI Desktop** (latest version)
- PowerBI account (free version is sufficient)
- **dbt** (data build tool)

## Case Study

We have a banking data model that contains data about our customers, their accounts and loans, as well as their transactions in various currencies. The data has been cleaned and processed into an intermediate schema. Your role as a Data Analyst is to explore this data, understand the business context, and create meaningful dashboards and insights for business stakeholders using PowerBI and dbt for data transformation.

You'll be working primarily with the **Branch Performance Manager** who needs to understand how different branches are performing and wants to present findings to senior management using PowerBI dashboards.

<details>
<summary> <b> Tasks: </b> </summary>

**Setup:**

1. [ ] Please create a repository and commit this content (or clone and change remote)
2. [ ] Start the devcontainer in the repository
3. [ ] Set up dbt project structure and configuration
4. [ ] Set up PowerBI Desktop and configure data ingestion from the database
5. [ ] Create a PowerBI workspace for your analysis

**Data Exploration (PowerBI):**

- [ ] Create a comprehensive data exploration dashboard in PowerBI
- [ ] Ingest the data into PowerBI using your preferred method (CSV export, database connection, etc.)

**Data Engineering (dbt):**

In the `transformations` directory, you'll find a pre-build dbt project that resembles a production repository used for data engineering projects at Varengold. We would like to ask you to create a materialized reporting table that sums up all transactions in EUR per customer, account, branch and transactions_date. The table should be placed in a dedicated schema (like reporting or marts).

- [ ] Implement a dbt model that creates a materialized table in the reporting schema
- [ ] The model should sum up all transactions in EUR (Euro) per customer, account, branch and date
- [ ] Use the provided exchange rate table for currency conversion across all dates
- [ ] Include appropriate dbt tests for data quality validation
- [ ] Implement proper dbt best practices (staging, intermediate, mart layers if applicable)

**Business Intelligence Dashboard (PowerBI):**

You've been asked to create a dashboard for the Branch Performance Manager, who needs to understand how different branches are performing in terms of customer transaction activity. They mentioned wanting to see 'the important numbers' broken down by branch and over time, and specifically asked about EUR equivalents since they deal with multiple currencies. They'll be presenting this to senior management next week.

- [ ] Create a comprehensive Branch Performance Dashboard in PowerBI

</details>

**Submission:**

- [ ] Please send us a link to your repository with complete dbt project
- [ ] Include PowerBI files (.pbix) and publish to PowerBI service if possible
- [ ] Provide screenshots of key dashboard pages in your repository
- [ ] Include dbt documentation output (docs generate)
- [ ] Include a brief summary of your key findings and recommendations
- [ ] Document your chosen data ingestion method and rationale


### Evaluation Criteria:

- **Data Exploration (PowerBI):** Effective use of PowerBI for data discovery and quality assessment
- **Business Understanding:** Ability to translate data into business insights using appropriate visualizations
- **Dashboard Design:** User experience, visual clarity, interactivity, and PowerBI best practices
- **SQL/dbt Proficiency:** Query efficiency, correctness, and dbt best practices implementation
- **PowerBI Proficiency:** Effective use of DAX, data modeling, and advanced PowerBI features
- **dbt Proficiency:** Proper project structure, testing, documentation, and transformation logic
- **Analytical Thinking:** Quality of insights and business recommendations
- **Communication:** Clarity of presentation and storytelling with data

### Business Context

You're analyzing data for a multi-branch bank that:
- Operates across multiple branches with different performance levels
- Handles transactions in multiple currencies (requires EUR conversion)
- Offers various account types and loan products
- Serves customers across different age demographics
- Needs to track performance metrics for management reporting
- **Senior management prefers PowerBI dashboards for strategic decision-making**
- **Data transformations must be version-controlled and documented using dbt**

### Data Schema Overview

The intermediate schema contains cleaned and processed tables:
- **customers:** Customer demographics and branch assignments
- **accounts:** Account information linked to customers
- **transactions:** All transaction data with multi-currency support
- **loans:** Loan portfolio with approval/rejection status
- **fx_rates:** Exchange rates for currency conversion
- **currencies:** Currency lookup table

### ERD (DuckDB: intermediate schema)

The entity-relationship diagram shows how the individual tables are related to each other.

<img src="docs/erd.png">

## Getting Started

1. **Set Up dbt Project:** Initialize dbt project and configure database connection
2. **Data Ingestion Strategy:** Choose your preferred method to get data into PowerBI
3. **Explore the Data:** Start with PowerBI data exploration to understand what you're working with
4. **Data Transformation:** Create dbt models for data preparation and transformation
5. **Understand the Business:** Review the Branch Performance Manager requirements
6. **Build PowerBI Dashboards:** Create interactive, executive-ready dashboards using transformed data
7. **Think Like an Analyst:** Focus on insights that drive business decisions
8. **Document Your Work:** Use dbt docs and prepare to explain your analysis approach

### Data Ingestion Options:

- Export data from DuckDB to CSV/Excel files for PowerBI import
- Use database connectors if available for your setup
- Export dbt model outputs directly to PowerBI-compatible formats
- **Document your chosen approach and rationale**
- Consider data refresh strategies for production environments

### dbt Project Structure:
```
dbt_project/
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
├── tests/
├── macros/
└── docs/
```

Remember: The goal is not just to create dashboards, but to demonstrate your ability to extract meaningful business insights from data and communicate them effectively to stakeholders using industry-standard tools like PowerBI and dbt. Show proficiency in both technical data preparation (dbt/SQL) and business presentation (PowerBI).
