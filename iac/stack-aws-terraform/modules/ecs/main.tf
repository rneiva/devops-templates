resource "aws_cloudwatch_log_group" "main" {
  name              = var.cloudwatch_log_group
  retention_in_days = 7
}

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = var.cluster_name

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.main.name
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
        base   = 20
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  tags = var.tags_ecs
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.task_name
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.task_name}",
      "image": "${var.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.account_id}:${var.ecr_image}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "memory": 2048,
      "cpu": 1024,
      "logConfiguration": {
        "logDriver": "awslogs",
          "options": {
            "awslogs-group": "${aws_cloudwatch_log_group.main.name}",
            "awslogs-region": "us-east-1",
            "awslogs-stream-prefix": "ecs"
          }
        }
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = "2048"
  cpu                      = "1024"
  execution_role_arn       = var.ecs_task_execution_role
}

resource "aws_ecs_service" "main" {
  name            = var.ecs_service_name
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.main.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = aws_ecs_task_definition.main.family
    container_port   = 3000
  }

  network_configuration {
    security_groups = [
      var.ecs_svc_sg_id,
      var.lb_sg_id
    ]
    subnets          = var.public_subnets_ids
    assign_public_ip = true
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}