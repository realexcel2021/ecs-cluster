variable "cidr_block"{
    type = string
    description = "Provide CIDR block for the VPC"
}

variable "region" {
    type = string
    description = "Region for Terraform deployment"
}

variable "ECR-repo-name" {
    description = "Name for the ECR repo"
}

variable "encryption_type" {
    description = "Encryption type for ECR repo (Defaults to KMS)"
}