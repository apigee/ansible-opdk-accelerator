OPDK Setup Default Settings
===========================

This role provides a set of default attributes that are persisted to the local Ansible cache and are used to install,
configure and maintain Apigee OPDK. 

Requirements
------------

No requirements

Role Variables
--------------

These are the variables used throughout the Apigee management framework. Defaults and initial value settings
are centrally managed here to reduce the maintenance burden. It is expected that specific variables would be
overriden as needed either by the playbook or at `~/.apigee/custom-properties.yml`.

## Core Variables Required by All Apigee Installation, Configuration & Maintenance Roles

| Variable Name | Default or Initial Value | Description |
| --- | --- | --- |
| opdk_version is  '4.18.01' | Default Apigee Edge Private Cloud Version |
| opdk_resources_path | "/tmp/edge" | Apigee staging installation folder |
| jdk_version | '1.8' | Target Java JDK version |
| java_home | /usr/lib/jvm/java-openjdk | System file path to use in JAVA_HOME |
| opdk_group_name |  '' | OPDK OS group name|
| opdk_user_email | '' | OPDK User Email |
| opdk_user_home | /home/{{ opdk_user_name }} | Home folder of the Apigee user |
| opdk_smtp_mail_from | {{ opdk_user_name }} | Home folder of the Apigee user |
| apigee_home | /opt/apigee | Default apigee installation home |
| opdk_license_target_file_path | "{{ opdk_resources_path }}/license.conf" | Apigee license file path |
| opdk_license_source_file_name | '~/.apigee/license.txt' | Apigee license file provided by customer |
| opdk_installation_config_file | "{{ opdk_resources_path }}/silent-install.conf" | Apigee silent installation configuration file |
| apigee_repo_uri | 'software.apigee.com' | Apigee bootstrap download uri |
| apigee_repo_url | 'https://{{ apigee_repo_uri }}' | Apigee bootstrap download url |
| provided_response_file | '' | Silent installation configuration file that is provided manually |
| apigee_validate_config_file | '{{ opdk_resources_path }}/apigee-validate.conf' | Apigee validate config file path |
| opdk_mp_pod | gateway | Apigee edge default pod for silent-config file |
| conf_logs_dir | planet_resources | Local folder in which to store logs and config files |
| fetched_logs_dir | ~/.apigee/planet_resources/ | Default download location for log and config files |
| fetched_configs_dir | ~/.apigee/planet_resources/ | Default download location for log and config files |
| opdk_enable_ax | 'y' | Default to enable analytics |
| opdk_use_cass_cluster | 'y' | Default setting to use a cassandra ring |
| opdk_use_zk_cluster | 'y' | Default to enable use of the zookeeper cluster |
| opdk_ldap_type | '1' | Default silent-install configuration file for OpenLDAP |
| use_opdk_ldap_remote_host | 'n' | Default silent-install configuration file for OpenLDAP |
| opdk_bind_on_all_interfaces | 'y' | Default to bind OPDK on all network interfaces |
| bootstrap_filename | bootstrap.sh | Name of Apigee bootstrap script 
| enable_system_check | 'n' | Enable system check during installation of Apigee component | 

## Analytic Settings for Edge Configuration

| Variable Name | Default or Initial Value | Description |
| --- | --- | --- |
| ax_group | axgroup001 | Default analytics group |

## SMTP Settings for Edge Configuration
| Variable Name | Default or Initial Value | Description |
| --- | --- | --- |
| opdk_smtp_skip | 'y' | SMTP settings for Edge Configuration | 
| opdk_smtp_host | 'smtp.example.com' | SMTP settings for Edge Configuration |
| opdk_smtp_port | '25' | SMTP settings for Edge Configuration |
| opdk_smtp_user | '' | SMTP settings for Edge Configuration |
| opdk_smtp_password | '' | SMTP settings for Edge Configuration |
| opdk_smtp_ssl | 'n' | SMTP settings for Edge Configuration |

## Rollback of Apigee Component defaults 
| Variable Name | Default or Initial Value | Description |
| --- | --- | --- |
| remove_apigee | false | Default settings for removing data on rollback |

