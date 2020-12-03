#!/bin/sh

# Check for config.sh

# Load config

# Check if running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#### Run setup ####

# Update system
system_update

# Private keys
# Allow/Disallow password authentication
# User setup


# Docker setup
docker_setup

# Docker compose setup
docker_compose_setup

# Clone repository


source helpers.sh