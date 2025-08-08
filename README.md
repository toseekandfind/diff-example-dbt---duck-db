# 🦆 data-diff-demo

![CI](https://github.com/dbeatty10/data-diff-demo/workflows/CI/CD%20Pipeline/badge.svg)
![dbt](https://img.shields.io/badge/dbt-1.9+-blue)
![DuckDB](https://img.shields.io/badge/DuckDB-1.0+-orange)
![Python](https://img.shields.io/badge/Python-3.9+-green)

A comprehensive demonstration of data-diff functionality with a modern dbt project using dbt-duckdb. This project showcases how to detect and analyze data differences between development and production environments using industry best practices.

## ✨ Features

- 🚀 **Modern dbt setup** with latest dbt-core (1.9+) and dbt-duckdb
- 🔍 **Data difference detection** using data-diff between environments
- 🛠️ **Development tools** including pre-commit hooks, linting, and formatting
- 📊 **Comprehensive testing** with dbt tests and CI/CD pipeline
- 📚 **Auto-generated documentation** with dbt docs
- 🎯 **Best practices** following Brooklyn Data Co. SQL style guide

## 🏗️ Project Structure

```
.
├── .github/workflows/     # CI/CD pipeline
├── docs/                  # Documentation files
├── models/               # dbt models and schema definitions
├── .pre-commit-config.yaml # Code quality hooks
├── .sqlfluff             # SQL linting configuration
├── dbt_project.yml       # dbt project configuration
├── profiles.yml          # Database connection profiles
├── Makefile             # Development commands
└── requirements.in       # Python dependencies
```

## 🚀 Quick Start

### Prerequisites

Ensure you have the following installed:
- **Python 3.9+** 
- **Git**
- **Make** (optional, for convenience commands)

```shell
python3 --version  # Should be 3.9+
git --version
make --version     # Optional
```

### Installation

1. **Clone the repository**
   ```shell
   git clone https://github.com/dbeatty10/data-diff-demo.git
   cd data-diff-demo
   ```

2. **Set up the environment** (choose one method)
   
   **Option A: Using Make (recommended)**
   ```shell
   make setup          # Create virtual environment
   source venv/bin/activate
   make install        # Install dependencies and pre-commit hooks
   ```
   
   **Option B: Manual setup**
   ```shell
   python3 -m venv venv
   source venv/bin/activate
   python3 -m pip install --upgrade pip
   pip install -r requirements.txt
   pre-commit install
   ```

### Basic Usage

3. **Run the demo**
   ```shell
   # Option A: Using Make
   make data-diff
   
   # Option B: Manual commands
   dbt run -s simple_model --target prod --profiles-dir .
   dbt run -s simple_model --target dev --profiles-dir .
   data-diff --dbt --dbt-profiles-dir .
   ```

## 🔧 Development Commands

We provide a comprehensive Makefile for common development tasks:

```shell
make help           # Show all available commands
make install        # Install dependencies
make lint          # Run linting and formatting checks
make test          # Run dbt tests
make docs          # Generate and serve dbt documentation
make data-diff     # Run data difference analysis
make clean         # Clean generated files
make deps-update   # Update requirements.txt from requirements.in
```

## 🔍 Data Diff Analysis

This project demonstrates data-diff functionality by creating intentionally different data between environments:

- **Production**: Records have `color='orange'`
- **Development**: Records have `color='black'`

### Running Data Diff

```shell
# Quick comparison using dbt integration
data-diff --dbt --dbt-profiles-dir .

# Direct comparison (advanced)
data-diff 'duckdb://main@./diffle_shop.duckdb' prod.simple_model dev.simple_model -k id -c color
```

**Example Output:**
```diff
Found 1 successful model runs from the last dbt command.
- 1, orange, prod, 2024-01-15 10:30:00
+ 1, black, dev, 2024-01-15 10:30:00
```

### Output Formats

- **Default**: Human-readable diff format
- **JSON**: `data-diff --dbt --dbt-profiles-dir . --json`
- **Stats**: `data-diff --dbt --dbt-profiles-dir . --stats`

## 🧪 Testing & Quality

### Running Tests

```shell
make test           # Run all dbt tests
dbt test --profiles-dir .  # Manual test execution
```

### Code Quality

This project includes comprehensive code quality tools:

- **Pre-commit hooks** for automated checks
- **SQLFluff** for SQL linting and formatting
- **Black** and **isort** for Python code formatting
- **dbt-checkpoint** for dbt-specific validations

```shell
make lint           # Run all quality checks
pre-commit run --all-files  # Manual execution
```

## 📊 Documentation

Generate and view comprehensive project documentation:

```shell
make docs           # Generate and serve dbt docs
# Opens http://localhost:8080 with interactive documentation
```

## 🛠️ Configuration

### Database Configuration

The project uses DuckDB with optimized settings in `profiles.yml`:

- **Development**: 4 threads, 2GB memory limit
- **Production**: 8 threads, 4GB memory limit
- **Extensions**: httpfs, parquet, json

### dbt Configuration

Modern dbt setup with:
- dbt-core 1.9+ requirement
- Comprehensive model, test, and documentation configs
- Environment-specific hooks and settings

## 🚀 CI/CD Pipeline

GitHub Actions workflow includes:

- **Code quality** checks (linting, formatting)
- **dbt validation** (parse, compile, test)
- **Data diff testing** between environments
- **Documentation generation**
- **Artifact archiving**

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run quality checks: `make lint test`
5. Submit a pull request

## 📋 Advanced Usage

### Custom Data Sources

Add external data sources by configuring `external_location` in your dbt sources:

```yaml
sources:
  - name: external_data
    config:
      external_location: "s3://bucket/data/{name}.parquet"
```

### Environment Variables

Use `.env` file for sensitive configuration:

```shell
# .env
S3_ACCESS_KEY_ID=your_key
S3_SECRET_ACCESS_KEY=your_secret
```

### Debugging

```shell
make debug          # Check dbt configuration
dbt debug --profiles-dir .  # Manual debug
data-diff --dbt --dbt-profiles-dir . --debug  # Debug data-diff
```

## 📚 Additional Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [DuckDB Documentation](https://duckdb.org/docs/)
- [data-diff Documentation](https://github.com/datafold/data-diff)
- [Brooklyn Data Co. SQL Style Guide](https://github.com/brooklyn-data/co/sql-style-guide)

## 🔗 Related Projects

- [dbt-duckdb](https://github.com/duckdb/dbt-duckdb) - DuckDB adapter for dbt
- [data-diff](https://github.com/datafold/data-diff) - Data difference detection
- [dbt-checkpoint](https://github.com/dbt-checkpoint/dbt-checkpoint) - dbt pre-commit hooks

---

**Happy data diffing!** 🦆✨
