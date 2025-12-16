# DevOps Lab Report – Terminal Project

## 1. Technologies Used
- **Docker & Docker Compose** – Containerization and local orchestration  
- **Kubernetes (Minikube / EKS)** – Deployment and orchestration  
- **Ansible** – Configuration management  
- **Terraform** – Infrastructure provisioning  
- **Prometheus & Grafana** – Monitoring and observability  
- **GitHub Actions** – CI/CD pipeline  
- **PostgreSQL & Redis** – Database and cache  

---

## 2. Pipeline & Infrastructure Diagram
- **Pipeline Flow:** Build → Lint/Security → Test → Docker Build → Push → Deploy → Smoke Tests  
- **Infrastructure Components:** VPC, Subnets, EC2/EKS, RDS, Redis, App containers  

---

## 3. Secret Management Strategy
- Docker Hub credentials are stored as **GitHub Secrets**.  
- Application configuration is managed via **`.env` files** (excluded from version control).  
- AWS access keys are securely managed by the designated team member.  
- **No secrets are hard-coded** in the codebase.  

---

## 4. Monitoring Strategy
- **Prometheus** collects metrics from:
  - Application’s `/metrics` endpoint  
  - **Node Exporter** for system metrics (CPU, memory, etc.)  
- **Grafana** visualizes key performance metrics, including:
  - CPU and memory usage  
  - Application request metrics  

---

## 5. Lessons Learned
- **Docker Compose** improves manageability and environment setup.  
- **Ansible** effectively automates server and container configuration.  
- **CI/CD pipelines** streamline build, test, and deployment processes.  
- **Kubernetes** provides scalability and robust service orchestration.  
- **Monitoring tools** enhance visibility into performance and uptime.  
