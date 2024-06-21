# Terraform AWS Infrastructure Provisioning  

Terraform has been used to provison AWS 3 tier infrastructure in a VPC with specific CIDR range with 2 public and a private subnets, a load balancer enabled with s3 storage based access logs storage with s3 bucket and autoscaling group with IAM instance profile to access s3 buckets. The step auto scaling group integrated cloudwatch alarm enabled with scaleup and scaledown policies.

The three tier architectured infrastructure is provided with app tier, db tier and web tier EC2 instances respectively. Private subnets and public subnets are mapped with private and public route tables respectively. App instances will get update from internet via NAT gateway attached to private route table and communication to private instance is only possible within VPC from specific CIDR range of IPs via SSH protocol. The public instance are mapped to load balancer with health check enabled in two public subnets.

The public subnet group is mapped with security group that allows only incoming traffic from loadbalancer and a login on port 22 for specific range of IPs.

One of the public instances has been enabled to access s3 buckets with certain IAM role attached with custom policy for accessing loadbalancer access-logs stored in s3 bucket. And the s3 bucket has been configured to allow put objects permissions if and only if principle account is loadbalancer.

## Prerequisites and Usage:
Terraform 1.1.7
AWS-CLI 2.15.22
OpenSSH.

## Usage:
Configure aws credentials by using AWS CLI i.e., execute **aws configure**.
Generate ssh key using Openssh, exeute **ssh-keygen** to generate ssh keys.
Add public key to public_key.txt file to generate key pair required to connect EC2 instances.
Initiate project with **tearraform init**.


