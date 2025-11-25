# Variable Block

variable "launch_template_name_prefix" {
  description = "Prefix for the launch template name"
  type        = string
  default     = "app-template"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI ID"
  type        = string
  default     = "ami-0c7d68785ec07306c"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "manoi"
}