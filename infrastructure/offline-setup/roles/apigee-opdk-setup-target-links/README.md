Apigee OPDK Setup Target Links
=========

This role sets up a scaffolded `apigee_home` to redirect components and data to custom locations. 
This role will setup the target links if the `target_links` collection is provided.

Requirements
------------

This role requires elevated system privilege.

Role Variables
--------------
The collection `target_links` is used for creating softlinks from apigee system folders to customer target locations.

    target_links:
    - { src: '/apps/opt/apigee', dest: '/opt/apigee' }

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-target-links }

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
