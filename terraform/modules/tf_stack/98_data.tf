data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"
    resources = [
      aws_s3_bucket.artifact_store.arn,
      "${aws_s3_bucket.artifact_store.arn}/*"
    ]
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]    
  }

  statement {
    effect    = "Allow"
    actions   = ["codestar-connections:UseConnection"]
    resources = [var.codestar_source_connection_arn]
  }

  statement {
    effect = "Allow"
    resources = ["*"]
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:*"
    ]
    resources = ["*"]   
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = ["*"] 
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms"
    ]
    resources = ["*"] 
  }

  statement {
    effect = "Allow"
    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision"
    ]
    resources = ["*"] 
  }
}

