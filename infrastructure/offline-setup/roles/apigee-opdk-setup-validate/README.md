Apigee OPDK Setup Validate
=========

This role executes the validation included with the installation of Apigee OPDK. This role will adjust to whether Router
and Message Processors are defined on a node together or separately. 

Requirements
------------

The installation of Apigee OPDK requires root access. 

Role Variables
--------------

| Variable Name | Description |
| --- | --- |
| apigee_validate_config_file | Validate configuration file |
| opdk_user_email | Edge system user email |
| opdk_user_pass | Edge system user password |
| opdk_user_name | Edge system user name, should be apigee |
| opdk_group_name | Edge system user group name, should be apigee |
| confirm_delete_org | Will remove the validation org if set to 'y'; default is 'y' |

Dependencies
------------

This role depends on the following roles:

* apigee-opdk-setup-default-settings

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-validate }

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