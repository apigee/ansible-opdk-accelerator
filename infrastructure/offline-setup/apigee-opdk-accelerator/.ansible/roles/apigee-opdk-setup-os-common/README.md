Apigee OPDK Common OS Setup
=========

This roles sets up operating system packages and configs with common tools used by system admins to carry out diagnostic 
and troubleshooting. This role builds on the bare bones setup performed by apigee-opdk-setup-os-minimum. 

Requirements
------------
This role requires elevated system privilege.

Role Variables
--------------



The collection `os_packages` contains a list of the systems packages installed by this role: 

    os_packages:
    - lsof
    - nc
    - dos2unix
    - tcpdump
    - telnet
    - vim
    - tree


Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-os-common }

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