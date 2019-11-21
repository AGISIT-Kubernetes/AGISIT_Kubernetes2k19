#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

# configure hosts file for the internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL

# vagrant environment nodes
192.168.56.9  mgmt
192.168.50.10  master
192.168.50.11  node-1
192.168.50.12  node-2
192.168.50.13  node-3
192.168.50.14  node-4
192.168.50.15  node-5
192.168.50.16  node-6
192.168.50.17  node-7
192.168.50.18  node-8
192.168.50.19  node-9
EOL
