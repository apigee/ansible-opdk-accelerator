Apigee OPDK Setup Postgres Master
=========

This repository contains an Ansible role that configures a Postgres Master for the Apigee platform. 

Requirements
------------

None 

Role Variables
--------------

| Variable Name | Description |
| --- | --- |
| opdk_installation_config_file | Response file used to install Apigee |
| apigee_all | Cannonical name of the apigee-all script. |

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-postgres-master }

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
