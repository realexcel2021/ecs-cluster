variable "repository_name" {
}

variable "image_tag_mutability" {
    type = string
    default = "IMMUTABLE"
}

variable "encrypt_type"{
    type = string
    default = "KMS"
}