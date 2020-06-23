#!/usr/bin/env bash
sudo yum update -y
sudo yum install python3 -y
sudo alternatives --set python /usr/bin/python3
pip3 install ansible --user
