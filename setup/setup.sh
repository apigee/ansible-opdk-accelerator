#!/usr/bin/env bash

sudo yum install -y python-pip
sudo pip install pip --upgrade
sudo pip install ansible google-auth
ansible-galaxy import https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller.git
ansible-galaxy import https://github.com/carlosfrias/apigee-opdk-modules.git

