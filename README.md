# Apigee OPDK Ansible Configuration Accelerator

## Introduction
This repository contain a framework of Ansible playbooks that use Ansible roles to automate the 
installation, configuration and management of one or multiple Apigee OPDK planet topologies. This 
framework makes the following assumptions: 

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

## Usage Overview
The use of this framework is composed of the following steps:

1. [Setup](setup) an Ansible control server and workspace.
1. Configure an initial Planet topology using the Ansible inventory file(s).
1. Place Apigee license material in `~/.apigee-secure/license.txt`.
1. Update credentials stored `~/.apigee-secure/credentials.yml`.
1. Update common installation attributes like `opdk_version` that is stored in 
`~/.apigee/custom-properties.yml`.
1. export ANSIBLE_CONFIG to use the target `ansible.cfg` file. 
1. Use `ansible-playbook` to complete the target activity.
