# Post-Installations Folder 

This folder contains Ansible playbooks that will execute post-installation configurations or maintenance
steps on Apigee components and planets.

The available Apigee components are: 

| Component Name | Description | 
|--- | --- |
| [apigee-user](apigee-user) | Ensures that the `apigee` user exists and that Apigee folders are owned by the `apigee` user. |
| [debug-mode](debug-mode) | Updates Apigee system scripts to emit debugging information. This generates a great deal of output when executing Apigee system scripts. |
| [unlock-edge-user-account](unlock-edge-user-account) | This will unlock a user that has been locked out of an Apigee Edge console. |
| [update-scope](update-analytics-scope) | This script will update the analytics scopes. |
| [validations](validations) | Multiple scripts are provided to validate the status of components used on the Apigee Edge platform. |
| [download-logs](download-logs) | Provides you with the ability to download the logs from the entire Apigee planet or from select nodes. |

