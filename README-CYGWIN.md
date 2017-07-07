# Setting Up Ansible with Cygwin

Running Ansible commands from within Windows is unsupported at the time of this writing.
However, windows users can setup Ansible with Cygwin.

# Installation Steps
Here are steps to getting Ansible (and it's related commands, like ansible-playbook) running on Windows:
Download and install [Cygwin](http://cygwin.com/install.html), with at least the following packages selected
(you can select the packages during the install process):

* curl
* python (2.7.x)
* python-jinja
* python-crypto
* python-openssl
* python-setuptools
* git
* vim
* openssh
* openssl
* openssl-devel
* wget
* gcc-core
* gcc-g++
* python2-devel
* python2-cython
* make
* libffi-devel

# Working Behind a Proxy
If you are working behind a proxy (as is the case in many corporate networks), edit the .bash_profile used by Cygwin either using vim (open Cygwin and enter vim .bash_profile), or with whatever editor you'd like, and add in lines like the following:

    export http_proxy=http://username:password@proxy-address-here:80/
    export https_proxy=https://username:password@proxy-address-here:80/

# Download and Install PyYAML and Jinja2 Separately
Download and install separately PyYAML and Jinja2 separately, as they're not available via Cygwin's installer:

## Open Cygwin

### Download PyYAML

    curl -O https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.10.tar.gz

### Download Jinja2

    curl -O https://pypi.python.org/packages/source/J/Jinja2/Jinja2-2.6.tar.gz

### Untar both downloads

    tar -xvf PyYAML-3.10.tar.gz && tar -xvf Jinja2-2.6.tar.gz

### Change directory into each of the expanded folders and run `python setup.py install` to install each package.

### Generate an SSH key for use later: `ssh-keygen` then hit enter to skip adding a password until you get back to the command prompt.

### Clone ansible from its repository on GitHub:

    git clone https://github.com/ansible/ansible /opt/ansible

### Add the following lines into your Cygwin .bash_profile after the proxy settings you added previously:

    # Ansible Settings
    ANSIBLE=/opt/ansible
    export PATH=$PATH:$ANSIBLE/bin
    export PYTHONPATH=$ANSBILE/lib
    export ANSIBLE_LIBRARY=$ANSIBLE/library

### Restart Cygwin and verify that `ansible --version` displays the ansible version.

# Configuring Pip on Cygwin
Pip does not work by default on Cygwin. Please follow these steps to ensure pip is configured correctly:

    python -m ensure pip


# Reference
[Running Ansible within Windows](https://www.jeffgeerling.com/blog/running-ansible-within-windows)