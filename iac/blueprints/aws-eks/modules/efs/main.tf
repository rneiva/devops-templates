resource "aws_efs_file_system" "efs" {
  creation_token   = "efs"
  encrypted        = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  tags = {
    Name = "efs"
  }
}
resource "aws_efs_mount_target" "zone" {
  for_each        = toset(var.private_subnets)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = each.value
  security_groups = ["${var.cluster_primary_sg}"]
}

resource "kubernetes_storage_class_v1" "efs" {
  metadata {
    name = "efs"
  }

  storage_provisioner = "efs.csi.aws.com"

  parameters = {
    provisioningMode = "efs-ap"
    fileSystemId     = aws_efs_file_system.efs.id
    directoryPerms   = "700"
  }

  mount_options = ["iam"]
}
