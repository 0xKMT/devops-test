
module "ecs_security_group" {
  source  = "../modules/sg_common"
  sg_name = var.ecs_sg_name
  vpc_id  = data.aws_vpc.existing_vpc.id
  ingress_ports = var.ecs_ingress_ports
  ingress_cidr  = var.ecs_ingress_cidr
  ingress_protocol = var.ecs_ingress_protocol
  egress_cidr      = var.ecs_egress_cidr
  egress_ports     = var.ecs_egress_ports
  egress_protocol  = var.ecs_egress_protocol
  tags    = var.tags
}

module "devops_test_stack" {
    source = "../modules/tf_stack"
    tags = var.tags

    ### Variables for the ECR repository
    ecr_name = var.ecr_name
    ecr_tag_mutability = var.ecr_tag_mutability
    ecr_encryption_type = var.ecr_encryption_type
    ecr_scan_on_push = var.ecr_scan_on_push

    ### Variables for the ECS cluster
    ecs_cluster_name = var.ecs_cluster_name
    ecs_enable_container_insights = var.ecs_enable_container_insights # "enabled" or "disabled" or "enhanced"
    ecs_service_name = var.ecs_service_name
    ecs_launch_type = var.ecs_launch_type # "FARGATE"
    number_of_tasks = var.number_of_tasks
    ecs_assign_public_ip = var.ecs_assign_public_ip # true or false
    ecs_subnet_ids = data.aws_subnets.private_subnets.ids #If public, use public subnets; if private, use private subnets
    ecs_security_group_id = [module.ecs_security_group.security_group_id]
    container_name = var.container_name
    container_port = var.container_port
    task_definition_family_name = var.task_definition_family_name
    ecs_compatibilities_type = var.ecs_compatibilities_type
    ecs_network_mode = var.ecs_network_mode # if using Fargate, set to "awsvpc"
    task_cpu = var.task_cpu          # CPU units for the task
    task_memory = var.task_memory       # Memory for the task
    define_container_port = var.define_container_port
    define_host_port = var.define_host_port
    ecs_task_execution_role = var.ecs_task_execution_role  #"ecsTaskExecutionRole"
    ecs_task_execution_policy_arn = var.ecs_task_execution_policy_arn
    
    ### Variables for the target group
    load_balancer_arn = data.aws_lb.existing_lb.arn
    alb_port_listener = var.alb_port_listener
    alb_protocol_listener = var.alb_protocol_listener
    alb_ssl_policy = var.alb_ssl_policy
    certificate_arn = data.aws_acm_certificate.existing_certificate.arn 
    routing_action_type = var.routing_action_type
    tg_name = var.tg_name
    tg_type = var.tg_type
    tg_ip_address_type = var.tg_ip_address_type
    tg_port_alb_listener = var.tg_port_alb_listener
    tg_protocol_alb_listener = var.tg_protocol_alb_listener
    vpc_id = data.aws_vpc.existing_vpc.id
    tg_protocol_version = var.tg_protocol_version
    tg_health_check_enabled = var.tg_health_check_enabled
    tg_healthy_threshold = var.tg_healthy_threshold
    tg_unhealthy_threshold = var.tg_unhealthy_threshold
    tg_timeout = var.tg_timeout
    tg_interval = var.tg_interval
    tg_matcher = var.tg_matcher
    tg_health_check_path = var.tg_health_check_path
    tg_health_check_port = var.tg_health_check_port
    tg_health_check_protocol = var.tg_health_check_protocol
    tg_stickiness_enabled = var.tg_stickiness_enabled
    tg_stickiness_type = var.tg_stickiness_type
    tg_cookie_duration = var.tg_cookie_duration

    ### Variables for the CodeBuild project
    codebuild_role_name = var.codebuild_role_name
    codebuild_project_name = var.codebuild_project_name
    source_provider = var.source_provider
    source_repo = var.source_repo
    buildspec = var.buildspec
    source_branch = var.source_branch
    compute_type = var.compute_type
    image = var.image
    type = var.type
    privileged_mode = var.privileged_mode
    codebuild_policy_name = var.codebuild_policy_name

    ### Variables for the CodePipeline
    codepipeline_role_name = var.codepipeline_role_name
    codestar_source_connection_arn = var.codestar_source_connection_arn
    codepipeline_policy_name = var.codepipeline_policy_name
    artifact_store_s3_bucket = var.artifact_store_s3_bucket
    aws_codepipeline_name = var.aws_codepipeline_name
    FullRepositoryId = var.FullRepositoryId #"my-organization/example"
}