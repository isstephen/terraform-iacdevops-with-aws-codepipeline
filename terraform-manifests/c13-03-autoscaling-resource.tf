# Autoscaling Group Resource
resource "aws_autoscaling_group" "my_asg" {
  #name_prefix = "myasg-"
  name_prefix = "${local.name}-"
  desired_capacity = 2
  max_size = 10
  min_size = 2
  vpc_zone_identifier = module.vpc.private_subnets
  target_group_arns = [module.alb.target_groups["mytg1"].arn, module.alb.target_groups["mytg2"].arn]
  health_check_type = "EC2"
  #health_check_grace_period = 300 default is 300 seconds
  launch_template {
    id = aws_launch_template.my_launch_template.id
    version = aws_launch_template.my_launch_template.latest_version
  }
  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      # instance_warmup = "300" Default behaviour is to use the auto scaling groups health check default value
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"] # you can add any argument from ASG here
  }
  tag {
    key = "Owners"
    value = "Web_Team"
    propagate_at_launch = true
  }
}