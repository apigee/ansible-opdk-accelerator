Apigee Setup Installer
======================

This is the installer role that installs opdk archive, the license.txt 
and to create a response file on a machine. This role prepares a machine
so that any profile can be configured and setup on a machine. 
This is a common setup and configuration step that is required on all 
instances that will run an OPDK component. 

Requirements
------------

This role requires that you provide the opdk archive and license file. 
This role also requires that the inventory file be defined with a set of 
groups that would enable the response file to be generated correctly.
This has been tested with one data center. 

Role Variables
--------------

Role variables have been provided and contain what seem to be sensible 
defaults. 

* opdk_user_name: opdk user on the OS
* opdk_user_pass: opdk user password on the OS
* opdk_user_email: Email address of the opdk user
* opdk_group_name: opdk user group on the OS
* opdk_user_home: The location of the opdk user home directory.
* opdk_user_ssh_private_key: The location of the opdk user ssh private key
* opdk_staging_folder_name: The location of the opdk staging folder in the opdk user home.
* opdk_major_minor_version: Opdk major and minor version numbers only
* opdk_build_version: Opdk build version
* opdk_resources_path: Path to opdk staging folder
* opdk_installer_file_basename: Base file name of the installation archive
* opdk_staging_path_prefix: Prefix used in the name of the staging path
* opdk_installer_staging_folder_path: Full path to the staging path for the opdk installer
* opdk_installer_archive_name: File name of the opdk archive
* opdk_installer_archive_path: Absolute path to the opdk archive
* opdk_response_file_path: Absolute path to the response file
* opdk_license_target_file_path: Absoluute path to the license file
* apigee_installation_path_prefix: Apigee installation target prefix
* apigee_installation_home: Apigee installation target 
* apigee_install_script: Apigee installation script
* apigee_java_home: Java home
* apigee_hostfile_path: Hosts file
* apigee_tmp_dir: Temporary directory
* provided_response_file: Will use the provided response file indicated here.

Dependencies
------------

    - apigee-opdk-setup-default-settings
    - apigee-opdk-setup-bootstrap

Example Playbook
----------------

    ---
    - hosts: '{{hosts}}'
      become: true
      roles:
      - { role: apigee-opdk-setup-component-installer }

License
-------

Apache License Version 2.0, January 2004

Author Information
------------------

Carlos Frias
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->
