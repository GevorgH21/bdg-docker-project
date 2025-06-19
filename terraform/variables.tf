variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "Ubuntu AMI"
  default     = "ami-020cba7c55df1f615"
}

variable "key_pair_name" {
  description = "SSH key pair name"
  default     = "key-pair"
}

variable "public_key_path" {
  description = "Path to public SSH key"
  default     = "~/.ssh/id_ed25519.pub"
}

