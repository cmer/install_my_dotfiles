#!/bin/bash

read -p "Does your GitLab account require Two Factor Authentication? (y/n): " ans
if [ "$ans" == "y" ] ; then
  gl_username="oauth2"
  read -p "Enter your GitLab Personal Access Token (http://bit.ly/glpat): " gl_password
else
  read -p "Enter your GitLab username: " gl_username
  read -p "Enter your GitLab password: " gl_password
fi ;

git clone https://$gl_username:$gl_password@gitlab.com/cmer/dotfiles.git ~/.dotfiles

if [ $? -eq 0 ]; then
  echo "Dotfiles cloned successfully. Starting installation..."
  cd ~/.dotfiles && git submodule update --init --recursive && ./bootstrap_macos
else
  echo "Could not clone dotfiles. Exiting."
  exit 1
fi
