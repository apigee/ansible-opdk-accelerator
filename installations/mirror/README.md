Apigee Mirror Playbooks
=============================

These playbooks work with an Apigee Mirror in preparation for performing offline installations of 
the Apigee Edge Private Cloud. These playbook support the Apigee Mirror creation process discussed 
in detail [here](https://docs.apigee.com/private-cloud/v4.17.01/install-edge-apigee-setup-utility).
These playbooks perform the following functions:
 
* [Create an Apigee Mirror](https://github.com/carlosfrias/apigee-opdk-setup-bootstrap-create-archive.git)
* [Download an Apigee Mirror](https://github.com/carlosfrias/apigee-opdk-setup-bootstrap-download-archive.git) 
* [Upload an Apigee Mirror](https://github.com/carlosfrias/apigee-opdk-setup-bootstrap-upload-archive.git)
* [Install an Apigee Mirror](https://github.com/carlosfrias/apigee-opdk-setup-bootstrap-archive-installer.git)
* Setup the Apigee Nginx Web [server](https://docs.apigee.com/private-cloud/v4.17.01/install-edge-apigee-setup-utility#installedgeapigeesetuputilityonanodewithnoexternalinternetconnection-installapigeesetuponaremotenodefromthelocalrepo) as a yum repository for an offline Apigee Edge Private Cloud 
installation.
 
# Assumptions

* These playbooks assume that you have configured an `ansible.cfg` that indicates the location of the 
inventory and Ansible roles.
* This playbook assumes you have invoked `ansible-galaxy install -r requirements.yml -f`

# Usage

We recommend that you invoke these playbooks in the following sequence:

1. [create-archive.yml](#creating-an-apigee-mirror) 
1. [download-archive.yml](#download-an-apigee-mirror)
1. [upload-archive.yml](#upload-an-apigee-mirror)
1. [install-archive.yml](#install-an-apigee-mirror)
 
# Creating an Apigee Mirror
You can create an Apigee Mirror with the `create-archive.yml` playbook. You will need to indicate the 
target host that should be used to create the mirror. The target host is optimally a machine with
internet access. You indicate the target host by passing `target_host` during the invocation of this
script.

## Usage of Create an Apigee Mirror

    ansible-playbook create-archive.yml -e target_hosts=mirror
         
# Download an Apigee Mirror
You can download an Apigee Mirror that was created with the `create-archive.yml` playbook. You will 
need to indicate the target host from which to download the mirror. You indicate the target host by 
passing `target_host` during the invocation of this script.

## Usage of Download an Apigee Mirror
 
    ansible-playbook download-archive.yml -e target_hosts=mirror

# Upload an Apigee Mirror
You can upload an Apigee Mirror that is available on the local host after it was downloaded with
`download-archive.yml`. You will need to indicate the 
target host to which the mirror will be uploaded. You indicate the target host by passing 
`target_hosts` during the invocation of this script.

## Usage of Upload an Apigee Mirror
   
    ansible-playbook upload-mirror.yml -e target_hosts=mirror
    
# Install an Apigee Mirror
You can install an Apigee Mirror that has been placed on a target host after it was downloaded with 
`upload-mirror.yml`. You will need to indicate the 
target host where the mirror will be installed. You indicate the target host by passing 
`target_host` during the invocation of this script.


## Usage of Install an Apigee Mirror

    ansible-playbook install-archive.yml -e target_hosts=mirror
    
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->