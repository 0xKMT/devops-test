# This module creates an AWS ECR repository with optional encryption and scanning configurations.
# The ECR repository is used to store Docker images for ECS tasks and services.
resource "aws_ecr_repository" "ecr" {
  name                 = var.ecr_name
  image_tag_mutability = var.ecr_tag_mutability # "MUTABLE" or "IMMUTABLE"
  encryption_configuration {
    encryption_type = var.ecr_encryption_type # "AES256" or "KMS"
  }
  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }
  tags = var.tags
}