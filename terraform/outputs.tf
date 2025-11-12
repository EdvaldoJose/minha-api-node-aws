output "ecr_repo_url" {
  value = aws_ecr_repository.repo.repository_url
}

output "ecs_cluster" {
  value = aws_ecs_cluster.cluster.name
}

output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}
