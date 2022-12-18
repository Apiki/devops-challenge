resource "aws_iam_role" "asg-role" {
  name               = "${var.environment}-role-asg-${var.region}"
  assume_role_policy = file("${path.module}/json/role_asg.json")
}

resource "aws_iam_policy" "policy" {
  name   = "${var.environment}-policy-asg-${var.region}"
  policy = file("${path.module}/json/policy_asg.json")
}

resource "aws_iam_role_policy_attachment" "attach-role" {
  role       = aws_iam_role.asg-role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "asg-profile" {
  name = "${var.environment}-profile-asg-${var.region}"
  role = aws_iam_role.asg-role.name
}
