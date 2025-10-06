# ☁️ Multi-AZ AWS 3-Tier Web Application Deployment (Terraform)

## 🚀 Overview
This project defines and deploys a secure, highly available 3-Tier Web Application infrastructure across multiple Availability Zones (AZs) in AWS using Terraform.
### 🏗️ Architecture

![S3](https://i.imgur.com/Q55I0hc.png)


The architecture is divided into three logical tiers, each residing in private or public subnets and secured by dedicated Security Groups (SGs).

1. Web Tier (Public): Hosts the Application Load Balancer (ALB) and public-facing network components. The ALB routes traffic to the Web Servers in the Application Tier.

2. Application Tier (Private): Contains the EC2 instances running the application logic (e.g., Python, Node.js, Java). These instances can only be accessed via the ALB or Bastion host for security.

3. Database Tier (Private): Hosts the Amazon RDS instance (or similar managed database). This tier has no direct public internet access, ensuring maximum security for data.

### 🛠️ Technologies Used
Terraform: Infrastructure as Code (IaC) for resource orchestration.

AWS VPC: Configured for Multi-AZ deployment (Public, App, and DB subnets).

Application Load Balancer (ALB): Distributes incoming traffic across the application tier instances.

Amazon EC2: Compute resources for the Application Tier.

Amazon RDS: Managed relational database service (e.g., PostgreSQL or MySQL).

### 📋 Prerequisites
Before deploying this project, ensure you have the following installed and configured:

1. AWS Account: An active AWS account with necessary permissions (VPC, EC2, RDS, IAM).
2. AWS CLI: Configured with valid credentials to allow Terraform to authenticate.
3. Terraform CLI: Installed and ready to execute commands.
4. SSH Key: Your public SSH key must be configured in the AWS region and referenced in the EC2 module for access (if needed).

### 🚀 Deployment
Follow these steps to deploy the full 3-Tier environment:

1. Clone the Repository:
```
-> git clone [https://github.com/MahouTn/aws-flask-gunicorn-terraform.git]
-> cd terraform-files
```


2. Initialize Terraform:
This command downloads the necessary AWS provider plugins.
```
-> terraform init
```



3. Apply the Configuration:
This command will create all the AWS resources defined in the configuration files.

```
-> terraform apply
```


4. Get the Website URL:
After a successful terraform apply, the output will provide the public URL of your new website.
```
-> terraform output "alb_dns_name"
```
Navigate to this URL in your browser to verify the application's availability.

5. Verify the Application in the Browser
Navigate to the Public IP in your web browser to confirm the application is serving the index.html content on Port 80.

![S3](https://i.imgur.com/KQP7wYK.png)
![S3](https://i.imgur.com/EqGETdz.png)

### 🧹 Cleanup
To avoid incurring any costs, you can destroy all the created resources with a single command.
```
-> terraform destroy
```

WARNING: This command is destructive and will terminate the EC2 instances, delete the RDS database, and remove all network infrastructure. All data will be lost.


This will safely terminate the EC2 instance and remove all network infrastructure.

