.PHONY: help install deps-update clean test lint format run docs data-diff setup pre-commit

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: ## Initial project setup
	python3 -m venv venv
	@echo "Virtual environment created. Activate with: source venv/bin/activate"
	@echo "Then run: make install"

install: ## Install dependencies
	python -m pip install --upgrade pip
	pip install -r requirements.txt
	pre-commit install

deps-update: ## Update requirements.txt from requirements.in
	pip-compile --resolver=backtracking requirements.in
	pip install -r requirements.txt

clean: ## Clean generated files
	rm -rf target/
	rm -rf logs/
	rm -rf dbt_packages/
	rm -f *.duckdb*
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -name "*.pyc" -delete

lint: ## Run linting checks
	pre-commit run --all-files

format: ## Format code
	black .
	isort . --profile black
	sqlfluff fix models/ --dialect duckdb

test: ## Run dbt tests
	dbt deps --profiles-dir .
	dbt run --profiles-dir . --target dev
	dbt test --profiles-dir . --target dev

run: ## Run dbt models
	dbt deps --profiles-dir .
	dbt run --profiles-dir .

docs: ## Generate dbt documentation
	dbt deps --profiles-dir .
	dbt docs generate --profiles-dir .
	dbt docs serve --profiles-dir .

data-diff: ## Run data-diff comparison
	dbt run -s environment_comparison_demo --target prod --profiles-dir .
	dbt run -s environment_comparison_demo --target dev --profiles-dir .
	data-diff --dbt --dbt-profiles-dir .

pre-commit: ## Install pre-commit hooks
	pre-commit install
	pre-commit run --all-files

debug: ## Debug dbt configuration
	dbt debug --profiles-dir .