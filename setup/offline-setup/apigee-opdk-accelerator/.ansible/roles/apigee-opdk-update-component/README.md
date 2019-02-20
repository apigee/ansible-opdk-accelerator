Apigee OPDK Update Component
=========

This repository contains an Ansible role to perform an update to the version of a component of the Apigee platform. 

Requirements
------------

Previous installation of the Apigee platform on the node.

Role Variables
--------------

| Variable Name | Description |
| --- | --- |
| component | The component name to pass into the update.sh script |
| opdk_installation_config_file | Response file used to install Apigee |
| http_proxy | http proxy endpoint |
| https_proxy | https proxy endpoint |
| no_proxy | no proxy to be set when working with a proxy |
| PORT_TIMEOUT | Update the port timeout setting in the Apigee update script |
| UP_TIMEOUT | Update the setting in the Apigee update script waiting for the component to come up |

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-pre-requisites-common-update }

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
