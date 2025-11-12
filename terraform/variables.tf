variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project" {
  type    = string
  default = "minha-api"
}

variable "db_username" {
  type    = string
  default = "dbuser"
}

variable "db_password" {
  type        = string
  description = "Senha do banco (sensitive)"
  sensitive   = true
}

variable "app_port" {
  type    = number
  default = 3000
}

variable "image_uri" {
  type        = string
  description = "URI da imagem Docker (ECR) ex: <account>.dkr.ecr.us-east-1.amazonaws.com/minha-api:tag"
  default     = "772012827208.dkr.ecr.us-east-1.amazonaws.com/minha-api:latest"
}
