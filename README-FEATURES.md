# Apigee OPDK Ansible Playbook Features

The roles and playbooks managed with this repository provide the following functionality: 

| Topology Feature | Description |
| --- | --- |
| Region Count | 2(stable), 3-5(tested), more than 5 |
| Host count | Any |
| Datastore count | Any |
| Management server count |	Any |
| OpenLDAP count | 2 |
| RMP count	| Any |
| Qpid count | Any |
| Analytics PostgreSQL count | Any |
| Developer portal count | Any |
| Developer portal PostgreSQL count | Any |
| PostgreSQL replication (2 nodes) | Y |
| OpenLDAP replication (2 nodes) | Y |
| PostgreSQL replication (3+ nodes) | Y |
| OpenLDAP replication (3+ nodes) | N |

| Infrastructure and OS Feature | Description |
| --- | --- |	
| Infrastructure generation AWS	| Y |
| Infrastructure generation GCP	| Y |
| OS configuration RHEL 7.x	| Y |
| OS configuration CentOS 7.x | Y |
| OS configuration Oracle Linux 7.x	| Y |
| OS configuration Suse 7.x	| Y (not tested) |

| Prerequisites Features | Description |	
| --- | --- |
| JDK installation | Y |
| EPEL | Y |
| Manage Customer Custom Yum Repos | Y |
| Manage Customer Custom Pip Repos | Y |
| Manage Installation with Proxy Usages | Y |
| SELinux | Y |
| Apigee user/group (distinct from installer) | Y |
| Alternate installation root | Y |
| System limits | Y |
| Create local mirror | Y |

| Installation Features | Description |
| --- | --- |	
| Create local mirror, tarball and configure Nginx | Y |
| Install from local mirror or tarball | Y |
| Edge bootstrap | Y |
| Edge setup | Y |
| Developer portal bootstrap | Y |
| Developer portal setup | Y |
| Edge Micro Setup | Y |
| Manage Linked Directories | Y |
| Baas bootstrap | Y |
| Baas setup | Y |
| Cassandra authentication | Y |
| PostgreSQL authentication | Y |

| Post install features | Description |
| --- | --- | 	
| Validation | Y |
| Analysis Scripts | Y |
| Cassandra maintenance jobs | Y |
| PostgreSQL maintenance jobs | Y |
| Service autostart | Y |
| Disable password expiration | N |

| Onboarding Features | Description |
| --- | --- |	
| Single Organization creation | Y |
| Multiple Organization Creation | Y |
| Single Environment creation | Y |
| Multiple Environment Creation | Y |
| Virtual host creation | Y |
| Organization addition | Y |
| Environment addition | Y |
| Virtual host addition | Y |

| Miscellaneous Features | Description |
| --- | --- |	
| Execution time | Depending on pre-requisites compliance |
| Idempotent | Y |
| Ansible environment setup summary	| https://github.com/carlosfrias/apigee-opdk-playbook-setup-ansible |
| Templates for Fast Ansible Configuration | Y 
| Templates for Apigee Properties | Y |
| Encryption with Vault for Apigee Properties | Y |
| Templates for Managing Secure Apigee Properties | Y |
| Encryption with Vault for Secure Apigee Properties | Y |
| Pre-Requisites Validation | Y |
| Documented for Self Service | Y |
| Distribution Ready Tarball | Y |
| Distribution Ready Github.com	| Y |
| Distribution Ready Ansible Galaxy | Y |
| Managing AWS Instances | Y |
| Managing GCP Instances | Y |
| Apigee Installation Scripts Debug Mode | Y |
| Manage Apigee Node Rollback | Y |
| Manage OS Pre-Requisites | Y |
| Manage Apigee Upgrades | Y |
| Manage Planet Expansions | Y |
| Manage Monetization Installation | Y |
| Manage Monitoring Dashboard Installation | Y |
| Retrieve Apigee Logs & Node OS Config File | Y |
| Generation of Apigee Configuration Filea | Y |
| Manage Multiple CWC File Configurations | Y |
| Manage Edge TLS | Y |
| Manage Router MP TLS | N |
| Manage MP Downstream TLS | Y(Almost complete) |
| Manage Custom License Files | Y |
| Manage Cassandra Maintenance Issues | Y |
| Manage Backup and Restore	| Y |
| Manage Postgres Failover | Y |
| Manage Add/Remove Analytics Groups | Y |
| Manage Custom MP Pod Associations	| Y |
| Manage Edge Installation by Version | Y |