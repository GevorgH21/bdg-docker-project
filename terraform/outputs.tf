output "instance_public_ip" {
  value = aws_instance.bdg_docker_host.public_ip
}

