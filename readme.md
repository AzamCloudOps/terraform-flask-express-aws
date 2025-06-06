# DevOps Project: Deploy Flask and Express Applications using Terraform on AWS

This project demonstrates three different deployment strategies for a Flask backend and an Express frontend using Terraform and AWS services.

---

## 📦 Part 1: Deploy Both Flask and Express on a Single EC2 Instance

### Objective:
Deploy both the Flask backend and the Express frontend on a single EC2 instance using Terraform.

### Steps:

1. **Create Terraform Configuration:**
   - Write `main.tf`, `variables.tf`, `outputs.tf`, and `terraform.tfvars`.

2. **Provision a Single EC2 Instance:**
   - Use Terraform to launch one EC2 instance.

3. **Use `user_data.sh`:**
   - Install Python, Node.js, and required libraries using user data script.
   - Clone or copy Flask and Express code to instance.

4. **Start Applications:**
   - Flask app runs on port `5000`.
   - Express app runs on port `3000`.

5. **Access Applications:**
   - Use the public IP of the instance.
   - Visit `http://<public-ip>:5000` for Flask.
   - Visit `http://<public-ip>:3000` for Express.

---

## 🖥️ Part 2: Deploy Flask and Express on Separate EC2 Instances

### Objective:
Deploy Flask backend and Express frontend on separate EC2 instances using Terraform.

### Steps:

1. **Define Infrastructure in Terraform:**
   - Write `main.tf`, `variables.tf`, `output.tf`.
   - Configure two EC2 instances.

2. **Create User Data Scripts:**
   - Use `flask.sh` for backend instance.
   - Use `express.sh` for frontend instance.

3. **Networking:**
   - Create a VPC, Subnet, Internet Gateway.
   - Define security groups to allow communication and internet access.

4. **Application Ports:**
   - Flask on port `5000`.
   - Express on port `3000`.

5. **Test Access:**
   - Access Flask and Express using their respective instance public IPs.

---

## 🐳 Part 3: Deploy Flask and Express Using Docker + ECS + ECR + ALB

### Objective:
Deploy Flask and Express as Docker containers using AWS ECS, ECR, VPC, and ALB through Terraform.

### Steps:

1. **ECR Repositories:**
   - Use Terraform to create ECR repositories.
   - Build Docker images locally.
   - Push images to ECR using Docker CLI.

2. **Define VPC and Networking:**
   - Create VPC, public subnets, route tables, and internet gateway.
   - Define security groups for ECS and ALB.

3. **ECS Cluster Setup:**
   - Create ECS Cluster using Terraform.

4. **ECS Services and Task Definitions:**
   - Create task definitions for both Flask and Express.
   - Define services using Fargate.

5. **Application Load Balancer (ALB):**
   - Create ALB with target groups.
   - Setup listeners to forward traffic to Flask and Express containers.

6. **Outputs:**
   - ALB DNS to access the frontend and backend services.

7. **Access Application:**
   - Open ALB DNS in browser to access applications.

---
