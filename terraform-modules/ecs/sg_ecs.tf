//Create Security Group ECS
resource "aws_security_group" "ecs_task" {
  name        = "${var.environment}-sg-ecs-${var.region}"
  description = "Allow communication between the LB and ECS"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.alb.id}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
