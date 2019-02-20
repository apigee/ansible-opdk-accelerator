Apigee OPDK Setup Apigee User Ownership
=========

This role ensures that the `apigee` user owns the `apigee_home` folder and all files and folders within it. 

Requirements
------------

None

Role Variables
--------------

| Variable Name | Description |
| --- | --- |
| apigee_home | Location of the apigee home is set to `/opt/apigee` |
| opdk_user_name | System name of OPDK user set to `apigee` |
| opdk_group_name | `apigee` user group name |


Dependencies
------------

* apigee-opdk_setup-default-settings

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-apigee-user-ownership }

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
