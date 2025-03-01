#Define variables for netflix-app infrastructure
variable "aws_region" {
  description = "AWS Region to deploy app to"
  type        = string
  default = "eu-north-1"
}

variable "availability_zone" {
  description = "AWS availability zone to deploy app to"
  type        = string
  default = "eu-north-1a"
}

variable "vpc_id" {
  description = "AWS vpc id to deploy app to"
  type        = string
  default = ""
}

variable "vpc_cidr" {
  description = "AWS vpc cidr to deploy app to"
  type        = string
  default = "10.0.0.0/16"
}

#subnet_cide is undefined since this is irrelevant for instance

variable "subnet_id" {
  description = "AWS subnet id to deploy app to"
  type        = string
  default = ""
}

variable "ami_id" {
  description = "AMI ID to use when creating the instance"
  type        = string
  default = "ami-09a9858973b288bdd"
}

variable "instance_type" {
  description = "Instance app to deploy for netflix app"
  type        = string
  default = "t3.micro"
}

variable "key_name" {
  description = "The public key name to use for ssh connections for the machine"
  type        = string
}

variable "public_key_path" {
  description = "The path to use for the value of the public key of the machine"
  type        = string
}

variable "bucket_name" {
  description = "The bucket name to create to imitate a netflix-backend"
  type        = string
  default = "barrotem-netflix-bucket-backend"
}
