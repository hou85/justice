output "kubernetes_master_ip" {
  value = aws_instance.k8s_master.public_ip
}

output "kubernetes_worker_ips" {
  value = [for i in aws_instance.k8s_worker: i.public_ip]
}

output "mongodb_ip" {
  value = aws_instance.mongodb.public_ip
}

output "proxy_internal_ip" {
  value = aws_instance.proxy_internal.public_ip
}

output "proxy_external_ip" {
  value = aws_instance.proxy_external.public_ip
}

output "logging_ip" {
  value = aws_instance.logging.public_ip
}

output "monitoring_ip" {
  value = aws_instance.monitoring.public_ip
}

