### Create Scheduled Action-1: Increase Capacity during business hours
resource "aws_autoscaling_schedule" "increase_capacity_9am" {
  scheduled_action_name  = "increase-capacity-9am"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 8
  start_time             = "2030-12-11T18:00:00Z"
  recurrence             = "00 09 * * *"
  autoscaling_group_name = aws_autoscaling_group.my_asg.id
}


### Create Scheduled Action-2: Decrease capacity during non-business hours
resource "aws_autoscaling_schedule" "decrease_capacity_9pm" {
  scheduled_action_name  = "decrease-capacity-9pm"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  start_time             = "2030-12-12T18:00:00Z"
  recurrence             = "00 21 * * *"
  autoscaling_group_name = aws_autoscaling_group.my_asg.id
}

