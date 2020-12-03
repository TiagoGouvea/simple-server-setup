#!/bin/bash

function system_update(){
  log "Running system update...";
  apt-get update
  success "System updated";
}
function docker_setup() {
  log "Installing docker...";
  apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  apt-key fingerprint 0EBFCD88
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  apt-get update
  apt-get install -y docker-ce docker-ce-cli containerd.io
  groupadd docker
  usermod -aG docker $USER
  usermod -aG docker github
  docker run hello-world
  success "Docker installed";
}
function docker_compose_setup() {
  log "Installing docker composer...";
  curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  docker-compose --version
  success "Docker composer installed";
}
function repo_clone(){
  log "Cloning repository...";
  git clone $1
  success "Repository cloned";
}
function log(){
  echo "$1";
}
function success(){
  echo "$1";
}