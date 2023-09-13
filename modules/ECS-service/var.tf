variable "ecs_service_name" {
    type = string
}

variable "ecs_service_cluster" {
  type = string
}

variable "ecs_task_defiantion" {
  type = string
}

variable "ecs_desired_count" {
  type = number
}

variable "ecs_service_iam_role_arn" {
  type = string
}

variable "load_balancer_target_group_arn" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = number
}