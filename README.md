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
In production, there is need to add a NAT Gatway, to enable the infrastructures deployed in the private subnet to have access to internet, for updates
