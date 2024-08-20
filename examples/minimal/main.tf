module "grafana" {
  source = "../../"

  vpc_id       = var.vpc_id
  cluster_name = var.cluster_name

  # ECS Service
  service_subnet_ids = var.service_subnet_ids

  # ALB
  alb_subnet_ids = var.alb_subnet_ids

  # ACM
  acm_grafana_domain_name = var.acm_grafana_domain_name
  acm_record_zone_id      = var.acm_record_zone_id

  # RDS
  rds_db_subnet_group_subnet_ids = var.rds_db_subnet_group_subnet_ids
}
