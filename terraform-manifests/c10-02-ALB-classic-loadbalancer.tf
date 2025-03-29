module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.13.0"

  name = "${local.name}-alb"
  load_balancer_type = "application"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  enable_deletion_protection = false

  # Security Group
  security_groups = [module.loadbalancer_sg.security_group_id]
  tags = local.common_tags
  
  # Listeners
  listeners = {
    # Listener-1: my-http-https-redirect
    my-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }

    # Listener-2: my-https-listener
    my-https-listener = {
      port                        = 443
      protocol                    = "HTTPS"
      ssl_policy                  = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn             = module.acm.acm_certificate_arn

       # Fixed Response for Root Context 
       fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }# End of Fixed Response

      # Load Balancer Rules
      rules = {

        # Rule-1: myapp1-rule
        myapp1-rule = {
          priority = 1
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "mytg1"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/app1*"]
            }
          }]
        }# End of myapp1-rule

        # Rule-2: myapp2-rule
        myapp2-rule = {
          priority = 2
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "mytg2"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
                values =  ["/app2*"]
            }
          }]
        }# End of myapp2-rule Block

        # Rule-3: myapp3-rule
        myapp3-rule = {
          priority = 3
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "mytg3"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
                values =  ["/*"]
            }
          }]
        }

      }# End Rules Block
    }# End my-https-listener Block
  }# End Listeners Block
  

  # Target Groups 
  target_groups = {
    # TG1
    mytg1 = {
      # VERY IMPORTANT: We will create aws_lb_target_group_attachment resource separately when we use create_attachment = false, refer above GitHub issue URL.
      ## Github ISSUE: https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316
      ## Search for "create_attachment" to jump to that Github issue solution
      create_attachment = false
      name_prefix                       = "mytg1-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }
      protocol_version = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      #port             = 80
      tags = local.common_tags
    }# End of Target Group: mytg1

    # TG2
    mytg2 = {
      # VERY IMPORTANT: We will create aws_lb_target_group_attachment resource separately when we use create_attachment = false, refer above GitHub issue URL.
      ## Github ISSUE: https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316
      ## Search for "create_attachment" to jump to that Github issue solution
      create_attachment = false
      name_prefix                       = "mytg2-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }
      protocol_version = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      #port             = 80
      tags = local.common_tags
    }# End of Target Group: mytg2


    # TG3
    mytg3 = {
      # VERY IMPORTANT: We will create aws_lb_target_group_attachment resource separately when we use create_attachment = false, refer above GitHub issue URL.
      ## Github ISSUE: https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316
      ## Search for "create_attachment" to jump to that Github issue solution
      create_attachment = false
      name_prefix                       = "mytg3-"
      protocol                          = "HTTP"
      port                              = 8080
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }
      protocol_version = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/login"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      #port             = 80
      tags = local.common_tags
    }# End of Target Group: mytg2
  }# End of Target Group
}# End of Load Balancer  

# mytg1: Load Balancer Target Group Attachment
resource "aws_lb_target_group_attachment" "mytg1" {
  for_each = {for k, v in module.ec2-private-app1: k => v}
  target_group_arn = module.alb.target_groups["mytg1"].arn
  target_id        = each.value.id
  port             = 80
}

# mytg2: Load Balancer Target Group Attachment
resource "aws_lb_target_group_attachment" "mytg2" {
  for_each = {for k, v in module.ec2-private-app2: k => v}
  target_group_arn = module.alb.target_groups["mytg2"].arn
  target_id        = each.value.id
  port             = 80
}
# k = ec2_instance
# v = ec2_instance_details

# mytg3: Load Balancer Target Group Attachment
resource "aws_lb_target_group_attachment" "mytg3" {
  for_each = {for k, v in module.ec2-private-app3: k => v}
  target_group_arn = module.alb.target_groups["mytg3"].arn
  target_id        = each.value.id
  port             = 8080
}

## Temp APP Outputs
output "zz_ec2_private_app1" {
  value = {for ec2_instance, ec2_instance_details in module.ec2-private-app1: ec2_instance => ec2_instance_details} 
}
output "zz_ec2_private_app2" {
  value = {for ec2_instance, ec2_instance_details in module.ec2-private-app2: ec2_instance => ec2_instance_details} 
}
