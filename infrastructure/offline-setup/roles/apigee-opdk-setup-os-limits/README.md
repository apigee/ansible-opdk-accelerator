Apigee OPDK Setup OS DS
=========

This role performs configuration changes to the limits.conf that are required for nodes that are part of an Apigee
platform instance. 

Requirements
------------

None

Role Variables
--------------

Limits are update with the collection `apigee_limits`. This list is used to update settings in limits.conf. The default 
values are as follows: 

    apigee_limits:
    - { domain: '*', limit_type: '-', limit_item: 'memlock', value: 'unlimited' }
    - { domain: '*', limit_type: '-', limit_item: 'nofile', value: '100000' }
    - { domain: '*', limit_type: '-', limit_item: 'nproc', value: 'unlimited' }
    - { domain: '*', limit_type: '-', limit_item: 'as', value: 'unlimited' }

Dependencies
------------

None

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-os-limits }
         
or         

    - hosts: servers
      vars:
        apigee_limits:
        - { domain: '*', limit_type: '-', limit_item: 'memlock', value: 'unlimited' }
        - { domain: '*', limit_type: '-', limit_item: 'nofile', value: '100000' }
        - { domain: '*', limit_type: '-', limit_item: 'nproc', value: 'unlimited' }
        - { domain: '*', limit_type: '-', limit_item: 'as', value: 'unlimited' }
      roles:
         - { role: apigee-opdk-setup-os-limits }

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
