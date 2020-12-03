#!/bin/bash

function system_update(){
  log "Running system update...";
  apt-get update
  apt autoremove -y
  apt-get install -y git openssh-client
  success "System updated";
}
function ssh_setup_keys(){
  log "Creating SSH keys...";
  if [ -f "$HOME/.ssh/id_rsa" ]; then
    info "Keys already exists"
  else
    ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa
    ssh-keygen -p -m PEM -N '' -f ~/.ssh/id_rsa
    success "SSH keys created";
  fi
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
function docker_move_path(){
  log "Moving docker folder...";
  if [ ! -d "$DOCKER_MOVE_PATH" ]; then
    sudo service docker stop
    sudo mv /var/lib/docker /var/lib/docker~
    sudo mkdir "$DOCKER_MOVE_PATH"
    sudo chmod 0711 "$DOCKER_MOVE_PATH"
    sudo ln -s "$DOCKER_MOVE_PATH" /var/lib/docker
    sudo service docker start
    success "Docker folder moved";
  else
    info "Docker folder already exists";
  fi
}
function base_path_open(){
  log "Opening base path...";
  if [ ! -d "$1" ]; then
    mkdir "$1";
    success "Base path ($1) created";
  fi
  cd "$1" || return
  success "Base path opened";
}
function repo_clone(){
  PATH=$(echo "$REPO_URL" | cut -d'/' -f 2 | cut -d'.' -f 1)
  log "Cloning repository...";
  if [ ! -d "$PATH" ]; then
    git clone "$REPO_URL"
    success "Repository cloned";
  else
    info "Repository already cloned";
  fi
}
function log(){
  echo "$1";
}
function success(){
  echo "$1";
}
function info(){
  echo "$1";
}


function validate_config() {
  # Validate git repo string
  #  PATH=$(echo "$1" | cut -d'/' -f 2 | cut -d'.' -f 1)
  info "Valid config found";
}