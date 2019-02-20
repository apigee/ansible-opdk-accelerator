Apigee OPDK Restore
===================

This role performs a restore using the apigee-service utility. This role 
requires that you indicate which backup to restore.

Requirements
------------

It is expected that the apigee-service utility was used as described at 
[How to Perform a Backup](http://docs.apigee.com/private-cloud/latest/how-perform-backup). 

Role Variables
--------------

#### backup_time

This variable contains the date and time of the backup that should be 
restored. The naming convention of the backup files is explained at
[How to Perform a Backup](http://docs.apigee.com/private-cloud/latest/how-perform-backup).     
This variable expects the date and time value to be set using the pattern: 

    backup_time: (year).(month).(day),(hour).(min).(seconds)

#### component_name
    
This variable expects the name of an apigee component to be restored.

Dependencies
------------

- apigee-opdk-setup-default-settings

Example Playbook
----------------

Example usage in a playbook:

    - hosts: pg
      roles:
         - { role: apigee-opdk-restore, component_name: apigee-cassandra, backup_time: 2016.10.27,08.45.35 }

License
-------

Apache

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
