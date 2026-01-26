# FastAPI Demo App

This is a simple FastAPI application with unit tests and Docker support.

## Project Structure
```
github-actions2/
├── app/
│   ├── main.py        # FastAPI application
│   └── test_main.py   # Unit tests
├── Dockerfile         # Docker configuration
├── requirements.txt   # Python dependencies
└── README.md          # This file
```

## Local Setup

### 1. Create a Virtual Environment
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### 2. Install Dependencies
```bash
pip install -r requirements.txt
```

### 3. Run the App Locally
```bash
uvicorn app.main:app --reload
```
The app will be available at http://127.0.0.1:8000.
Documentation (Swagger UI) is at http://127.0.0.1:8000/docs.

## Testing Locally

### Run Unit Tests
To run the tests, use `pytest`:
```bash
pytest
```
Note: Make sure you are in the `github-actions2` directory.

## Docker Support (Multi-stage)

The Dockerfile uses a multi-stage build to ensure that tests pass before the final image is created.

### 1. Build and Run Tests
To run tests inside a Docker container:
```bash
docker build --target test -t fastapi-app:test .
```

### 2. Build the Final Production Image
```bash
docker build -t fastapi-app:latest .
```

### 3. Run the Docker Container
```bash
docker run -p 8000:8000 fastapi-app:latest
```

## GitHub Actions

A workflow is configured in `.github/workflows/main.yml` that:
1. Triggers on changes to the repository.
2. Builds the `test` stage (running `pytest`).
3. Builds the final production image.
4. Pushes the image to GitHub Container Registry (GHCR) on successful tests and push to `main`.
