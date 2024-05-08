resource "aws_security_group" "redis_sg" {
  name   = var.sg_redis
  vpc_id = var.vpc_id
  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = var.vpc_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elasticache_subnet_group" "main" {
  name       = var.elastic_sbnt
  subnet_ids = var.elasticache_subnets_ids
}

resource "aws_elasticache_cluster" "main" {
  cluster_id           = var.elasticache_cluster
  engine               = var.elasticache_engine
  node_type            = var.elasticache_node_type
  num_cache_nodes      = var.elisticache_nodes
  parameter_group_name = var.elasticache_group
  engine_version       = var.elasticache_engine_version
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.main.name
  security_group_ids   = [aws_security_group.redis_sg.id]
}