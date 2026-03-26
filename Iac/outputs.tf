output "public_ip" {
  value = aws_instance.ec2.public_ip
}

output "ssh_command" {
  value = "ssh -i id_rsa ubuntu@${aws_instance.ec2.public_ip}"
}

output "ecr_repo_url" {
  value = aws_ecr_repository.repo.repository_url
}