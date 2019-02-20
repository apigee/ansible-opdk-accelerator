Apigee OPDK SELinux Disable
=========

This role disables SELinux so that Apigee OPDK may be installed. 

Requirements
------------

This role requires elevated privilege. 

The following packages must be installed by the system package manager: 

* python-selinux

Role Variables
--------------

None

Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-selinux-disable }

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