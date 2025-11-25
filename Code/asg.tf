# Create an Auto Scaling Group (ASG) for EC2 instances
resource "aws_autoscaling_group" "app_asg" {
  name                      = "app-asg"                     # Name of the Auto Scaling Group
  desired_capacity          = 2                             # Number of instances to maintain by default
  min_size                  = 1                             # Minimum number of instances allowed
  max_size                  = 4                             # Maximum number of instances allowed

  # Launch template configuration for EC2 instances
  launch_template {
    id      = aws_launch_template.app_template.id           # ID of the launch template to use
    version = "$Latest"                                     # Use the latest version of the template $Default means default version
  }

  vpc_zone_identifier       = [aws_subnet.public1.id, aws_subnet.public2.id] # Subnets where instances will launch
  target_group_arns         = [aws_lb_target_group.app_tg.arn]               # Attach ASG to ALB target group for load balancing
}



# Auto Scaling Policy to track CPU utilization and scale dynamically
resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "cpu-target-tracking"              # Name of the scaling policy
  policy_type            = "TargetTrackingScaling"            # Policy type: Target Tracking , predictive , schedule 
  autoscaling_group_name = aws_autoscaling_group.app_asg.name # Link policy to the ASG

  # Target tracking configuration for CPU utilization
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"   # Metric to monitor: Average CPU utilization of ASG
    }
    target_value = 50.0                                     # Desired CPU utilization percentage (scale up/down to maintain ~50%)
  }
}


































resource "aws_autoscaling_group" "app_asg" {
  name                      = "app-asg"
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 4
  launch_template {
    id      = aws_launch_template.app_template.id
    version = "$Latest"
  }
  vpc_zone_identifier       = [aws_subnet.public1.id, aws_subnet.public2.id]
  target_group_arns         = [aws_lb_target_group.app_tg.arn]
}

# track the cpu if cpu > 50% or cpu < 50%

resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "cpu-target-tracking"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0  # Keep CPU around 50%
  }
}