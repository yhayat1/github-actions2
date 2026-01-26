# Stage 1: Base - Install dependencies and copy code
FROM python:3.11-slim as base

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Stage 2: Test - Run unit tests
# If tests fail, the build will stop here
FROM base as test
RUN pytest

# Stage 3: Final - Production-ready image
FROM base as final
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
