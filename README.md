# Apigee OPDK Ansible Configuration Accelerator
The purpose of this project is to help configure Ansible for the use of
[Apigee OPDK roles](https://github.com/carlosfrias/apigee-opdk-playbook-samples).

These roles and playbooks contain a fairly complete set of functionality to assist in the 
management of Apigee planet instances using Ansible. The functionality for the installation, 
expansion, upgrade and maintenance of an Apigee Planet is provided so as to apply Apigee 
system recommendations to systems that are not aligned with Apigee system recommendations. 
Further information regarding the features list of these playbooks can be found in 
[README-FEATURES.md](README-FEATURES.md). For the installation of Apigee planet instances on 
systems that do not require any updates to be updated with Apigee recommendations you may benefit 
from using our [simplified installer](https://github.com/apigee/ansible).

Conventions have been used regarding the placement of files and the names of inventory groups. The placement of files
is described below as are the names of inventory groups. The playbooks rely on these conventions. These conventions 
have reduced the installation of the Edge platform to updating attributes in property files and the judicious use of tags
around the points of installation failure. The playbooks make use of tags so that functionality can be targeted as needed. 
Finally, take note that templates are provided to guide how you should update your inventory and to generate the required
response files from the updated inventory. 

# Quick Installation
Please note that this installation framework uses Ansible. Please install Ansible 4.x prior to cloning
this project. Once Ansible is ready for use you can follow these steps: 
1. Clone this project into a workspace. We recommend ~/apigee-workspace.
1. Change into the cloned directory.  
1. Review [repository-mapping-name-folder.yml](repository-mapping-name-folder.yml) to select the
projects, roles and configurations you wish to work with.
1. Update [repository-custom-properties.yml](repository-custom-properties.yml) with the locations 
where you want resources and configuration files located. Defaults are provided. 
1. Execute `ansible-playbook setup.yml` to create a local development environment.
1. After taking note of what the [Quick Installation](#what-does-the-quick-installation-do) did and completing 
[Required Steps](#required-steps) you will likely start with 
[Apigee OPDK Playbook Installations](https://github.com/carlosfrias/apigee-opdk-playbook-installation-single-region) 

# What does the Quick Installation do? 
The quick installation will create several folders where configurations and playbooks will be located.
The folders and initial files are listed as follows:

* `~/.ansible/configurations/{configuration file name.cfg}`: This contains ansible configuration files.
* `~/.ansible/inventory/{environment inventory}/`: This contains several templates to guide how you should 
configure the inventory.
* `~/.apigee/`: This folder contains files used to install Apigee components.
* `~/.apigee/license.txt`: This is the license file you received from Apigee. 
* `~/.apigee/custom-properties.yml`: The installation framework is parameterized. Variables can be
either uncommented and used or added to this file. 
* `~/.apigee-secure`: This folder contains file that contain sensitive attributes that should be secured.
* `~/.apigee-secure`: This file contains the credentials to be used during the installation of Apigee components.

# Required Steps
1. It is necessary to update your credentials.yml and to copy your license file into `~/.apigee-secure/license.txt`. 
1. Update the ansible.cfg file with your `remote_user`
1. Confirm the ssh key you are using.
1. Confirm that the ansible.cfg is pointing to the correct inventory folder.
1. Export the `ANSIBLE_CONFIG` environmental variable pointing to the `ansible.cfg` you are using. Please do this
like this: `export ANSIBLE_CONFIG=~/.ansible/configurations/{configuration file name.cfg}`
1. Update the appropriate files in the inventory folder for either Edge, DevPortal, Baas or Monitoring as needed Observe
groupings and add your ip addresses at the lowest level which would be the dc-1-xx, dc-2-xx, etc.
1. Confirm connectivity using the the `ping` module. 
1. Change to the folder which is likely to be `~/apigee-workspace/apigee-opdk-playbook-workspace/apigee-opdk-playbook-installation-single-region`
and download the Ansible roles using Ansible Galaxy to the location you indicated in the `ansible.cfg` file you are using. Take note that files that end in `-requirements.yml` are Ansible Galaxy requirement files. Update the roles
following this sample: `ansible-galaxy install -r install-edge-requirements.yml`
The playbook that the `-requirements.yml` file supports is the playbook with the same name as the first part of the requirements file. 
This means that `install-edge-requirements.yml` updates the roles for the playbook `install-edge.yml`
1. The first invocation should be: `ansible-playbook install-edge.yml -b --tags={cache,ds,ms,rmp,qs,org} {Any optional parameters}`

# Installing Ansible on Windows
Please see the provided [Cygwin readme](README-CYGWIN.md) for instructions on installing Ansible on Windows.

# Installing Ansible
We use provide a [pip requirements file](ansible-pip-requirements.txt) for pip to install Ansible and its dependencies. This requires the
installation of pip on your system. Once pip is installed then the provided requirements file will
install Ansible and the necessary dependencies on your system.

# Pip Configuration
It may be necessary to configure pip to work with a repository that is internally managed. This can be accomplished by
updating the pip.conf file with the url of your managed repository. To accomplish this please follow these steps:

    mkdir ~/.pip
    touch ~/.pip/pip.conf
    vi ~/.pip/pip.conf

    [global]
    index-url = {{ pip_index_url }}

## Managed Pip Url
Please note that the url can be found in the your ~/apigee-workspace/apigee/custom-properties.yml. Please replace as follows:

    {{ pip_index_url }} >> "https://private.repository.com/api/pypi/Pypi-remote/simple"

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

# Inventory File Semantics
A description of the how the [Inventory File](README-INVENTORY-FILE.md) should be setup.

# Scaffold required folders
This playbook will create the correct folders for you. Folder location can be modified by updating the [workspace-folders.yml](workspace-folders.yml).

## ~/.ansible/configurations
Sample configuration templates for single and multi-dc planets

## ~/.ansible/inventory
Sample configuration inventory template files that model the required
 group semantics used.

## ~/.apigee
Folder to contain credentials, downloaded logs, configs and maintain the edge license.txt file.
The [setup-apigee-license.yml](setup-apigee-license.yml) playbook will take a specified license file and
install it in the correct location for your this workspace.

## ~/apigee-workspace/apigee-opdk-playbook-workspace
Starter templates for playbooks. Use these playbooks as accelerators for your own.

## ~/apigee-workspace/apigee-opdk-role-workspace
Workspace containing the roles used by the playbooks.

# Configure Credentials
Configuring of installation credentials is described in the [credentials readme](README-credentials.md).

# Configure Ansible
Ansible can be configured to make use of the above folders by providing an Ansible configuration file.
The Ansible configuration file can be generated in using the `setup-ansible-config.yml` playbook.

    ansible-playbook setup-ansible-config.yml
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTION.md).
<!-- END Google How To Contribute -->
