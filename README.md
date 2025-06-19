# Varengold Bank AG - Data Analyst Case Study

Welcome to the Varengold Bank Data Analyst case study repository! This repository contains everything you need to complete your technical assessment for the Data Analyst position.

## 📋 Overview

This case study is designed to evaluate your skills in SQL, dbt, PowerBI, and business intelligence. You'll be working with realistic banking data to create insights and dashboards that support business decision-making.

**Estimated Time:** 3-5 hours

## 🏗️ Repository Structure

```
├── .devcontainer/          # Development container configuration
│   ├── devcontainer.json   # Container settings and VS Code extensions
│   ├── Dockerfile          # Container image definition
│   ├── onCreateCommand.sh  # Setup script
│   └── bash/              # Terminal configuration files
├── data/                   # Sample banking dataset
│   └── currencies.csv     # Currency reference data
├── docs/                  # Case study documentation
│   └── erd.png           # Entity Relationship Diagram
├── out/                   # Output and exported data
│   └── duckdb_export/     # Exported database files
├── src/                   # Source code (if needed)
│   └── varengold_data_analyst_case/
├── transformation/         # dbt project directory
│   ├── analyses/          # Analysis and exploration SQL
│   ├── casestudy.duckdb   # DuckDB database file
│   ├── dbt_packages/      # Installed dbt packages
│   │   ├── codegen/       # Code generation utilities
│   │   ├── dbt_date/      # Date utility functions
│   │   └── dbt_utils/     # Common dbt utilities
│   ├── logs/              # dbt execution logs
│   ├── macros/            # Custom dbt macros
│   ├── models/            # dbt models
│   │   ├── intermediate/  # Intermediate transformations
│   │   ├── staging/       # Staging layer models
│   │   └── sources.yml    # Source definitions
│   ├── seeds/             # Reference data (CSV files)
│   ├── snapshots/         # Snapshot models
│   ├── target/            # dbt build outputs
│   ├── tests/             # Data quality tests
│   ├── dbt_project.yml    # dbt configuration
│   ├── packages.yml       # dbt package dependencies
│   ├── profiles.yml       # dbt profiles configuration
│   └── requirements.txt   # Python dependencies
├── INSTRUCTIONS.md        # 📖 Main case study instructions
├── pyproject.toml         # Python project configuration
├── README.md             # This file
└── uv.lock               # Python dependency lock file
```

## 🛠️ Setup Requirements

Before you begin, make sure you have the following installed on your machine:

### Required Software:
- **Visual Studio Code** (latest version)
- **Docker Desktop** (latest version)
- **PowerBI Desktop** (latest version)
- **Git** (for version control)

### VS Code Extensions:
The devcontainer will automatically install the required extensions, but you may want to have the following available:
- Remote - Containers
- Remote Development Extension Pack

### PowerBI Requirements:
- PowerBI Desktop (free version is sufficient)
- PowerBI account (optional, for publishing)

## 🚀 Getting Started

### Step 1: Clone the Repository
```bash
git clone <your-repository-url>
cd <repository-name>
```

### Step 2: Open in VS Code
```bash
code .
```

### Step 3: Setup Development Container

1. **Open Command Palette**: Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (Mac)

2. **Reopen in Container**: Type and select `Dev Containers: Reopen in Container`
   - Alternatively, VS Code may show a popup asking if you want to reopen in container - click "Reopen in Container"

3. **Wait for Setup**: The container will build and configure automatically
   - This may take a few minutes on first run
   - The setup script will install dbt packages and configure the environment

4. **Verify Setup**: Once complete, you should see:
   - Terminal with custom bash configuration
   - dbt packages installed in `transformation/dbt_packages/`
   - DuckDB CLI available
   - All required Python packages installed

### Step 4: Explore the Environment

After the container is running, you can:

```bash
# Navigate to the dbt project
cd transformation

# Check dbt installation
dbt --version

# Install/update dbt packages
dbt deps

# Test database connection
dbt debug
```

### Step 5: Start Working on the Case Study

📖 **Read the detailed case study instructions in [`INSTRUCTIONS.md`](INSTRUCTIONS.md)**

The case study includes:
- Data exploration requirements
- dbt transformation tasks
- PowerBI dashboard creation
- Business analysis objectives

## 🗃️ Data Overview

The repository includes a realistic banking dataset stored in the DuckDB database (`transformation/casestudy.duckdb`) with the following tables:
- **customers** - Customer demographics and branch assignments
- **accounts** - Account information linked to customers  
- **transactions** - All transaction data with multi-currency support
- **loans** - Loan portfolio with approval/rejection status
- **fx_rates** - Exchange rates for currency conversion
- **currencies** - Currency lookup table

See the Entity Relationship Diagram in `docs/erd.png` for detailed schema information.

## 🔧 Development Workflow

### dbt Development:
```bash
cd transformation

# Run dbt models
dbt run

# Test data quality
dbt test
```

### Data Export for PowerBI:
```bash
# Export data using DuckDB CLI
duckdb transformation/casestudy.duckdb "COPY table_name TO 'output.csv' (HEADER, DELIMITER ',')"

# Or use Python scripts for custom exports
python export_data.py
```

## 📊 PowerBI Integration

Since there's no direct PowerBI connector for DuckDB:
1. Export your dbt model outputs to CSV/Excel
2. Import the files into PowerBI Desktop  
3. Create your dashboard and analysis
4. Document your data ingestion approach

## 📝 Submission Guidelines

When you're ready to submit:

1. **Code Repository**: Ensure all your dbt models, tests, and documentation are committed
2. **PowerBI Files**: Include your .pbix files
3. **Documentation**: Add screenshots of key dashboard pages
4. **Summary**: Include a brief summary of findings and recommendations
5. **Data Ingestion**: Document your chosen approach for getting data into PowerBI

## 🆘 Need Help?

If you encounter any issues:

1. **Container Issues**: Try rebuilding the container (`Dev Containers: Rebuild Container`)
2. **dbt Issues**: Check `dbt debug` output for connection problems
3. **Data Issues**: Refer to the ERD and data documentation in `docs/`
4. **PowerBI Issues**: Document your approach and any workarounds used

## 📞 Contact

For questions or technical issues, reach out to:
- **Email**: [v.staack@varengold.de](mailto:v.staack@varengold.de)
- **Subject**: Data Analyst Case Study - [Your Name]

---

**Good luck with your case study! We're excited to see your analysis and insights.** 🚀

*Remember: The goal is not just to complete the tasks, but to demonstrate your ability to extract meaningful business insights and communicate them effectively to stakeholders.*


