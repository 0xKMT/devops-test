data "aws_vpc" "existing_vpc" {
  id = var.vpc_id
}

data "aws_subnets" "public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
  filter {
    name   = "tag:Type"
    values = ["public"]  # adjust based on how you tag subnets
  }
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing_vpc.id]
  }
  filter {
    name   = "tag:Type"
    values = ["private"]  # adjust based on how you tag subnets
  }
}

data "aws_lb" "existing_lb" {
  name = "devops-test-alb"
}

data "aws_acm_certificate" "existing_certificate" {
  domain   = "*.labs4aws.click"
  statuses = ["ISSUED"]
  most_recent = true
}
