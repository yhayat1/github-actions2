🚀 Exercise: The Ephemeral Microservice Stack
Objective: Deploy a Python API and a PostgreSQL database to a kind Kubernetes cluster within a GitHub Action runner. The exercise is complete only when an automated K8s Job successfully writes data to the database via the API.

📋 Task List
🏗️ Phase 1: Containerization (60 min)
Goal: Turn the provided Python code into a portable Docker image.

[ ] Analyze app.py to identify required Python packages.

[ ] Create a requirements.txt file.

[ ] Write a Dockerfile (Tip: Use a slim base image to save time on the runner).

[ ] Validation: Build the image locally and ensure it starts (it will crash when connecting to the DB, which is expected).

☸️ Phase 2: Helm Charting (90 min)
Goal: Define your infrastructure as code.

[ ] Run helm create my-app and strip out the boilerplate you don't need.

[ ] PostgreSQL Template: Create a Deployment and Service. Use emptyDir for storage.

[ ] Python App Template: Create a Deployment and Service.

[ ] Wiring: Map environment variables in the Python Deployment to match the Postgres Service name and credentials.

[ ] Validation: Use helm template . to ensure your YAML renders without errors.

🤖 Phase 3: The CI Pipeline (45 min)
Goal: Automate the cluster lifecycle.

[ ] Create .github/workflows/main.yml.

[ ] Add a step to create a kind cluster.

[ ] The "Secret Sauce": Add a step to build your image and load it into the Kind cluster so K8s can see it.

[ ] Add a step to helm install your chart.

[ ] Validation: The GitHub Action should run and show all pods in a Running state.

🧪 Phase 4: The Integration Test (45 min)
Goal: Prove the system works.

[ ] Create a test-job.yaml manifest using a curl image.

[ ] The Job must send a JSON POST request to your Python Service.

[ ] Add a final step to your workflow that:

Applies the Job manifest.

Waits for the Job to reach the Complete condition.

[ ] Validation: The GitHub Action turns Green ✅.

🛠️ Technical Constraints
Database: Must use postgres:15-alpine.

Persistence: Use emptyDir: {} (no PVCs required).

Communication: Use K8s internal DNS (Service names), not IP addresses.

Probes: (Optional but recommended) Implement a readinessProbe for the DB so the app doesn't crash on startup.

💡 Troubleshooting Hints
ImagePullBackOff: Did you remember to run kind load docker-image ... before installing the Helm chart?

Connection Refused: Is your Python app listening on 0.0.0.0 or 127.0.0.1? Is your Service targeting the correct containerPort?

Logs: Use kubectl logs deployment/your-app-name in your workflow if things fail to see the Python stack trace.