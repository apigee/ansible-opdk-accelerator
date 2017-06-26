# Apigee OPDK Ansible Setup Playbook
The purpose of this project is to help configure Ansible for the use of [Apigee OPDK roles](https://github.com/carlosfrias/apigee-opdk-playbook-samples).
The Apigee OPDK roles follow conventions in the naming of files and where those files are 
located. This project sets up those locations and performs the git clone to setup your 
environment with the templates that should be customized for your use. 

# Installing Ansible on Windows
Please see the provided [Cygwin readme](CYGWIN.md) for instructions on installing Ansible on Windows.

# Installing Ansible
We use provide a [pip requirements file](ansible-pip-requirements.txt) for pip to install Ansible and its dependencies. This requires the
installation of pip on your system. Once pip is installed then the provided requirements file will
install Ansible and the necessary dependencies on your system.

# Pip Usage
* Upgrade your pip installation: `pip install -U pip`
* Install ansible and dependencies using the requirements file: `pip install -r ansible-pip-requirements.txt`

# Usage: Minimum Setup
Set up your a workspace at ~/apigee-workspace/ if you already have git and pip installed: 

    ansible-playbook setup-base.yml 
    
# Requirements
Requirements are declared in the [pip requirements file](ansible-pip-requirements.txt). The requirements
are listed as follows:
* Ansible 2.3.x
* Access to [CELVW Project on Stash](https://onestash.verizon.com/projects/CELVW)
* Pip
* Boto, if using Ansible to manage EC2
* Markupsafe
* Paramiko

# Overview: Minimum Setup
This playbook will perform the following activities:

1. Scaffold required folders
1. Git clone of Ansible configuration file templates
1. Git clone of inventory file templates.
1. Create credentials.yml template file

# Default Workspace Folders
The default workspace folders can be modified by updating workspace-folders.yml.

# Default Github Repository List
The github repositories that you include can be modified by updating workspace-github-repos.yml

# Inventory File Semantics
A description of the how the [inventory file](inventory.md) should be setup.

# Scaffold required folders
This playbook will create the following folders for you:

## ~/.ansible/configurations
Sample configuration templates for single and multi-dc planets

## ~/.ansible/inventory
Sample configuration inventory template files that model the required
 group semantics used.

## ~/.apigee
Folder to contain credentials, downloaded logs, configs and maintain the edge license.txt file.

## ~/apigee-workspace/apigee-opdk-playbook-workspace
Starter templates for playbooks. Use these playbooks as accelerators for your own.

## ~/apigee-workspace/apigee-odk-role-workspace
Workspace containing the roles used by the playbooks.
