resource "aws_iam_role" "codebuild_role" {
  name = var.codebuild_role_name
  assume_role_policy = data.aws_iam_policy_document.codebuild_policy.json
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = var.codebuild_policy_name
  role = aws_iam_role.codebuild_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetObjectVersion",
          "s3:GetBucketAcl",
          "s3:GetBucketLocation",
          "s3:ListBucket"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codebuild:BatchGetProjects"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_codebuild_project" "codebuild_project" {
  name          = var.codebuild_project_name
  service_role  = aws_iam_role.codebuild_role.arn
  source {
    type      =  var.source_provider #"GITHUB"
    # location  =  var.source_repo
    # buildspec =  var.buildspec 
  }
  source_version = var.source_branch #"main"
  environment {
    compute_type                = var.compute_type
    image                       = var.image 
    type                        = var.type 
    privileged_mode             = var.privileged_mode
  }
  artifacts {
    type = "CODEPIPELINE"
  }
  tags = var.tags
}
