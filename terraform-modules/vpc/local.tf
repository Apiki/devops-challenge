locals {
  common_tags = {
    Service     = var.service,
    Environment = var.environment
  }
  name_prefix = "${var.service}-${var.environment}"
}
