resource "aws_ecs_task_definition" "service" {
  family = var.task_defination_family
  execution_role_arn = var.task_defination_execution_role_arn
  container_definitions = jsonencode([
    {
      name      = var.task_defination_name
      image     = var.task_defination_image
      cpu       = var.task_defiantion_cpu
      memory    = var.task_defination_memory
      essential = true
      portMappings = [
        {
          containerPort = var.task_defination_container_port
          hostPort      = var.task_defination_host_port
        }
      ]
    }
  ])

  volume {
    name      = var.task_defination_volume_name
    host_path = var.task_defination_volume_host_path
  }


}