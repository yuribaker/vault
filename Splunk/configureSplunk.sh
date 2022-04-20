#!/bin/bash

#Download
wget -O /tmp/splunk-8.2.6-a6fe1ee8894b-Linux-x86_64.tgz "https://download.splunk.com/products/splunk/releases/8.2.6/linux/splunk-8.2.6-a6fe1ee8894b-Linux-x86_64.tgz"
#Install
tar xvfz /tmp/splunk-8.2.6-a6fe1ee8894b-Linux-x86_64.tgz -C /opt/
#Cleanup
rm /tmp/splunk-8.2.6-a6fe1ee8894b-Linux-x86_64.tgz

#Add expect script later
#/opt/splunk/bin/splunk enable boot-start --accept-license
#user:admin
#pass:adminadmin

#/opt/splunk/bin/splunk start --accept-license
