#Create VPC, subnets, route tables, and security groups.


# Security Group for ALB (Application Load Balancer)
resource "aws_security_group" "alb_sg" { 
  name        = "alb-sg"                                # Name of the security group
  vpc_id      = aws_vpc.main.id                         # Attach SG to the main VPC
  description = "Allow HTTP"                            # Description of SG purpose

  # Inbound rule: Allow HTTP traffic from anywhere
  ingress { 
    from_port   = 80                                    # Start port (HTTP)
    to_port     = 80                                    # End port (HTTP)
    protocol    = "tcp"                                 # Protocol type
    cidr_blocks = ["0.0.0.0/0"]                         # Allow traffic from all IPs (public access)
  }

  # Inbound rule: Allow SSH traffic from anywhere
  ingress {
    from_port   = 22                                    # Start port (SSH)
    to_port     = 22                                    # End port (SSH)
    protocol    = "tcp"                                 # Protocol type
    cidr_blocks = ["0.0.0.0/0"]                         # Allow SSH from all IPs
  }

  # Outbound rule: Allow all traffic to anywhere
  egress { 
    from_port   = 0                                     # Start port
    to_port     = 0                                     # End port
    protocol    = "-1"                                  # All protocols
    cidr_blocks = ["0.0.0.0/0"]                         # Allow outbound to all IPs
  }
}

# Security Group for Application EC2 Instances
resource "aws_security_group" "app_sg" {
  name        = "app-sg"                                # Name of the security group
  vpc_id      = aws_vpc.main.id                         # Attach SG to the main VPC
  description = "Allow SSH and HTTP"                    # Description of SG purpose

  # Inbound rule: Allow SSH traffic from anywhere
  ingress {
    from_port   = 22                                    # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                         # Allow SSH from all IPs
  }

  # Inbound rule: Allow HTTP traffic from anywhere
  ingress {
    from_port   = 80                                    # HTTP port
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                         # Allow HTTP from all IPs
  }

  # Outbound rule: Allow all traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"                                  # All protocols
    cidr_blocks = ["0.0.0.0/0"]                         # Allow outbound to all IPs
  }
}














































resource "aws_security_group" "alb_sg" { #security group - virtual firewalls for EC2 instances
  name        = "alb-sg"
  vpc_id      = aws_vpc.main.id
  description = "Allow HTTP"
  ingress { # inbound rules 
    from_port   = 80  #The starting port of the range.
    to_port     = 80  #ending port range
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #allow traffic from any IP address (public access)
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp" #Allows SSH (port 22)  from anywhere to the application servers 
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress { # outbound rules
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  vpc_id      = aws_vpc.main.id
  description = "Allow SSH and HTTP"  
                                   
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp" #Allows SSH (port 22)  from anywhere to the application servers 
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp" #Allows HTTP traffic (port 80) from anywhere to the ALB and
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # allow all outbound traffic.
    cidr_blocks = ["0.0.0.0/0"]
  }
}                               