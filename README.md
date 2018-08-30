# Apigee OPDK Ansible Configuration Accelerator

## Introduction
This repository contain a framework of Ansible playbooks that use Ansible roles to help you install, 
configure and manage one or multiple Apigee OPDK planet topologies. This framework makes the following
assumptions: 

1. Introductory understanding of [Ansible](https://docs.ansible.com/) and 
[Ansible Galaxy](https://galaxy.ansible.com/docs/).
1. An [Ansible installation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
1. Creation and use of a known folder structure for Ansible artifacts.
1. Creation and use of Ansible configuration files for switching between planet topologies.
1. Planet topologies are managed by the use of Ansible inventory files.
1. Apigee component nodes are assigned roles by their inclusion in the designated inventory groups.
1. Playbooks are collections of Apigee OPDK roles that dynamically adjust to the target installation 
environment.
1. Ansible Galaxy is used as the distribution mechanism to deliver roles to manage making modifications
and change drift between different uses of the framework. 

## Usage
This usage of this framework is composed of the following steps:

1. [Setup](setup) an Ansible control server and workspace.
1. Configure an initial Planet topology.
1. Place Apigee license material in `~/.apigee-secure/license.txt`.
1. Update credentials stored `~/.apigee-secure/credentials.yml`.
1. Update common installation attributes like `opdk_version` that is stored in 
`~/.apigee/custom-properties.yml`.
1. export ANSIBLE_CONFIG to use the target `ansible.cfg` file. 
1. Use `ansible-playbook` to complete the target activity.



This repository contains playbooks that use the [Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) 
role to setup an Ansible Controller. An Ansible controller is used to run Ansible playbooks. The
[setup.yml](setup/setup.yml) script enables you to setup an Ansible controller to work with either a single
planet for your own testing or to set up to manage multiple planets. The setup required to manage a
single planet or a multiple planet deployment is essentially the same. You require a workspace on the
file system that contain configuration files, roles, cached attributes, log files and your inventory 
of server nodes that will host your planet instance(s). This setup creates a common convention that 
helps you manage either one planet or several.  

## Quick Start
The playbook `setup.yml` will setup your folder structure in your user home directory. You can change
the location of you folder structure by providing updated folder paths using the `setup.yml` playbook. 
If you do not provide a required attribute then you will be prompted by the script to provide the 
value. Please see 
[Apigee OPDK Setup Ansible Controller](https://github.com/carlosfrias/apigee-opdk-setup-ansible-controller) 
for additional details.

### Playbooks
You can `git clone` playbooks to get started and place them in the playbooks folder. You can start 
with this [installation playbook](https://github.com/carlosfrias/apigee-opdk-playbook-installation-single-region).

### Configure SSH Access for your Nodes
If you need to configure SSH access for your nodes but you only have a username and password then take
a look at the [Configure SSH Login ](https://github.com/carlosfrias/apigee-opdk-playbook-setup-ansible/tree/master/configure-ssh-login)
for a playbook to help you set up SSH key access quickly over any number of servers. 

### Backup an Ansible Control Server
If you need to backup the setup of an Ansible control server then take a look at 
[Ansible Control Server Backup](https://github.com/carlosfrias/apigee-opdk-playbook-setup-ansible/tree/master/backup-ansible-controller)
for a playbook to help you backup a control server.

# Usage Instructions

## Sample Usage to Setup an Ansible Control Server 

The `setup.yml` will configure a control server 

    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml 

## Sample Usage to Setup an Ansible Control Server on localhost

A basic controller setup can be configured in the current directory: 

    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -c local -e remote_user=<remote user login>

### Change the location of the Ansible workspace folder
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e remote_user=<remote user login> -e ansible_workspace=~/.ansible
    
### Change the location of the Apigee workspace folder
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e remote_user=<remote user login> -e apigee_workspace=~/.apigee
    
### Placing the Apigee Secure in a location of your choosing
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e apigee_secure_folder=<User defined path> -e remote_user=<remote user login> -e apigee_workspace=~/.apigee
    
### Placing the Apigee Customer Properties in a location of your choosing
   
    # Download the required roles to setup the Ansible controller
    ansible-galaxy install -r requirements.yml -f
    
    # Setup the Ansible controller
    ansible-playbook setup.yml -e apigee_custom_properties_folder=<User defined path> -e apigee_secure_folder=<User defined path> -e remote_user=<remote user login> -e apigee_workspace=~/.apigee
    