## Apigee Archive & Mirror Configurations
| Variable Name | Default or Initial Value | Description |
| --- | --- | --- |
| copy_archive | yes | Choose whether to copy the Apigee Mirror archive from your control machine or use an existing archive on the server |
| archive_folder | {{ opdk_resources_path }}/tmp | Storage folder for the Apigee archive |
| archive_name | apigee-{{ opdk_version }}.tar.gz | Apigee archive that is created when a mirror is used. |
| archive_path | '{{ apigee_installation_home }}/data/apigee-mirror/{{ archive_name }}' | Path to the Apigee archive that is created by apigee-mirror package |
| apigee_data_backup_archive_name | apigee_data_backup.tar.gz | Default name of the backup archive of the apigee data folder |
| apigee_archive_storage_folder | '{{ opdk_resources_path }}' | Default folder in which the apigee data backup archive will be stored. |
| apigeereleasever | {{ opdk_version }} | Default version of the Apigee mirror to use |

## Apigee Credential Variable Names
| Variable Name | Default or Initial Value | Description |
| --- | --- | --- |
| opdk_user_name |  'apigee' | OPDK OS user name |
| opdk_user_pass | '' | OPDK User Password |
| admin_user | '{{ opdk_user_name }}' | Apigee admin user name |
| admin_pass | '{{ opdk_user_name }}' | Apigee admin user password |
| apigee_repo_user | '{{ opdk_user_name }}' | Apigee bootstrap download user name |
| opdk_ldap_pass | '' | 
| grafana_username | admin | Monitoring dashboard UI user name |
| grafana_password | {{ opdk_user_pass }} | Monitoring dashboard UI password |
| opdk_cass_username | '' | Cassandra username |
| opdk_cass_password | '' | Cassandra password |
| opdk_cass_auth | 'n' | Enable Cassandra authentication |

## Apigee Service Command Line Tools Variable Name    
| Variable Name | Default Value | Description |
|---------------|---------------|-------------|
| apigee_service | '{{ apigee_home }}/apigee-service/bin/apigee-service' | Apigee service command as of 4.16.xx |
| apigee_setup | '{{ apigee_home }}/apigee-setup/bin/setup.sh' | Apigee setup command as of 4.16.xx |
| apigee_update | '{{ apigee_home }}/apigee-setup/bin/update.sh' | Apigee update command as of 4.16.xx |
| apigee_all | '{{ apigee_home }}/apigee-service/bin/apigee-all' | Apigee all command as of 4.16.xx |
| nodetool | '{{ apigee_home }}/apigee-cassandra/bin/nodetool' | Cassandra nodetool command |
    
# Apigee Edge Ports

## Cassandra Ports
| Variable Name | Port Number |
| --- | --- |
| cassandra_jmx_port | 7199 |
| cassandra_thrift_client_port | 9160 |
| cassandra_cql_native_port | 9042 |
| cassandra_non_ssl_gossip_port | 7000 |
| cassandra_ssl_gossip_port | 7001 |

## Zookeeper Ports
| Variable Name | Port Number |
| --- | --- |
| zk_data_port | 2181 |
| zk_leader_port | 2888 |
| zk_voter_port | 3888 |

## Message Processor Ports
| Variable Name | Port Number |
| --- | --- |
| mp_int_mgmt_port | 4528 |
| mp_ext_mgmt_port | 8082 |
| mp_jmx_port | 1101 |
| mp_router_port | 8998 |

## Management Server Ports
| Variable Name | Port Number |
| --- | --- |
| ms_jmx_port | 1099 |
| ms_ext_mgmt_port | 8080 |

## Router Ports
| Variable Name | Port Number |
| --- | --- |
| router_jmx_port | 1100 |
| router_ext_mgmt_port | 8081 |
| router_int_mgmt_port | 4527 |
| router_load_balancer_port | 15999 |
    
## Qpid Ports 
| Variable Name | Port Number |
| --- | --- |
| qpid_jmx_port | 1102 |
| qpid_int_mgmt_port | 4529 |
| qpid_messaging_port | 5672 |
| qpid_ext_mgmt_port | 8083 |

## Postgres & PostgreSQL Ports
| Variable Name | Port Number |
| --- | --- |
| pg_jmx_port | 1103 |
| pg_int_mgmt_port | 4530 |
| pg_db_port | 5432 |
| pg_ext_mgmt_port | 8084 |

## Management UI Ports 
| Variable Name | Port Number |
| --- | --- |
| ui_http_port | 9000 |

## Default Message Processor Port 
| Variable Name | Port Number |
| --- | --- |
| edge_proxy_port | 9001 |

## OpenLDAP Port
| Variable Name | Port Number |
| --- | --- |
| ldap_data_port | 10389 |

## Monitoring Dashboard - Influxdb Port
| Variable Name | Port Number |
| --- | --- |
| influxdb_system_port | 25826 |
| influxdb_port | 8086 |
| influxdb_host | 127.0.0.1 

## Monitoring Dashboard - Grafana Port
| Variable Name | Port Number | Description |
| --- | --- | --- |
| grafana_port | 3000 | Grafana UI port |
    
