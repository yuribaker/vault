#!/bin/sh

HOSTS_FILE="$HOME/whereToInstallUF"

# Set the install file name to the name of the file that wget downloads
# (the second argument to wget)
INSTALL_FILE="splunkforwarder..."


# Set the new Splunk admin password
PASSWORD="newpassword"

# ----------- End of user settings -----------

# create script to run remotely. Watch out for line wraps, esp. in the "set deploy-poll" line below.  
# the remote script assumes that 'splunkuser' (the login account) has permissions to write to the
# /opt directory (this is not generally the default in Linux)

wget -O /tmp/splunkforwarder-8.2.6-a6fe1ee8894b-Linux-x86_64.tgz "https://download.splunk.com/products/universalforwarder/releases/8.2.6/linux/splunkforwarder-8.2.6-a6fe1ee8894b-Linux-x86_64.tgz"
tar xzvf /tmp/splunkforwarder-8.2.6-a6fe1ee8894b-Linux-x86_64.tgz -C /opt/
# /opt/splunkforwarder/bin/splunk enable boot-start -user splunkusername
/opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --auto-ports --no-prompt

sudo bash -c "cat >/opt/splunkforwarder/etc/system/local/user-seed.conf" << EOF
[user_info]
USERNAME = admin
PASSWORD = adminadmin
EOF
/opt/splunkforwarder/bin/splunk restart

/opt/splunkforwarder/bin/splunk set deploy-poll 192.168.13.101:8089 --accept-license --answer-yes --auto-ports --no-prompt  -auth admin:adminadmin
# /opt/splunkforwarder/bin/splunk edit user admin -password $PASSWORD -auth admin:changeme
