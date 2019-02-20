Apigee OPDK Setup Validate Cleanup
=========

This role performs the installation cleanup of the Apigee OPDK validation.

Requirements
------------

The installation of Apigee OPDK requires root access. 

Role Variables
--------------

Default values for variables are provided by the role apigee-opdk-setup-default-settings.

Dependencies
------------

This role depends on the following roles:

* apigee-opdk-setup-default-settings

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-validate-cleanup }

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
