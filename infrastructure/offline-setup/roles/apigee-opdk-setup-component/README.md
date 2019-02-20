Apigee OPDK Setup Component
=========

This roles is used to setup individual Apigee OPDK components. 

Requirements
------------

The installation of Apigee OPDK requires root access. Credentials must also be supplied to override the empty placeholders
provided here. It is recommended that credentials be consolidated into a single credentials.yml file that can be stored 
separately. It is assumed that files containing credentials are stored in the ~/.apigee folder. 

Role Variables
--------------

Variable defaults are managed in the role apigee-opdk-setup-default-settings:

| Variable Name | Description |
| --- | --- |
| apigee_setup | Path to the Apigee setup script | 
| profile | Name of the installation profile to invoke | 
| opdk_installation_config_file | Path to the silent installation file |
| opdk_version is Version of OPDK to install |
| opdk_user_email | Email of the Apigee user |
| opdk_user_pass | Password of the Apigee user |

Dependencies
------------

This role depends on the following roles:

* apigee-opdk-setup-default-settings

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-component }

License
-------

Apache 2.0

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
