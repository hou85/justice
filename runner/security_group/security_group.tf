resource "aws_security_group" "gitlab" {
  name        = "gitlab-runner-sg"
  description = "Security group for GitLab server"

   ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_name" {
  value = aws_security_group.gitlab.name
}
