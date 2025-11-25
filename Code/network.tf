# Create a VPC - mx-16 min-28(16ip)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"        # IP range for the VPC - 65356
  tags = {
    Name = "main-vpc"               # Tag for identification
  }
}

# Create an Internet Gateway for public internet access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id          # Attach IGW to the VPC
  tags = {
    Name = "main-igw"               # Tag for identification
  }
}

# Create Public Subnet 1
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id          # VPC association
  cidr_block              = "10.0.1.0/24"            # IP range for subnet - 256
  availability_zone       = "eu-north-1a"            # AZ for subnet
  map_public_ip_on_launch = true                     # Assign public IP to instances
  tags = {
    Name = "public-subnet-1"                         # Tag for identification
  }
}

# Create Public Subnet 2
resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id          # VPC association
  cidr_block              = "10.0.2.0/24"            # IP range for subnet
  availability_zone       = "eu-north-1b"            # AZ for subnet
  map_public_ip_on_launch = true                     # Assign public IP to instances
  tags = {
    Name = "public-subnet-2"                         # Tag for identification
  }
}

# Create a Public Route Table
resource "aws_route_table" "public_rt" {             # set of rule , snd n/w traffic to dest ip add
  vpc_id = aws_vpc.main.id                           # Associate route table with VPC
  tags = {
    Name = "public-rt"                               # Tag for identification
  }
}

# Connect pub route table to Internet gateway
resource "aws_route" "public_internet_access" {  

  route_table_id         = aws_route_table.public_rt.id # Route table association
  destination_cidr_block = "0.0.0.0/0"                  # Route all traffic
  gateway_id             = aws_internet_gateway.igw.id  # Use IGW for internet access
}

# Associate route table with Public Subnet 1
resource "aws_route_table_association" "public_assoc1" {
  subnet_id      = aws_subnet.public1.id                # Subnet association
  route_table_id = aws_route_table.public_rt.id         # Route table association
}

# Associate route table with Public Subnet 2
resource "aws_route_table_association" "public_assoc2" {
  subnet_id      = aws_subnet.public2.id                # Subnet association
  route_table_id = aws_route_table.public_rt.id         # Route table association
}



































# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-igw"
  }
}

# Public Subnet 1
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"   
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true  # true- public ip
  tags = {
    Name = "public-subnet-1"
  }
}

# Public Subnet 2
resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "public-rt"
  }
}

# Route to Internet
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate route table with public subnets
resource "aws_route_table_association" "public_assoc1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_rt.id
}


















/* 

Scenario 1:
Your EC2 instance in a public subnet cannot access the internet. What steps will you check?

IGW attached?
Route table has 0.0.0.0/0 route?
Security group allows outbound traffic?
Public IP assigned?  the ans is public ip assigng or not beco launch map public ip = true means pubic ip assigned


Single-line answer:
If map_public_ip_on_launch = true, the instance gets a public IP automatically; if false, it won’t unless you assign one manually.


Scenario 2:
You need high availability for your application. How will you modify this code?

Add more subnets in different AZs.
Attach a Load Balancer.
Use Auto Scaling Group.


Add subnets in multiple Availability Zones, attach an ALB,
and ensure the Auto Scaling Group spans those subnets for true high availability.

Scenario 3:
How would you make this infrastructure private (no internet access)?

Remove IGW and public route.
Use NAT Gateway for private subnets.

Remove IGW and public route; use NAT Gateway for private subnets if outbound internet is needed.




 /*