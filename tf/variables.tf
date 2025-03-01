variable "env" {
  description = "Deployment environment"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

# variable "ami_id" {
#   description = "EC2 Ubuntu AMI"
#   type        = string
# }

variable "vpc_azs" {
  description = "AZs for netflix_app_vpc"
  type        = list(string)
}

