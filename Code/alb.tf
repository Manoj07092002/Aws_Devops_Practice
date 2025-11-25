# Create an Application Load Balancer (ALB)
resource "aws_lb" "app_alb" {
  name               = "app-alb"                # Name of the ALB
  internal           = false                    # ALB is public-facing (requires Internet Gateway)
  load_balancer_type = "application"            # Type of Load Balancer (Application)
  security_groups    = [aws_security_group.alb_sg.id]  # Attach security group for ALB
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id] # ALB spans two public subnets
}

# Create a Target Group for the ALB
resource "aws_lb_target_group" "app_tg" { 
  name     = "app-tg"                           # Name of the Target Group
  port     = 80                                 # Port on which targets receive traffic
  protocol = "HTTP"                             # Protocol used for communication
  vpc_id   = aws_vpc.main.id                    # VPC where the target group resides
}

# Create a Listener for the ALB
resource "aws_lb_listener" "app_listener" {     #listen for traffic on a specific port and protocol 

  load_balancer_arn = aws_lb.app_alb.arn        # ARN of the ALB to attach listener
  port              = 80                        # Listener port (HTTP)
  protocol          = "HTTP"                    # Listener protocol
  default_action {
    type             = "forward"                # Action type: forward traffic
    target_group_arn = aws_lb_target_group.app_tg.arn # Forward traffic to the target group
  }
}





























resource "aws_lb" "app_alb" {
  name               = "app-alb"
  internal           = false    #ALB uses public subnets and needs an Internet Gateway
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public1.id, aws_subnet.public2.id]
}

resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

    health_check {
      path                = "/"               # Endpoint for health check
      protocol            = "HTTP"            # Protocol used for health check
      interval            = 30                # Time (in seconds) between checks
      timeout             = 5                 # Time to wait for a response
      healthy_threshold   = 2                 # Consecutive successes to mark healthy
      unhealthy_threshold = 2                 # Consecutive failures to mark unhealthy
    }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}








