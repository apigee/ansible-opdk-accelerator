Apigee OPDK Modules
=========

This role is used to distribute custom Ansible modules that support Apigee OPDK installation, configuration and maintenance throughout
the framework. This is a code only module. 

| Ansible Module Name | Description |
| --- | --- |
| cache.py | Implemented a generic caching module to enable saving of attributes more cleanly and clearly than provided mechanisms. |
| opdk_server_self.py | This modules obtains OPDK components that self report and caches those results as attributes that are suitable for other operations |

Requirements
------------

No requirements

Role Variables
--------------

No variables required.

Dependencies
------------

No dependencies

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-modules }

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
