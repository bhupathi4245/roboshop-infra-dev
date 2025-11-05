#!/bin/bash

component=$1
dnf install ansible -y
ansible-pull -U https://github.com/bhupathi4245/ansible-roboshop-roles.git -e component=$1 main.yaml