Apigee OPDK Setup OS Pip
=========

This repository contains Ansible roles to pip packages for use on the Apigee platform.   

Requirements
------------

This role requires elevated system privilege.

When the variables `pip_conf_dir` and `pip_index_url` are provided then this role assumes that a custom
pip repository is required and will use the variables indicated below to construct the appropriate `pip.conf` file.

Role Variables
--------------
| Variable Name | Description |
| --- | --- |
| pip_conf_dir | Location of pip.conf file.  |
| pip_index_url | url of the custom repository |
| http_proxy | proxy variable to use if set |
| pip_trusted_hosts | Pip trusted hosts to use if set |
| pip_packages | Collection containing the pip packages to install |

    pip_packages:
    - httplib2
    - pexpect
    - passlib
    - urllib3
    - requests
    - six
    - pyOpenSSL

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-os-pip }

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
