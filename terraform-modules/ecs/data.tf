#Image ASG
data "aws_ami" "asg-ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.20211120-x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["591542846629"] # ECS
}

#IAM Policy Task Definition
data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_ssm_parameter" "dbhost" {
  name = "/app/wordpress/DATABASE_HOST"
}

data "aws_ssm_parameter" "dbname" {
  name = "/app/wordpress/DATABASE_NAME"
}

data "aws_ssm_parameter" "dbuser" {
  name = "/app/wordpress/DATABASE_MASTER_USERNAME"
}

data "aws_ssm_parameter" "dbpassword" {
  name = "/app/wordpress/DATABASE_MASTER_PASSWORD"
}
