resource "aws_iam_role" "codepipeline_role" {
  name               = var.codepipeline_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = var.codepipeline_policy_name 
  role   = aws_iam_role.codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

resource "aws_s3_bucket" "artifact_store" {
  bucket = var.artifact_store_s3_bucket
}

resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_pab" {
  bucket = aws_s3_bucket.artifact_store.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_codepipeline" "main_codepipeline" {
  name     = var.aws_codepipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn
  artifact_store {
    location = aws_s3_bucket.artifact_store.bucket
    type     = "S3"
  }
  tags = var.tags
  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = var.codestar_source_connection_arn
        FullRepositoryId = var.FullRepositoryId
        BranchName       = var.source_branch
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"
      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "DeployToECS"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"
      configuration = {
        ClusterName = aws_ecs_cluster.cluster.name
        ServiceName = aws_ecs_service.service.name
        FileName    = "imagedefinitions.json"
      }
    }
  }
  depends_on = [ 
    aws_codebuild_project.codebuild_project,
    aws_ecs_cluster.cluster,
    aws_ecs_service.service,
    aws_lb_target_group.target_group,
    aws_lb_listener.listener,
    aws_iam_role_policy.codepipeline_policy,
   ]
}









