Apigee OPDK Setup Apigee user
=========

This roles makes sure that the apigee user is setup on the system. 

Requirements
------------

This role requires elevated system privilege.

Role Variables
--------------

| Variable Name | Description |
| --- | --- |
| opdk_user_name | The name of the OPDK user. OPDK user is `apigee`. No other names are allowed. |
| opdk_group_name | The group name of the OPDK user. The group name is `apigee` |
| opdk_group_create | Used to indicate that the group `apigee` should not be created. This is needed for those situations when the system admin chooses to manage the creation of the `apigee` group |
| opdk_resources_path | The path used to stage installation files | 

Dependencies
------------

This depends on the following roles:

* apigee-opdk-setup-default-settings.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-apigee-user }

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
