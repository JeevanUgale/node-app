# DevOps Design Report

## Architecture Overview

Node.js app deployed using Kubernetes and Docker.

---

## Design Decisions

### Node.js

Chosen due to simplicity and fast startup.

### Docker Multi-Stage

Reduces image size and improves security.

### Jenkins

Provides flexible CI/CD automation.

### Terraform

Ensures infrastructure reproducibility.

### Kubernetes

Handles scaling and orchestration.

### Prometheus + Grafana

Industry standard monitoring stack.


---

## Security

Trivy used to scan Docker images.

---

## Architecture

Jenkins Pipeline: NodeJS App Deployment with Terraform, Docker, Kubernetes, and Monitoring

┌───────────────────────────┐
│        Agent: any         │
│ Tools: NodeJS ("node")    │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│     Environment Setup     │
│ IMAGE_NAME = jeevanugale/nodejs-app │
│ TAG = BUILD_NUMBER        │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│      AWS Configure        │
│ - Configure AWS CLI       │
│   with aws_access_key &   │
│   aws_secret_access_key   │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ Generate SSH Key for EC2  │
│ - ssh-keygen in Iac dir   │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ Terraform Init & Validate │
│ - terraform init          │
│ - terraform validate      │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│      Terraform Plan       │
│ - terraform plan -out=tfplan │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│      Terraform Apply      │
│ - terraform apply tfplan  │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│        Run Test           │
│ - npm install             │
│ - npm test                │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│    Build Docker Image     │
│ - docker build $IMAGE_NAME:$TAG │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ Trivy Image Security Scan │
│ - Scan Docker image       │
│ - Output: trivy-report.txt│
│ - Archive report          │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│        Push Image         │
│ - Docker push to registry │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ Deploy to Kubernetes      │
│ - Update deployment.yml   │
│ - kubectl apply all YAMLs │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ Validate Deployment       │
│ - kubectl get all         │
│ - kubectl get ingress     │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│ Deploy Monitoring Stack   │
│ - helm install kube-prom  │
│ - verify all monitoring   │
└───────────────────────────┘
