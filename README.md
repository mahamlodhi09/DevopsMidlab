# DevOps Lab – Terminal Project

## Maham Lodhi - FA22-BCS-167  
## Laiba Maqsood - FA22-BCS-124  

## 1. Running Locally

### Using Docker Compose (App)
docker-compose up -d

**Services included:**
- App (Django / Flask / TodoApp)
- Database (PostgreSQL)
- Cache / Queue (Redis)

**Access the app at:** [http://localhost:8080](http://localhost:8080)

---

### Using Kubernetes (Minikube)
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

**Verify pods:**
kubectl get pods -n dev

**Verify services:**
kubectl get svc -n dev

---

### Using Monitoring Stack
cd monitoring
docker-compose up -d

**Access dashboards:**
- Prometheus: [http://localhost:9090](http://localhost:9090)
- Grafana: [http://localhost:3000](http://localhost:3000)  
  *(Username: admin / Password: admin)*

---

## 2. Infrastructure Setup & Teardown

### Setup (AWS)
**Terraform files located in:** `infra/`

Run the following commands:
terraform init
terraform plan
terraform apply

**Provisions:**
- VPC + Subnets + Security Groups  
- RDS/PostgreSQL or S3 Bucket  
- EKS Cluster  

### Teardown
terraform destroy
Cleans all AWS resources.

---

## 3. Notes
- Docker images are pushed to Docker Hub.  
- Secrets are **not hard-coded**:
  - Environment variables for app configs  
  - GitHub secrets for Docker Hub credentials  
  - AWS credentials managed securely by the group  
- CI/CD pipeline handled via **GitHub Actions**.
- added aws secrets