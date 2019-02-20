Apigee OPDK Stop Components
=========

This repository contains an Ansible role that stops either all components or the indicated one. 

Requirements
------------

None

Role Variables
--------------


| Variable Name | Description |
| --- | --- |
| component_name | Name of the component to start; if set to all then apigee-all is used. |
| http_proxy | http proxy endpoint |
| https_proxy | https proxy endpoint |
| no_proxy | no proxy to be set when working with a proxy |
| port_timeout | Update the port timeout setting in the Apigee update script |
| up_timeout | Update the setting in the Apigee update script waiting for the component to come up |
| opdk_debug_mode | If set to `on` then the bash script will be run with the `-x` parameter |

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-stop-components }

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
