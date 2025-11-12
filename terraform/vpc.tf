# Usar a VPC default da conta
# VPC default existente
data "aws_vpc" "existing" {
  id = "vpc-029793f5cea0c777d" # sua VPC default
}

# Subnets públicas da VPC default (filtra só 2 em AZs diferentes)
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
}

# Escolher apenas 2 subnets em zonas diferentes
locals {
  selected_subnets = slice(data.aws_subnets.public.ids, 0, 2)
}
