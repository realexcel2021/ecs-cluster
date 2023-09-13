resource "aws_ecs_service" "service" {
  name            = var.ecs_service_name
  cluster         = var.ecs_service_cluster
  task_definition = var.ecs_task_defiantion
  desired_count   = var.ecs_desired_count
  iam_role        = var.ecs_service_iam_role_arn
  depends_on      = [var.ecs_service_iam_role_arn]
  launch_type = "FARGATE"

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

}