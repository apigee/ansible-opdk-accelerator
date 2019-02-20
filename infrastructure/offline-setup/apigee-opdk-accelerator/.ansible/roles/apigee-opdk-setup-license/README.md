Apigee OPDK Setup License
=========

This repository contains an Ansible role to manage the Apigee provided license file. 

Requirements
------------

None

Role Variables
--------------

| Variable Name | Description |
| --- | --- |
| opdk_license_source_file_name | The name of the license file on the control server. |
| opdk_license_target_file_path | The location on the target node where to temporarily stage files. |
| opdk_user_name | Apigee installation admin, also the system user. Should be set to `apigee` |
| opdk_group_name | System `apigee` group |

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-license }

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
