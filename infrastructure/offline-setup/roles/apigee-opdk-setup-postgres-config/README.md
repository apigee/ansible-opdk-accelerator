Apigee OPDK Setup Postgres Config
=========

This role performs configurations that are only required for Postgres instances used with the Apigee platform. The 
database folder can be removed if the `clear_pgdata` flag is set.

Requirements
------------

The role `apigee-opdk-setup-default-settings` addes the variable `apigee_postgresql_data_dir` to the cache for use 
throughout the framework.


Role Variables
--------------

The variable `apigee_postgresql_data_dir` is used to reference the location of the PostgreSQL database folder. 

    apigee_postgresql_data_dir: '{{ apigee_home }}/data/apigee-postgresql/pgdata'

The variable `clear_pgdata` is used to indicate that the data folder for PostgreSQL should be deleted and cleared of 
any data. The variable `clear_pgdata` is defaulted to False.

Dependencies
------------

* apigee-opdk-setup-default-settings

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-default-settings }

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
