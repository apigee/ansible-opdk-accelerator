Apigee OPDK Setup OS EPEL
=========

This repository contains an Ansible role that helps to setup epel on a node that will be used for the Apigee Platform.

Requirements
------------

The role requires elevated privilege. 

Role Variables
--------------

| Variable Name | Description |
| --- | --- |
| epel_repo | "https://dl.fedoraproject.org/pub/epel/epel-release-latest-{{ ansible_distribution_major_version }}.noarch.rpm" |


Dependencies
------------

* setup

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-os-epel }

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
