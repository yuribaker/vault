#!/bin/bash

#Download
wget -O /tmp/splunk-8.2.6-a6fe1ee8894b-linux-2.6-x86_64.rpm "https://download.splunk.com/products/splunk/releases/8.2.6/linux/splunk-8.2.6-a6fe1ee8894b-linux-2.6-x86_64.rpm"
#Install
sudo rpm -i /tmp/splunk-8.2.6-a6fe1ee8894b-linux-2.6-x86_64.rpm
#Cleanup
rm /tmp/splunk-8.2.6-a6fe1ee8894b-linux-2.6-x86_64.rpm

#Add expect script later
#/opt/splunk/bin/splunk enable boot-start --accept-license
#user:admin
#pass:adminadmin

#/opt/splunk/bin/splunk start --accept-license

