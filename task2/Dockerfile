# Use a slim Python image for faster builds and smaller size
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy only requirements first to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code (app.py and any other files in task2/)
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Run the application using uvicorn
# "app:app" refers to: [filename without .py] : [FastAPI instance name]
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
