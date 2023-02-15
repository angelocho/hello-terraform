terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0b752bf1df193a6c4"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "sg-0d2b1e710a2281426",
  ]
  subnet_id = "subnet-0f79bf7d4bc65f63b"
  key_name  = "clave-lucatic"
  user_data = <<EOF
#!/bin/bash
amazon-linux-extras install docker -y

service docker start
systemctl enable docker

usermod -a -G docker ec2-user

pip3 install docker-compose

wget https://raw.githubusercontent.com/angelocho/hello-amazon/main/compose.yaml

chown ec2-user compose.yaml

docker-compose pull

docker-compose up -d

EOF
  tags = {
    Name = var.instance_name
    APP  = "vue2048"
  }
}
