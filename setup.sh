#!/bin/bash

# Load dependencies
source helpers.sh

# Check for config.sh

# Load config
source config.sh

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

#### Run setup ####

# Update system
system_update

# Private keys
if [ "$SSH_KEYS" = true ]; then
  ssh_setup_keys
fi

# Allow/Disallow password authentication
# User setup

# Docker setup
if [ "$DOCKER" = true ]; then
  docker_setup
fi

# Docker compose setup
if [ "$DOCKER_COMPOSE" = true ]; then
  docker_compose_setup
fi

# Clone repository
if [ "$REPO" = true ]; then
  repo_clone $REPO_URL
fi