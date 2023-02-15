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
