# Configuring Credentials
Credentials are stored at `~/.apigee/credentials.yml`. A template file is created that includes
commented out attributes as placeholders for values that could be needed.

# Credentials Location
The `credentials.yml` file has been placed in your user home which is typically referenced by
`~/.apigee`. This location has been selected because of the security it affords the user. Please
note that the scripts expect to find the `credentials.yml` file in the folder `~/.apigee`.

## Required Credentials
The following table depicts those credentials that are required to complete an
Apigee installation. If these are not provided, then the apigee installation
scripts will prompt you for them. Given that this is an automated framework
that will orchestrate your Apigee installation it is necessary to provide these
attributes ahead of time in the  `~/.apigee/credentials.yml` file.

| Required Attribute | Value | Description |
|---|---|---|
| apigee_repo_user | APIGEE_REPOSITORY_USERNAME | The verizon user to login to the software.apigee.com |
| apigee_repo_password |  APIGEE_REPOSITORY_PASSWORD | The login password to software.apigee.com |
| opdk_user_name | apigee | The Apigee administrator username and operating system username |
| opdk_group_name | apigee | The operating system group name |
| opdk_user_email | APIGEE_ADMIN_EMAIL | The email address for the Apigee administrator |
| opdk_user_pass | APIGEE_ADMIN_PASSWORD | The password used by the Apigee Administrator |
| opdk_cass_username |  cassandra | The Cassandra username |
| opdk_cass_password | cassandra | The Cassandra password |
| opdk_ldap_pass | APIGEE_LDAP_PASSWORD | The Apigee LDAP password |
| pg_user | admin | The Postgres database administrator username |
| pg_pass | postgres | The Postgres database administrator password |

## Optional Credentials

The following table depicts those credentials that are not a part of the Apigee installation.
These can be provided here or they may be provided by any of the other mechanisms that Ansible
uses to accept parameters such as `vars_files`, `-e ATTRIBUTE_NAME=ATTRIBUTE_VALUE`, an inventory
file or a group or host variable files.

| Optional Attribute | Value | Description |
|---|---|---|
| service_account_authorization_token | "Basic BASE64_ENCODED_USERNAME_PASSWORD" | Authorization header value to be used when registering the instance with Cyberark |
| aws_access_key | AWS_ACCESS_KEY | AWS access key |
| aws_secret_key | AWS_SECRET | AWS secret |
| aws_region | AWS_REGION | AWS region |
| security_group | AWS_SECURITY_GROUP_NAME | AWS security group name |
| key_name | AWS_KEY_PAIR_NAME | AWS key pair name used for access |
| grafana_username | GRAFANA_USERNAME | Used if installing the Apigee monitoring dashboard |
| grafana_password | GRAFANA_PASSWORD | Used if installing the Apigee monitoring dashboard |
| opdk_smtp_user | SMTP_USERNAME | Username of the SMTP server that Edge will use to send notifications to developers |
| opdk_smtp_password | SMTP_Password | Password for the SMTP server that Edge will use to send notifications to developers |
| baas_admin_name | BAAS_ADMIN_NAME | The Apigee Baas administrator username, please note that baas_admin_email cannot be the same as  baas_superuser_email |
| baas_admin_password | BAAS_ADMIN_PASSWORD | The Apigee Baas administrator password |
| baas_admin_email | BAAS_ADMIN_EMAIL | The Apigee Baas administrator email |
| baas_admin_pass | BAAS_ADMIN_PASS | The Apigee Baas administrator email password |
| baas_superuser_email | BAAS_SUPERUSER_EMAIL | Email of the Baas Superuser, please note that baas_superuser_email cannot be the same as baas_admin_email |
| baas_superuser_name | BAAS_SUPERUSER_NAME | Name of the Baas Superuser |
| baas_superuser_pass | BAAS_SUPERUSER_PASSWORD | Password of the Baas Superuser |
| baas_smtp_user | BAAS_SMTP_USER | Username of the SMTP server that Baas will use to send notifications to developers |
| baas_smtp_user_pass | BAAS_SMTP_USER_PASS | Password for the SMTP server that Baas will use to send notification to developers |
