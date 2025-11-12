resource "aws_ecr_repository" "repo" {
  name = var.project
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = { Project = var.project }
}
