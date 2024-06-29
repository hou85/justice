output "instance_public_ip" {
  description = "The public IP address of the GitLab instance."
  value       = aws_instance.gitlab.public_ip
}

output "instance_id" {
  description = "The ID of the GitLab instance."
  value       = aws_instance.gitlab.id
}
