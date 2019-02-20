Apigee Settings for Postgres
=========

This role updates the Ansible cache with attributes that are used to generate templates and make 
installation decisions. 

This role will add the following attributes to the Ansible cache: 
* pg_ip
* pgmaster_ip, if pgmaster is configured
* pgstandby_ip, if pgmaster is configured then this required
* psql
* pg_dump
* apigee_postgresql_data_dir
* apigee_home


Requirements
------------

N/A

Role Variables
--------------

| Name | Description |
| --- | --- |
| pg_ip | IP address of postgres or postgres master if configured |
| pgmaster_ip | IP address of postgres master if configured |
| pgstandby_ip | IP address of postgres standby if postgres master is configured |
| psql | Postgres command line tool. Default: `/usr/bin/psql` |
| pg_dump | Postgres dump. Default: `/usr/bin/pg_dump` |
| apigee_postgresql_data_dir | Apigee Postgres Data Directory. Default: `{{ apigee_home }}/data/apigee-postgresql/pgdata` |
| apigee_home | Apigee default installation folder. Default: `/opt/apigee` |
| [dc-1-pg] | Inventory group for postgres |
| [dc-1-pgmaster] | Inventory group for postgres master |
| [dc-1-pgstandby] | Inventory group for postgres standby |

Dependencies
------------

N/A

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apige-opkd-settings-postgres }

License
-------

Apache 2.0

Author Information
------------------

Carlos Friasa
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->