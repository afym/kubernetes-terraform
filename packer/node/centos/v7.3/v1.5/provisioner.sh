#!/bin/bash

# base update

sudo yum -y update

# base tools

sudo yum -y install vim htop telnet

# validating some services

if [ $(systemctl -q is-active firewalld) ] ; then
    sudo systemctl stop firewalld
    sudo systemctl disable firewalld
fi

# installing network time protocol

sudo yum -y install ntp
sudo systemctl start ntpd
sudo systemctl enable ntpd

# installing kubernetes 1.5

sudo yum -y install flannel kubernetes