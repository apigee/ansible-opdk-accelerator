# Apigee OPDK Ansible Configuration Accelerator

## Introduction
This repository contain Ansible playbooks that use Ansible roles to automate the 
installation, configuration and management of Apigee Private Cloud instances. These playbooks are 
suitable for a range of deployment scenarios that include a small All in One planet or a multi-node, 
multi-region planet. 

## Assumptions 
* This repository assumes that no Apigee Operating System requirements have been fulfilled beyond the 
selection of the initial operating system version. 
* A control server is available from which [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) 
scripts can be invoked.
* A control server that can download scripts from [Github](https://github.com).
* We assume that you have an introductory understanding of [Ansible](https://docs.ansible.com/) and 
[Ansible Galaxy](https://galaxy.ansible.com/docs/).
* Availability of administrative privilege escalation on the control server and the target nodes.

## Usage Overview
The use of this framework is composed of the following steps:

1. [Setup](setup) an Ansible control server and workspace.
1. Configure an initial Planet topology using the [Ansible inventory](README-inventory.md) file(s).
1. Place Apigee license material in `~/.apigee-secure/license.txt`.
1. Update credentials stored `~/.apigee-secure/credentials.yml`.
1. Update common installation attributes like `opdk_version` that is stored in 
`~/.apigee/custom-properties.yml`.
1. export ANSIBLE_CONFIG to use the target `ansible.cfg` file. 
1. Use `ansible-playbook` to complete the target activity.
