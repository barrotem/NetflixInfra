# resource "aws_security_group" "netflix_app_sg" {
#   name        = "barrotem-tf-netflix-app-sg" # change <your-name> accordingly
#   description = "Netflix firewall rules"
#
#   ingress {
#     # Allow icmp - any
#     from_port   = -1
#     to_port     = -1
#     protocol    = "icmp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   ingress {
#     from_port   = 3000
#     to_port     = 3000
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
#
# resource "aws_instance" "netflix_app" {
#   ami             = "ami-09a9858973b288bdd" #ami is brought from launch instance ami
#   instance_type   = "t3.micro"
#   security_groups = [aws_security_group.netflix_app_sg.name]
#   key_name        = "barrotem-ec2-key"
#   user_data       = file("/home/barrotem/Desktop/BarRotem/PyCharm/Workspace/Projects/NetflixInfra/resources/deploy.sh")
#
#   provisioner "file" {
#     source      = "/home/barrotem/Desktop/BarRotem/PyCharm/Workspace/Projects/NetflixInfra/resources/docker-compose.yaml"
#     destination = "/home/ubuntu/docker-compose.yaml"
#
#     connection {
#       type        = "ssh"
#       user        = "ubuntu"
#       private_key = file("/home/barrotem/Desktop/BarRotem/PyCharm/Workspace/Projects/barrotem-ec2-key.pem")
#       host        = self.public_ip
#     }
#   }
#
#   tags = {
#     Name      = "barrotem-tf-netflix"
#     Terraform = "owned"
#   }
# }
#
