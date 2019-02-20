Apigee Server Restart
=========

This role restarts a server. This is typically useful after making changes that take effect after a server restart. 

Requirements
------------

This role requires elevated system privilege.

Role Variables
--------------

| Variable | Default | Description |
|---|---|---|
| start_check_delay: | 15 | Delay in seconds to wait before checking server status |
| server_restart_timeout | 60 | Timeout in seconds that the server should have restarted by  |
    

Dependencies
------------

wait_for and shell modules

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: apigee-server-restart }

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