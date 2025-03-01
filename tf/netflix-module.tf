terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.55"
    }
  }

  backend "s3" {
    bucket = "barrotem-netflix-infra-tfstate-bucket"
    key    = "tfstate.json"
    region = "eu-north-1"
    # optional: dynamodb_table = "<table-name>"
  }

  required_version = ">= 1.7.0"
}

provider "aws" {
  region = var.region
  # Command out profile so github-actions goes to environment variables
  #   profile = "default" # change in case you want to work with another AWS account profile
}



# resource "aws_instance" "netflix_mc_2" {
#   #ami = "ami-075449515af5df0d1"
#   ami             = var.ami_id
#   instance_type   = "t3.micro"
#   #security_groups = [aws_security_group.netflix_app_test_sg.id] Could be created only when using default vpc
#   #key_name        = "barrotem-ec2-key"
#   subnet_id = module.netflix_app_vpc.public_subnets[0]
#   vpc_security_group_ids = [aws_security_group.netflix_app_test_sg.id]
#
#   tags = {
#     Name      = "barrotem-tf-netflix-mc-2-${var.env}"
#     Terraform = "owned"
#     SampleTag = "Barrotem"
#     AnotherTag = "BarRotem"
#     Env       = var.env
#   }
# }
#
# resource "aws_security_group" "netflix_app_test_sg" {
#   name        = "barrotem-netflix-app-test-sg" # change <your-name> accordingly
#   description = "Allow SSH and HTTP traffic"
#   vpc_id      = module.netflix_app_vpc.vpc_id
#
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

module "netflix_app_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name                    = "barrotem-netflix-vpc"
  cidr                    = "10.0.0.0/16"
  map_public_ip_on_launch = true

  azs             = var.vpc_azs
  private_subnets = ["10.0.0.0/24", "10.0.1.0/24"]
  public_subnets  = ["10.0.2.0/24", "10.0.3.0/24"]

  enable_nat_gateway = false

  tags = {
    Env = var.env
  }
}

module "netflix_app" {
  source = "./.terraform/modules/netflix-app"

  aws_region        = var.region
  availability_zone = "us-west-2a"
  vpc_id            = module.netflix_app_vpc.vpc_id
  vpc_cidr          = "10.0.0.0/16"
  subnet_id         = module.netflix_app_vpc.public_subnets[0]
  ami_id            = "ami-09a9858973b288bdd"
  instance_type     = "t3.micro"
  key_name          = "barrotem-ec2-tf-key"
  public_key_path   = "/home/barrotem/Desktop/BarRotem/PyCharm/Workspace/Projects/barrotem-ec2-tf-key.pub"
  bucket_name       = "barrotem-netflix-app-bucket-tf"
}



# resource "aws_iam_role" "netflix_app_role" {
#   name               = "barrotem-tf-netflix-role"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }
# provider "aws" {
#   region  = "eu-north-1"
#   profile = "default"  # change in case you want to work with another AWS account profile
# }

#
# # resource "aws_ebs_volume" "barrotem-tf-netflix-ebs" {
# #   availability_zone = "eu-north-1a"
# #   size              = 5
# #
# #   tags = {
# #     Name = "barrotem-tf-ebs"
# #   }
# # }
#
# # resource "aws_ebs_volume" "barrotem-tf-netflix-ebs2" {
# #   availability_zone = "eu-north-1a"
# #   size              = 6
# #
# #   tags = {
# #     Name = "barrotem-tf-ebs-2"
# #   }
# # }
#
# # resource "aws_volume_attachment" "ebs_att2" {
# #   device_name = "/dev/sdf"
# #   volume_id   = aws_ebs_volume.barrotem-tf-netflix-ebs2.id
# #   instance_id = aws_instance.netflix_app.id
# # }
#
# # resource "aws_instance" "netflix_app" {
# #   ami           = "ami-02e2af61198e99faf" #ami is brought from launch instance ami
# #   instance_type = "t3.nano"
# #   security_groups = [aws_security_group.netflix_app_sg.name]
# #   key_name = "barrotem-tf-keypair"
# #   depends_on = [aws_s3_bucket.netflix-bucket]
# #   tags = {
# #     Name = "barrotem-tf-netflix"
# #     Terraform = "owned"
# #   }
# # }
#
# # resource "aws_volume_attachment" "ebs_att" {
# #   device_name = "/dev/sdh"
# #   volume_id   = aws_ebs_volume.barrotem-tf-netflix-ebs.id
# #   instance_id = aws_instance.netflix_app.id
# # }
#

#
# resource "aws_key_pair" "barrotem-tf-keypair" {
#   key_name   = "barrotem-tf-keypair"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDFz2MMelYNj2eKFmDHGustS45kob+G4Q5FzoSwH//NZ7ZJCls4KpZaVTCBEpUK+4BjsM98L9oM2ntlcl0IZ51VGe7NXFT1C/fi4l5Obt8vlEwSdFiva4kl/DGHTstr/8eOuCX054FdRbeUkYBlFWro4N2VD3+VTcp4ytsXc38jIuqPFBcmBKecagPEc2m7lFauMPuCMf/dF1zGp4CfiBpYD0CxvYvG8By4X/D4ymrGBBwuM1xnqtUeSZv3JLpczPnb5p0Vek5tdeBHvs8rDL0100LtyVWIRoAyReLq3j3ypaNy8nfPJuvTHXYPME2svanrKUEQB2F6Jn+UqklfL+07QsEM7w2ni+bLalhTqJDK+xuRMJ+sj2aNsvEarNL4jqb3Wy6gbynqBVLaKVHGb7Oqf4lFh2GGTHYObpKv4+AOck89nXiCcDEodO3xE7pHblITZ/ye6WkmM2aDGam1z+g8TcNvZniExJTxWhCByvDCOtSfoQQ45+0V1I9rtpvRxwNQ8xfRJWuYPUD9/UKqBhB3dVJH2NfWUQ8GPLUqS9c+Q3unRuR//9jTERDcA3xNi4wpt01PpVnEd0vLSETfILaz8qhMjUeL4/dg5KLI8qFiWMK+xUIwDm4xu9GH3h3eON+/UL3V1C5d1vtaEESQuLrrKbk3DozZxV0pv0kvkl+wLw== bar.rotem45@gmail.com"
# }
#
# resource "aws_s3_bucket" "netflix-bucket" {
#   bucket = "barrotem-tf-bucket"
#
#   tags = {
#     Name        = "barrotem-tf-bucket-name-test"
#     Environment = "prod"
#   }
# }
#
#
