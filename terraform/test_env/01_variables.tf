###__Common variables__###

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "tags" {
  description = "tags for manage resources"
  type        = map
  default     = {}
}

###__Variables of the ECS security group__###
variable "ecs_sg_name"{
  description = "security group name"
  type        = string
  default     = ""
}

variable "ecs_ingress_cidr"{
  description = "ingress cidr block"
  type        = string
  default     = ""
}

variable "ecs_ingress_protocol"{
  description = "ingress protocol ecs"
  type        = string
  default     = ""
}

variable "ecs_ingress_ports" {
  type = list(object({
    port   = number
    description = string
  }))
  default = [
  ]
}

variable "ecs_egress_cidr"{
  description = "egress cidr block"
  type        = string
  default     = ""
}

variable "ecs_egress_protocol"{
  description = "egress_protocol"
  type        = string
  default     = ""
}

variable "ecs_egress_ports" {
  type = list(object({
    port   = number
    description = string
  }))
  default = [
  ]
}

###__Variables of the devops-test stack__###

variable "ecr_name" {
  description = "The name of the ECR repository"
  type        = string
  default     = ""
}

variable "ecr_tag_mutability" {
  description = "The tag mutability of the ECR repository"
  type        = string
  default     = "" # Options: "MUTABLE" or "IMMUTABLE"
}

variable "ecr_encryption_type" {
  description = "The encryption type for the ECR repository"
  type        = string
  default     = ""
}

variable "ecr_scan_on_push" {
  description = "Whether to scan images on push"
  type        = bool
  default     = true
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "number_of_tasks" {
  description = "Number of tasks to run in the ECS service"
  type        = number
  default     = 1
}

variable "ecs_launch_type" {
  description = "Launch type for the ECS service (e.g., FARGATE, EC2)"
  type        = string
  default     = ""
}

variable "ecs_assign_public_ip" {
  description = "Whether to assign a public IP to the ECS tasks (only for FARGATE launch type)"
  type        = bool
  default     = false
}

variable "container_name" {
  description = "Name of the container in the task definition"
  type        = string
}

variable "container_port" {
  description = "Port on which the container listens"
  type        = number
}

variable "task_definition_family_name" {
  description = "Family name of the ECS task definition"
  type        = string
}

variable "ecs_compatibilities_type" {
  description = "Launch type compatibility for the ECS task definition (e.g., FARGATE, EC2)"
  type        = list(string)
  default     = [""]
}

variable "ecs_network_mode" {
  description = "Network mode for the ECS task definition (e.g., awsvpc, bridge)"
  type        = string
  default     = ""
}

variable "task_cpu" {
  description = "CPU units for the ECS task definition"
  type        = number
}

variable "task_memory" {
  description = "Memory for the ECS task definition"
  type        = number
}

variable "define_container_port" {
  description = "Container port for the ECS task definition"
  type        = number
}

variable "define_host_port" {
  description = "Host port for the ECS task definition"
  type        = number
}

variable "ecs_task_execution_role" {
  description = "IAM role for ECS task execution"
  type        = string
}

variable "ecs_task_execution_policy_arn" {
  description = "Policy ARN for ECS task execution"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

variable "ecs_enable_container_insights" {
  description = "Enable container insights for the ECS cluster"
  type        = string
  default     = "" # Options: "enabled", "disabled", "enhanced"
}

variable "alb_port_listener" {
  description = "Port for the ALB listener"
  type        = number
}

variable "alb_protocol_listener" {
  description = "Protocol for the ALB listener"
  type        = string
}

variable "alb_ssl_policy" {
  description = "SSL policy for the ALB listener"
  type        = string
}

variable "routing_action_type" {
  description = "Routing action type for the ALB listener forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc"
  type        = string
  default     = "forward"
}

variable "tg_name" {
  description = "Name of the target group"
  type        = string
}

variable "tg_type" {
  description = "Target type for the target group (instance, ip, or lambda)"
  type        = string
}

variable "tg_ip_address_type" {
  description = "IP address type for the target group (ipv4 or ipv6)"
  type        = string
  default     = "ipv4"
}

variable "tg_port_alb_listener" {
  description = "Port for the target group"
  type        = number
}

variable "tg_protocol_alb_listener" {
  description = "Protocol for the target group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "tg_protocol_version" {
  description = "Protocol version for the target group (HTTP1, HTTP2, GRPC)"
  type        = string
}

variable "tg_health_check_enabled" {
  description = "Enable health check for the target group"
  type        = bool
}

variable "tg_healthy_threshold" {
  description = "Number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
}

variable "tg_unhealthy_threshold" {
  description = "Number of consecutive health check failures required before considering a healthy target unhealthy"
  type        = number
}

variable "tg_timeout" {
  description = "Timeout for the health check in seconds"
  type        = number
}

variable "tg_interval" {
  description = "Interval between health checks in seconds"
  type        = number
}

variable "tg_matcher" {
  description = "HTTP status codes to use when checking for a successful response from a target"
  type        = string
}

variable "tg_health_check_path" {
  description = "Path to ping for health check"
  type        = string
}

variable "tg_health_check_port" {
  description = "Port to ping for health check"
  type        = number
}

variable "tg_health_check_protocol" {
  description = "Protocol to use for health check (HTTP, HTTPS, TCP)"
  type        = string
}

variable "tg_stickiness_enabled" {
  description = "Enable stickiness for the target group"
  type        = bool
}

variable "tg_stickiness_type" {
  description = "Type of stickiness for the target group (lb_cookie, app_cookie)"
  type        = string
  # default     = "lb_cookie"
}

variable "tg_cookie_duration" {
  description = "Duration of the cookie in seconds"
  type        = number
  # default     = 86400 # 1 day
}

variable "codebuild_role_name" {
  description = "Name of the CodeBuild role"
  type        = string
}

variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  type        = string  
}

variable "source_provider" {
  description = "Type of repository that contains the source code"
  type        = string  
}

variable "source_repo" {
  description = "Source repository to build on CodeBuild"
  type        = string  
}

variable "FullRepositoryId" {
  description = "Source repository to build on CodeBuild"
  type        = string  
}

variable "source_branch" {
  description = "Branch of the source repository to build on CodeBuild"
  type        = string  
  default     = "main"
}

variable "buildspec" {
  description = "Build specification to use for this build project's related builds"
  type        = string  
  default     = "buildspec.yml"
}

variable "compute_type" {
  description = "Compute type for the build environment"
  type        = string  
}

variable "image" {
  description = "Docker image for the build environment"
  type        = string  
}

variable "type" {
  description = "Type of build environment"
  type        = string  
}

variable "privileged_mode" {
  description = "Whether to enable privileged mode for the build environment"
  type        = bool  
  default     = true
}

variable "aws_codepipeline_name" {
  description = "Name of the AWS CodePipeline"
  type        = string  
}

variable "codepipeline_role_name" {
  description = "Name of the CodePipeline role"
  type        = string  
}

variable "codepipeline_policy_name" {
  description = "Name of the CodePipeline policy"
  type        = string  
}

variable "artifact_store_s3_bucket" {
  description = "Name of the S3 bucket for the artifact store"
  type = string
}

variable "codestar_source_connection_arn" {
  description = "The ARN of the CodeStar connection to use for the source action"
  type = string
}

variable "codebuild_policy_name" {
  description = "Name of the CodeBuild policy"
  type        = string
}