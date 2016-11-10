Apigee OPDK Ansible Setup Playbook
==================================

The purpose of this project is to help configure Ansible for the use of [Apigee OPDK roles](https://github.com/carlosfrias/apigee-opdk-playbook-samples). 
The Apigee OPDK roles follow conventions in the naming of files and where those files are 
located. This project sets up those locations and performs the git clone to setup your 
environment with the templates that should be customized for your use. 

Requirements
============

* Ansible 2.1 or greater
* Linux control server version 6 or greater
* Access to github.com

Overview: Minimum Setup
=======================

This playbook will perform the following activities:

1. Scaffold required folders

1. Git clone of Ansible configuration file templates

1. Git clone of inventory file templates. [Updating your inventory file]
(inventory.md)

1. Create credentials.yml template file

Scaffold required folders
=========================

This playbook will create the following folders for you: 

* ~/.ansible/configurations

* ~/.ansible/inventory

* ~/.apigee

Usage: Minimum Setup
====================

Set up your environment for working with Apigee OPDK roles with: 

    ansible-playbook setup-base.yml

Overview: EC2 Managed Setup
===========================

The minimum setup must be completed prior to configuring the EC2 managed setup. The EC2 managed setup will
update perform the following activities: 
* Update ~/.bashrc to export AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY values you provide. 
* Update ~/.bashrc to export EC2_INI_PATH.
* Create a template .boto file and place it your home directory
* Create a template ec2.ini and place it in your ~/.ansible folders
* Provide a copy of the ec2.py script that must be included with any AWS managed inventory file.

Usage: Setup for EC2 Managed Images
===================================

Please follow the usage instructions:

    ansible-playbook setup-ec2.yml \
        -e secure_aws_region={{ secure_aws_region }} \
        -e aws_access_key_id={{ aws_access_key_id }} \
        -e aws_secret_access_key={{ aws_secret_access_key }}

## Variables Used    

Variable Name  | Description |
--- | --- |
secure_aws_region | Please provide your ec2_region. |
aws_access_key_id | Please provide your AWS Access Key ID. |
aws_secret_access_key | Please provide your AWS Secret Access Key. |

