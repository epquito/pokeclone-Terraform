module "VPC" {
    source = "./VPC"
    vpc_cidr_block = var.vpc_cidr_block
    vpc_name = var.vpc_name
    private_subnet1_cidr_block = var.private_subnet1_cidr_block
    private_subnet1_az = var.private_subnet1_az
    private_subnet2_cidr_block = var.private_subnet2_cidr_block
    private_subnet2_az = var.private_subnet2_az
    public_subnet1_cidr_block = var.public_subnet1_cidr_block
    public_subnet1_az = var.public_subnet1_az
    public_subnet2_cidr_block = var.public_subnet2_cidr_block
    public_subnet2_az = var.public_subnet2_az
    internet_gateway_name = var.internet_gateway_name
    nat_gateway_eip_name = var.nat_gateway_eip_name
    nat_gateway_name = var.nat_gateway_name
    private_route_table_name = var.private_route_table_name
    public_route_table_name = var.public_route_table_name
    public_pokemon_acl = var.public_pokemon_acl
    private_pokemon_acl = var.private_pokemon_acl
    public_security_group_name = var.public_security_group_name
    operating_system_ip = var.operating_system_ip
    private_security_group_name = var.private_security_group_name
}

module "RDS" {
    source = "./RDS"
    db_subnet_group_name = var.db_subnet_group_name
    rds_subnet_group_ids = module.VPC.public_subnet_ids
    db_instance_identifier = var.db_instance_identifier
    db_name = var.db_name
    db_username = var.db_username
    db_password = var.db_password
    rds-security_ids = module.VPC.public_security_group
}
module "EKS" {
    source = "./EKS"
    eks_cluster_name = var.eks_cluster_name
    eks_cluster_role_name = var.eks_cluster_role_name
    module_subnet_ids = module.VPC.subnet_ids
    eks_cluster_log_group_name = var.eks_cluster_log_group_name
    eks_cluster_version = var.eks_cluster_version
    cluster_ipv4_range = var.cluster_ipv4_range
    eks_node_group_name =var.eks_node_group_name
    module_public_subnet_ids = module.VPC.public_subnet_ids
    eks_node_group_instance_type = var.eks_node_group_instance_type
    eks_node_group_desired_size = var.eks_node_group_desired_size
    eks_node_group_max_size = var.eks_node_group_max_size
    eks_node_group_min_size = var.eks_node_group_min_size
    eks_node_group_key_name = var.eks_node_group_key_name
    eks_node_group_security_group = module.VPC.public_security_group
    node_group_ami_type = var.node_group_ami_type
    eks_oidc_role_name = var.eks_oidc_role_name
    eks_oidc_policy_name = var.eks_oidc_policy_name
    eks_cluster_autoscaler_role_name = var.eks_cluster_autoscaler_role_name
    eks_cluster_autoscaler_policy_name = var.eks_cluster_autoscaler_policy_name
    eks_csi_driver_role_name = var.eks_csi_driver_role_name
    eks_ebs_csi_add_on_version = var.eks_ebs_csi_add_on_version
}
module "SNS" {
    source = "./SNS"
    sns_topic_name_eventbridge = var.sns_topic_name_eventbridge
    sns_topic_email_eventbridge = var.sns_topic_email_eventbridge
    sns_topic_name_eks = var.sns_topic_name_eks
    sns_subscription_email_EKS = var.sns_subscription_email_EKS
    asg_sns_topic_name = var.asg_sns_topic_name
    asg_sns_subscription_email = var.asg_sns_subscription_email

}
module "EventBridge" {
    source = "./EventBridge"
    iam_role_name = var.iam_role_name
    db_instance_identifier_id = module.RDS.rds_instance_identifier
    eventbridge_db_resource = module.RDS.rds_resource 
}
module "CloudWatch" {
    source = "./CloudWatch"
    cloudwatch_event_rule_name = var.cloudwatch_event_rule_name
    scheduled_expression = module.EventBridge.event_bridge_schedular
    sns_topic_for_event_arn = module.SNS.sns_topic_event_arn
    cloudwatch_dashboard_name = var.cloudwatch_dashboard_name
    aws_region = var.aws_region
    aws_eks_asg_id = module.EKS.full_eks_asg_id
    cloudwatch_alarm_name = var.cloudwatch_alarm_name
    asg_cloudwatch_dashboard_name = var.asg_cloudwatch_dashboard_name
    asg_cloudwatch_alarm_name = var.asg_cloudwatch_alarm_name
    node_line_graph_dashboard_name = var.node_line_graph_dashboard_name
    eks_alarm_topic_arn = module.SNS.sns_topic_EKS_arn
    asg_alarm_topic_arn = module.SNS.sns_topic_ASG_arn

}
