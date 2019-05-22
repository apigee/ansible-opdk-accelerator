# Configure Ansible OPDK Accelerator Credentials

The credentials for the OPDK Accelerator are configured in the folder `~/.apigee-secure`. This folder contains the 
credentials to be used for the Apigee Planet in the file `credentials.yml`. This folder also contains the Apigee license 
material in a file named license.txt. 

# Required Credentials

Please note that you are required to provide two sets of credentials. The first credential gives you access to the Apigee
Software download site for the purpose of downloading Apigee Software. The second credential is the license material you 
received from Apigee that represents your license to use the Apigee software.  

## Update the Apigee User Name and Apigee User Password

Please update the `~/.apigee-secure/credentials.yml` file with the credentials you received credentials for the purpose 
of downloading Apigee software. The attributes `apigee_user_name` and `apigee_user_pass` should be updated with your
Apigee credentials. Please update the attributes in the following section near the top of the file 
`~/.apigee-secure/credentials.yml`:

        # Apigee Repo or Apigee Mirror credentials
        apigee_repo_user: "{{ apigee_provided_or_confirmed_username }}"
        apigee_repo_password: "{{ apigee_provided_password }}"
  
## License Material

The OPDK Accelerator expects to find the license material in the file `~/.apigee-secure/license.txt`. It is sufficient 
to create or update the file `~/.apigee-secure/license.txt` with a copy of the license material received from Apigee.

# Credentials File

The `~/.apigee/credentials.yml` file is heavily annotated. Please refer to this file to update the credentials you wish 
use on the platform. Please note that `apigee_user_name` and `apigee_user_pass` are credentials provided by Apigee and
should be used as provided. It is expected that the remaining credentials would be reviewed and updated accordingly.  

## Edge Administrative User

Please note that the initial credentials for the Edge Administrative user are set to defaults that should be considered 
unsecure. These defaults are suitable for test scenarios that are short lived and not exposed externally. Please update
the attributes `opdk_user_email` and `opdk_user_pass` when you are performing an installation to an environment that 
should be secured. Please update the attributes in the following section that appear near the top of the file 
`~/.apigee-secure/credentials.yml`:

        # Edge Admin User
        opdk_user_email: opdk@apigee.com
        opdk_user_pass: Apigee123!
