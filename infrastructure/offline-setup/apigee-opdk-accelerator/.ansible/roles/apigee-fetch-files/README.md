# Apigee Fetch Files

This role will download logs and configuration files from a node used to install an Apigee platform component.

# Requirements

None

# Role Variables

| Variable Name | Description |
| --- | --- |
| download_pattern | This is a collection that indicates the directory and file pattern to find |
| download_folder | This indicates the folder on the control server where the files should be placed | 

The `download_pattern` collection should be structured in the following way: 

     pattern:
        - { dir: '/tmp', pattern: 'setup*.log' }
        - { dir: '{{ opdk_resources_path }}/', pattern: '*' }
        - { dir: '{{ opdk_resources_path }}/', pattern: '*.log' }
        - { dir: '{{ opdk_resources_path }}/', pattern: '*.txt' }
        - { dir: '{{ opdk_resources_path }}/', pattern: '*.conf' }
        - { dir: '{{ opdk_resources_path }}/', pattern: '*.sh' }
        - { dir: '{{ apigee_home }}/', pattern: '*.out' }
        - { dir: '{{ apigee_home }}/var/log', pattern: '*.log' }
        - { dir: '{{ apigee_home }}/customer/', pattern: '*' }
        - { dir: '{{ apigee_home }}/etc/', pattern: 'default*.sh' }
        - { dir: '{{ apigee_home }}/customer', pattern: '*' }
        - { dir: '{{ apigee_home }}/apigee-cassandra/', pattern: '*conf' }
        - { dir: '{{ apigee_home }}/apigee-cassandra/', pattern: '*yaml' }
        - { dir: '{{ apigee_home }}/apigee-cassandra/', pattern: '*properties' }
        - { dir: '{{ apigee_home }}/apigee-zookeeper/', pattern: '*conf' }
        - { dir: '{{ apigee_home }}/apigee-zookeeper/', pattern: '*properties' }
        - { dir: '{{ apigee_home }}/apigee-postgresql/', pattern: '*conf' }

# Dependencies

None

# Example Playbook

    - hosts: servers
      roles: 
        - { role: apigee-fetch-files, download_pattern: '{{ pattern }}', download_folder: "~/.apigee/planet_logs" }

# License

Apache 2.0

# Author Information

Carlos Frias


# Required Disclaimer

This is not an officially supported Google product.
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->
