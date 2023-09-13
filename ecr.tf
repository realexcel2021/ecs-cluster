module "ecr-repo" {
  source = "./module/ECR"
  name = var.ECR-repo-name
  image_tag_mutability = var.ecr-image_tag_mutability
  encryption_type = var.encryption_type
}