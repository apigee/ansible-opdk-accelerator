# Configure Ansible OPDK Accelerator Credentials

The credentials for the OPDK Accelerator are configured in the folder `~/.apigee-secure`. This folder contains the 
credentials to be used for the Apigee Planet in the file `credentials.yml`. This folder also contains the Apigee license 
material in a file named license.txt. 

# Minimal Required Credentials

Please update the `~/.apigee-secure/credentials.yml` file with the credentials you received credentials for the purpose 
of downloading Apigee software. The attributes `apigee_user_name` and `apigee_user_pass` should be updated with your
Apigee credentials. 

        # Apigee Repo or Apigee Mirror credentials
        apigee_repo_user: "{{ apigee_provided_or_confirmed_username }}"
        apigee_repo_password: "{{ apigee_provided_password }}"
  

## Credentials File

The `~/.apigee/credentials.yml` file is heavily annotated. Please refer to this file to update the credentials you wish 
use on the platform. Please note that `apigee_user_name` and `apigee_user_pass` are credentials provided by Apigee and
should be used as provided. It is expected that the remaining credentials would be reviewed and updated accordingly.  