# Apigee Mirror Playbooks

These playbooks work to install and setup an Apigee Mirror in preparation for performing offline installations of 
the Apigee Edge Private Cloud. It should be understood that offline installations require the interaction of online and 
offline nodes. Consequently the playbooks are constructed to assist depending on whether you are performing online 
activities or offline activities. Complexity arises from the split between where the online activities can be performed 
and the location of the control server used to run these playbooks. These playbooks accommodate the construction of an
installation archive using either a separate online server or the use of the control server serving as the online server
such as a laptop.  

## Basic Configuration Assumptions

This playbook makes [these assumptions](../../installations/README.md#assumptions).

## Assumptions Regarding Online and Offline Activities

Despite the requirement to install Apigee Edge in an offline environment some activities must be performed 
[online](https://docs.apigee.com/private-cloud/v4.19.01/installation-overview#internet). 
Specifically we need to be online to create the installation archive. Following the creation of the installation archive
we need to download that archive and position it for upload and installation where the offline installation scripts can be
used to upload and install that archive. Once these processes are complete we can then proceed with an installation. The
installation can either be performed manually or with the installation scripts provided by this repository. 

## Online Activities
These playbook support the creation and download of an Apigee Mirror:
 
* [Create an Apigee Mirror](https://github.com/carlosfrias/apigee-opdk-setup-bootstrap-create-archive.git)
* [Download an Apigee Mirror](https://github.com/carlosfrias/apigee-opdk-setup-bootstrap-download-archive.git)

## Offline Activities
These playbooks support uploading and installing an Apigee Mirror: 
 
* [Upload an Apigee Mirror](https://github.com/carlosfrias/apigee-opdk-setup-bootstrap-upload-archive.git)
* [Install an Apigee Mirror](https://github.com/carlosfrias/apigee-opdk-setup-bootstrap-archive-installer.git)

# Apigee Mirror Repository
This playbook will upload and setup the Apigee Nginx web server so that the offline installation can be completed from a
central web server.

* [Setup the Apigee Nginx Web Server](https://docs.apigee.com/private-cloud/v4.17.01/install-edge-apigee-setup-utility#installedgeapigeesetuputilityonanodewithnoexternalinternetconnection-installapigeesetuponaremotenodefromthelocalrepo) as a yum repository for an offline Apigee Edge Private Cloud 
installation.
 
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

This playbook will invoke apigee-mirror package so that a tarball will be available for download. This 
playbook will use the attribute `archive_extra_packages` as a list of system packages that can be
downloaded and included in the apigee mirror archives. This is used to facilitate the distribution of 
system packages that are needed but not included in the apigee-mirror package. Any packages added to
this list will be located in the archive folder `repos/thirdparty/7`. 

## Usage of Create an Apigee Mirror

    ansible-playbook create-archive.yml -e target_hosts=mirror
         
# Download an Apigee Mirror
You can download an Apigee Mirror that was created with the `create-archive.yml` playbook. You will 
need to indicate the target host from which to download the mirror. You indicate the target host by 
passing `target_host` during the invocation of this playbook.
passing `target_host` during the invocation of this playbook.

This playbook will expect to find the Apigee Mirror archive located under `/opt/apigee/data/apigee-mirror`
using the Apigee naming convention `apigee-{{ opdk_version }}.tar.gz`. The archive will be downloaded
to the control server to the folder `~/.apigee/apigee-{{ opdk_version }}.tar.gz`.

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

# Update Custom Properties
Update the `apigee_archive_name` attribute with the name of the uploaded archive. This attribute is likely to be commented out in the `~/.apigee/custom-properties.yml` file. 


## Usage of Install an Apigee Mirror

    ansible-playbook install-archive.yml -e target_hosts=mirror

# Update Custom Properties

This playbook is will 
Update the `apigee_archive_name` attribute with the name of the uploaded archive. This attribute is 
likely to be commented out in the `~/.apigee/custom-properties.yml` file. The default naming convention
should be followed unless you are prepared to make appropriate changes throughout all of the variables
used by the playbooks.


    
<!-- BEGIN Google Required Disclaimer -->

# Not Google Product Clause

This is not an officially supported Google product.
<!-- END Google Required Disclaimer -->
<!-- BEGIN Google How To Contribute -->
# How to Contribute

We'd love to accept your patches and contributions to this project. Please review our [guidelines](CONTRIBUTING.md).
<!-- END Google How To Contribute -->
