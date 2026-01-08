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
