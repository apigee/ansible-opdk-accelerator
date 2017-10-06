# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
HTTP_PROXY_HOST="{{ host:port }}"
HTTPS_PROXY_HOST="{{ host:port }}"
alias proxify="export http_proxy=$HTTP_PROXY_HOST; export https_proxy=$HTTPS_PROXY_HOST"
alias unproxify="unset http_proxy https_proxy"

