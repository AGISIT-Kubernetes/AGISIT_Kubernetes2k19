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
EOL

pkexec --user vagrant ssh-keygen -t rsa -b 2048 -P "" -f "/home/vagrant/.ssh/id_rsa"
ssh-keyscan master >> /home/vagrant/.ssh/known_hosts

for i in {1..2}
do
cat >> /etc/hosts <<EOL
192.168.50.$((10 + i))  node-$i
EOL
ssh-keyscan node-$i >> /home/vagrant/.ssh/known_hosts
done
