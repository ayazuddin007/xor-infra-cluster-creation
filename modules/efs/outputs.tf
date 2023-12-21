output "efs_file_system_id" {
  value = aws_efs_file_system.demo.id
}

output "access_point_id" {
  value = aws_efs_access_point.demo.id
}
