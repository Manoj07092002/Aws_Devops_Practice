

resource "aws_launch_template" "app_template" {
  name_prefix   = var.launch_template_name_prefix
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  # Security group should be a list, so use security_group_ids
  security_group_ids = [aws_security_group.app_sg.id]
}





























# Create a Launch Template for EC2 instances
resource "aws_launch_template" "app_template" { 
  name_prefix   = "app-template"                     # Prefix for the launch template name
  image_id      = "ami-0c7d68785ec07306c"            # Amazon Linux 2 AMI ID (specific to eu-north-1 region)
  instance_type = "t3.micro"                         # EC2 instance type (small, cost-effective)
  key_name      = "manoi"                            # SSH key pair name for instance access
  security_group_id = [aws_security_group.app_sg.id] # (Optional) Security group for the instance
}






































resource "aws_launch_template" "app_template" { 
  name_prefix   = "app-template"
  image_id      = "ami-0c7d68785ec07306c" # Amazon Linux 2 AMI for eu-north-1
  instance_type = "t3.micro"
  key_name      = "manoi" # Replace with your key pair name
  # security_group_id = [aws_security_group.app_sg.id]
}

