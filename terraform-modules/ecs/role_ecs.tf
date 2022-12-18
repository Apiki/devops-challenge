resource "aws_iam_role" "ecsrole" {
  name               = "${var.environment}-role-ecs-${var.region}"
  assume_role_policy = file("${path.module}/json/role_ecs.json")
}

resource "aws_iam_policy" "ecspolicy" {
  name   = "${var.environment}-policy-ecs-${var.region}"
  policy = file("${path.module}/json/policy_ecs.json")
}

resource "aws_iam_role_policy_attachment" "ecs-attach" {
  role       = aws_iam_role.ecsrole.name
  policy_arn = aws_iam_policy.ecspolicy.arn
}

resource "aws_iam_instance_profile" "ecs_profile" {
  name = "${var.environment}-profile-ecs-${var.region}"
  role = aws_iam_role.ecsrole.name
}
