#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y docker.io docker-compose

sudo systemctl start docker
sudo systemctl enable docker

sudo mkdir -p /opt/docker
sudo chown ubuntu:ubuntu /opt/docker

sudo usermod -aG docker ubuntu