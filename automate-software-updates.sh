#!/bin/bash

# Update system packages
sudo apt update
sudo apt upgrade -y
# Update Docker containers (if applicable)
docker-compose -f /path/to/docker-compose.yaml pull
docker-compose -f /path/to/docker-compose.yaml up -d