## Configuring Edge Org and Virtual Host
| Variable Name | Port Number | Description |
| --- | --- | --- |
| org_name | opdk | Default org name |
| env_name | test | Default environment name |
| new_user | 'y' | Default for creating a new user in org |
| first_name | Opdk | Default for first_name in creating new user |
| last_name | User | Default for last_name in creating new user |
| virtual_host_port | 9001 | Virtual host port for the org |
| virtual_host_name | default | Virtual Host name for the org
| virtual_host_alias | '127.0.0.1' | Virtual host alias |
| onboarding_config | 'apigee-provision.conf' | Default onboarding provisioning file name |
| onboarding_config_file_path | "{{ opdk_resources_path }}/{{ onboarding_config }}" | Default onboarding provisioning file path |
| apigee_provision_dir | '{{ apigee_home }}/apigee-provision' | Default onboarding provisioning directory |

## Apigee Baas Core Attributes
| Variable Name | Port Number | Description |
| --- | --- | --- |
| opdk_baas_silent_install_file_path | '{{ opdk_resources_path }}/edge-baas-response.conf' | Default location and name of the Baas Silent Install file |
| opdk_baas_provided_silent_install_file | '' | Baas silent install file provided by customer |
| baas_cluster_name | 'apigee_baas' | Default cluster name is "apigee_baas" |
| baas_create_org_and_user_script | "{{ apigee_home }}/baas-usergrid/bin/create_org_and_user.py" | Script to create orgs and users on Baas |


## Apigee Baas SMTP Configuration
| Variable Name | Port Number | Description |
| --- | --- | --- |
| baas_smtp_host | 'smtp.gmail.com' | SMTP host server for BaaS |
| baas_smtp_port | '465' | SMTP port server for BaaS |
| baas_smtp_ssl | 'n' | SMTP SSL configuration for BaaS |

## Apigee Baas Ports
| Variable Name | Port Number | Description |
| --- | --- | --- |
| baas_load_balancer_host | '' | URL of the load balancer for the API BaaS Stack nodes or IP/DNS of a single Stack node with no load balancer |
| baas_load_balancer_port | '8080' | Port of the load balancer for the API BaaS Stack nodes or port of a single Stack node with no load balancer |
| baas_portal_port | '9000' | Default portal UI value is 9000 |
| baas_elasticsearch_port_low | '9200' | Default Elastic search low port |
| baas_elasticsearch_port_high | '9300' | Default Elastic search high port |
    
## Define the API BaaS Credentials
| Variable Name | Port Number |
| --- | --- |
| baas_admin_name | '' |
| baas_admin_email | '' |
| baas_admin_pass | '' |
| baas_superuser_name | '' |
| baas_superuser_email | '' |
| baas_superuser_pass | '' |
| baas_smtp_user | '' |
| baas_smtp_user_pass | '' |
    
## Default system config files to download

    system_config_files:
      - { dir: '/etc/', name: 'hosts' }
      - { dir: '/etc/', name: 'hosts.allow' }
      - { dir: '/etc/', name: 'hosts.deny' }
      - { dir: '/etc/', name: 'environment' }
      - { dir: '/etc/', name: 'profile' }
      - { dir: '/etc/', name: 'bashrc' }
      - { dir: '/etc/', name: 'resolv.conf' }
      - { dir: '/var/log/', name: 'messages' }
      - { dir: '/etc/', name: 'sysctl.conf' }
      - { dir: '/etc/', name: 'sudoers' }
      - { dir: '/etc/security/', name: 'limits.conf' }
      - { dir: '/etc/security/limits.d/', name: '*conf' }
    
    apigee_config_files:
      - { dir: '{{ opdk_resources_path }}/', name: '*conf' }
      - { dir: '{{ apigee_home }}/customer/', name: '*' }
      - { dir: '{{ apigee_home }}/apigee-cassandra/', name: '*yaml' }
      - { dir: '{{ apigee_home }}/etc/', name: 'default*.sh' }
    
    apigee_log_files:
      - { dir: '{{ opdk_resources_path }}/', name: '*.log' }
      - { dir: '{{ opdk_resources_path }}/var/log/', name: '*.log' }
      - { dir: '{{ opdk_resources_path }}/', name: '*.txt' }
      - { dir: '{{ apigee_home }}/var/log/', name: '*.log' }
      - { dir: '{{ apigee_home }}/', name: '*.out' }

Dependencies
------------

No dependencies

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: apigee-opdk-setup-default-settings }

License
-------

Apache License Version 2.0, January 2004

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