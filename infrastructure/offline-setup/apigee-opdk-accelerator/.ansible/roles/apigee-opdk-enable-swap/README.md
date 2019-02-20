OPDK Enable Swap
=========

The purpose of this role is to setup swap for those instances when they are needed. 

Requirements
------------

There are no requirements

Role Variables
--------------

Swap mount point:

    swap_path: /var/swap
    
Swap size:
    
    swap_size_mb: 4096

Dependencies
------------

No Dependencies

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-enable-swap }

License
-------

Apache License Version 2.0, January 2004

Author Information
------------------

Paul Mibus
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->
