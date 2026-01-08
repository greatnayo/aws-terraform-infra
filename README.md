Introduction:
This project uses terraform to provision the following AWS resources :

1. VPC (cidr_block - 10.0.0.0/16)
2. Subnets

- 2 Private Subnets (10.0.101.0/24 & 10.0.102.0/24)
- 2 Public subnets (10.0.1.0/24 & 10.0.2.0/24)

3. An internet Gateway

What problem does this infrastructure solve?
This infrastructure is ideal for a production environment where some services are isolated from public and access while others allow public access. services like database should be deployed in the private subnets. This setup is also supports High availability by making use of 2 AZs. So if one AZ goes down the services can still be reached from the other AZ.

Why this architecture?
This architecture has a lot benefits including high avaliability, scalability, reuseability and security

Security considerations
services that will not be exposed to the public will be deployed in the private subnets thereby making them unreach from the public and hackers.

Cost considerations
this setup does not attract any cost, since the services involved dont charge for deployment, but usage

How to deploy & destroy
To deploy, run terraform Init, terraform plan, terraform apply

To destroy, run terraform destroy

What you would improve in production
In production, there is need to add a NAT Gatway, to enable the infrastructures deployed in the private subnet to have access to internet, for updates and installation of userdata scripts.

4. Application Load Balancers
   Added an application load balancer which sits in the public subnet and acts as the entry point to our server. so the servers which are in the private subnets will be reached through the ALB, this reduces the attack surface of our application. The ALB listens on port 80 and forward all HTTP traffic the the designated target groups.

5. EC2 Instances
   Created EC2 Instances with a custom security group. the instance security group does not allow access via any other means except through the security group of the ALB. this is a good security strategy making it difficult to access the servers directly using ssh or via public IP's. The EC2 target groups are also configured to perform health check to determine the status of the ec2 instances.

This is the current flow of traffic in the Network:

# Traffic Flow Diagram

````mermaid
graph TD
    A[Internet User] -->|HTTP Request| B[Application Load Balancer<br/>Public Subnets<br/>Security Group: alb_sg<br/>Port 80 open to 0.0.0.0/0]
    B -->|Forwards to Target Group| C[Target Group<br/>Port 80]
    C -->|Routes to| D[EC2 Instance<br/>Private Subnet<br/>Security Group: ec2_sg<br/>Port 80 open only from alb_sg]
    D -->|Serves Content| E[Response back through ALB]

    subgraph "VPC (10.0.0.0/16)"
        subgraph "Public Subnets"
            B
        end
        subgraph "Private Subnets"
            D
        end
        F[Internet Gateway] -->|Routes 0.0.0.0/0| B
    end

    style A fill:#e1f5fe
    style B fill:#c8e6c9
    style C fill:#fff3e0
    style D fill:#ffcdd2
    style E fill:#f3e5f5
    style F fill:#e8f5e8
```</content>
<parameter name="filePath">/home/nayo/2026-devops/aws-terraform-infra/traffic_flow_diagram.md
````
