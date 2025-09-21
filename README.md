# FastAPI App

## Quick Start

```bash
# Install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# Start development server
make dev-run
```

## API Endpoints

- `GET /health` - Health check
- `GET /v1/hello` - Hello endpoint
- `GET /v1/hello?name=John` - Hello with name parameter

## Development

```bash
make dev-setup    # Check environment
make dev-run      # Start server with hot reload
make dev-test     # Test endpoints
make lint         # Check code quality
make format       # Format code
```

Server runs at: http://127.0.0.1:8000  
API docs at: http://127.0.0.1:8000/docs
