resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
  name   = "main_sg"
  
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "all_security_group_ids" {
  value = [aws_security_group.main.id]
}
