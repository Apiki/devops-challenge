//Create Role to Task Definition with Inline Policy to SSM
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.environment}-role-task-${var.region}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json

  inline_policy {
    name = "ecs-task-permissions"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "ssm:*"
          ]
          Effect   = "Allow"
          Resource = "*"
        }
      ]
    })
  }
}
