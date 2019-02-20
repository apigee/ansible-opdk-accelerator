Apigee OPDK Silent Installation Config
=========

The purpose of this role is to construct a configuration file for the Apigee OPDK silent installer. 

Requirements
------------

The installation of Apigee OPDK requires root access. Credentials must also be supplied to override the empty placeholders
provided here. It is recommended that credentials be consolidated into a single credentials.yml file that can be stored 
separately. It is assumed that files containing credentials are stored in the ~/.apigee folder. 

Role Variables
--------------

| Variable Name | Description |
| --- | --- |
| opdk_installation_config_file | Apigee silent installation configuration file |
| opdk_user_name | Reference to the OPDK user name |
| opdk_group_name | Reference to the OPDK user group name |
| provided_response_file | Reference to an installation file that is provided by the user instead of the generated installation file. |

Dependencies
------------

This role depends on the following roles:

* apigee-opdk-setup-default-settings
 
Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-silent-installation-config }

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
