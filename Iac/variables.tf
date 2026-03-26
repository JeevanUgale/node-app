variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "devops-key"
}

variable "public_key_path" {
  description = "Path to public key"
  default     = "."
}
