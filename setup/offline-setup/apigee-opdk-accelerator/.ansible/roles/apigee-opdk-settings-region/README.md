Apigee OPDK Region Settings
=========

This role updates the Ansible cache with attributes that are used to generate templates and make 
installation decisions. 

This role will add the following attributes to the Ansible cache: 
* region
* region_num

Requirements
------------

The data center (`dc`) must be defined as a group in the inventory file.  A `dc` must be defined as 
an inventory group such as `[dc-1]`. This role will set the region for up to nine `9` data centers.

Role Variables
--------------

Inventory group definitions. Must indicate at least `[dc-1]` but can go as high as `[dc-9]`.

Dependencies
------------

N/A


Example Playbook
----------------

    - hosts: rmp
      roles:
         - { role: apigee-opdk-settings-region }

License
-------

Apache 2.0

Author Information
------------------

Carlos Frias
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
