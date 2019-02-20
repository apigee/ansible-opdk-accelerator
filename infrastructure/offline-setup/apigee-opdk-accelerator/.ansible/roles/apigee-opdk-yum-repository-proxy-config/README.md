Apigee OPDK Yum Repository Proxy Config
=========

This role will enable add a proxy setting to the Yum apigee.repo file.

Requirements
------------

None

Role Variables
--------------

This role uses the variable `yum_repositories`. This variable must be defined for each yum repository as follows:

    yum_repositories:
    - { name: "Apigee $apigeestage repo",
        baseurl: "$apigeeprotocol$apigeecredentialswithat$apigeerepohost$apigeerepobasepath/apigee/$apigeestage/$apigeereleasever",
        repo_id: "apigee-$apigeestage",
        gpgcheck: "1",
        gpgkey: "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-apigee",
        priority: "$apigeepriority",
        exclude: "$apigeeexclude",
        repo_filename: "apigee",
        sslverify: false
      }
    - { name: "Apigee Thirdparty Repo",
        repo_id: "apigee-thirdparty",
        baseurl: "$apigeeprotocol$apigeecredentialswithat$apigeerepohost$apigeerepobasepath/thirdparty/$releasever",
        gpgcheck: "0",
        gpgkey: "",
        priority: "$apigeepriority",
        exclude: "" ,
        repo_filename: "apigee",
        sslverify: false
      }


Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      vars:
      yum_repositories:
      - { name: "Apigee $apigeestage repo",
          baseurl: "$apigeeprotocol$apigeecredentialswithat$apigeerepohost$apigeerepobasepath/apigee/$apigeestage/$apigeereleasever",
          repo_id: "apigee-$apigeestage",
          gpgcheck: "1",
          gpgkey: "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-apigee",
          priority: "$apigeepriority",
          exclude: "$apigeeexclude",
          repo_filename: "apigee",
          sslverify: false
        }
      - { name: "Apigee Thirdparty Repo",
          repo_id: "apigee-thirdparty",
          baseurl: "$apigeeprotocol$apigeecredentialswithat$apigeerepohost$apigeerepobasepath/thirdparty/$releasever",
          gpgcheck: "0",
          gpgkey: "",
          priority: "$apigeepriority",
          exclude: "" ,
          repo_filename: "apigee",
          sslverify: false
        }
 
      roles:
         - { role: apigee-opdk-yum-repository-proxy-config }

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
