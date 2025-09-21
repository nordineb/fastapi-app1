# FastAPI Application - Development Makefile
# Focused on local development, testing, and code quality

.PHONY: help dev-setup dev-run dev-test dev-clean lint format test-unit
.DEFAULT_GOAL := help

# Colors for output
RED := \033[31m
GREEN := \033[32m
YELLOW := \033[33m
BLUE := \033[34m
RESET := \033[0m

help: ## Show this help message
	@echo "$(BLUE)FastAPI Application - Available Commands$(RESET)"
	@echo ""
	@echo "$(YELLOW)Development:$(RESET)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-15s$(RESET) %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo "$(YELLOW)Examples:$(RESET)"
	@echo "  $(GREEN)make dev-setup$(RESET)  # Check uv installation"
	@echo "  $(GREEN)make dev-run$(RESET)    # Start development server"
	@echo "  $(GREEN)make dev-test$(RESET)   # Test all endpoints"

# Development commands
dev-setup: ## Check uv installation and environment
	@echo "$(BLUE)Checking development environment...$(RESET)"
	@if command -v uv >/dev/null 2>&1; then \
		echo "$(GREEN)✓ uv is installed$(RESET)"; \
		echo "$(GREEN)✅ Ready for development$(RESET)"; \
		echo "$(BLUE)Run with: make dev-run$(RESET)"; \
	else \
		echo "$(RED)❌ uv is required. Install with: curl -LsSf https://astral.sh/uv/install.sh | sh$(RESET)"; \
		exit 1; \
	fi

dev-run: ## Run FastAPI app locally with hot reload
	@echo "$(BLUE)Starting FastAPI development server...$(RESET)"
	@echo "$(YELLOW)Server will be available at: http://127.0.0.1:8000$(RESET)"
	@echo "$(YELLOW)API docs available at: http://127.0.0.1:8000/docs$(RESET)"
	uv run --no-project --with "fastapi[standard]" fastapi dev main.py

dev-test: ## Test all local endpoints
	@echo "$(BLUE)Testing local API endpoints...$(RESET)"
	@BASE_URL="http://localhost:8000"; \
	echo "$(YELLOW)Testing: $$BASE_URL$(RESET)"; \
	FAILED=0; \
	curl -s -f "$$BASE_URL/health" && echo "$(GREEN)✅ Health check passed$(RESET)" || { echo "$(RED)❌ Health check failed$(RESET)"; FAILED=1; }; \
	curl -s -f "$$BASE_URL/v1/hello" && echo "$(GREEN)✅ V1 hello passed$(RESET)" || { echo "$(RED)❌ V1 hello failed$(RESET)"; FAILED=1; }; \
	curl -s -f "$$BASE_URL/v2/hello" && echo "$(GREEN)✅ V2 hello passed$(RESET)" || { echo "$(RED)❌ V2 hello failed$(RESET)"; FAILED=1; }; \
	curl -s -f "$$BASE_URL/v1/hello?name=Test" && echo "$(GREEN)✅ V1 with parameter passed$(RESET)" || { echo "$(RED)❌ V1 with parameter failed$(RESET)"; FAILED=1; }; \
	curl -s -f "$$BASE_URL/v2/hello?name=Test&greeting=Hi" && echo "$(GREEN)✅ V2 with parameters passed$(RESET)" || { echo "$(RED)❌ V2 with parameters failed$(RESET)"; FAILED=1; }; \
	if [ $$FAILED -eq 0 ]; then \
		echo "$(GREEN)✅ All endpoints working$(RESET)"; \
	else \
		echo "$(RED)❌ Some endpoints failed. Is the server running? Try: make dev-run$(RESET)"; \
	fi; \
	echo "$(BLUE)Local testing complete$(RESET)"

dev-clean: ## Clean development environment
	@echo "$(BLUE)Cleaning development environment...$(RESET)"
	rm -rf __pycache__
	rm -rf *.egg-info
	rm -rf .pytest_cache
	rm -rf .coverage
	@echo "$(GREEN)✅ Development environment cleaned$(RESET)"

# Code quality commands
lint: ## Run code linting (requires dev dependencies)
	@echo "$(BLUE)Running code linting...$(RESET)"
	uv run --no-project --with "ruff" ruff check main.py
	@echo "$(GREEN)✅ Linting complete$(RESET)"

format: ## Format code (requires dev dependencies)
	@echo "$(BLUE)Formatting code...$(RESET)"
	uv run --no-project --with "ruff" ruff format main.py
	@echo "$(GREEN)✅ Code formatted$(RESET)"

test-unit: ## Run unit tests (when tests exist)
	@echo "$(BLUE)Running unit tests...$(RESET)"
	@echo "$(YELLOW)No tests implemented yet. Add tests to enable this command.$(RESET)"