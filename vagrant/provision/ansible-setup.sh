#!/bin/bash

# Simple function to exit with a message in the case of failure.
function error_exit
{
  echo ''
  echo "$1" 1>&2
  exit 1
}

echo ''
echo '======================================================================='
echo 'Setting up Ansible...'

if [ `which ansible` ]; then
  echo 'Ansible already installed.'
  exit 0
fi

echo ''
echo '======================================================================='
echo 'Updating apt and installing Ansible dependencies...'
aptitude -q=2 update > /dev/null || error_exit "Unable to update apt cache."
aptitude -q=2 -y install build-essential git python-dev \
python-jinja2 python-yaml python-paramiko python-software-properties \
python-pip debhelper python-support cdbs > /dev/null 2>&1 || error_exit "Unable to install required packages."

echo ''
echo '======================================================================='
echo 'Downloading Ansible...'
add-apt-repository ppa:rquillo/ansible
aptitude -q=2 update > /dev/null || error_exit "Unable to update apt cache."
aptitude -q=2 -y install ansible > /dev/null 2>&1 || error_exit "Unable to install required packages."

echo "localhost" > /etc/ansible/hosts

echo ''
echo 'Finished Ansible setup.'
echo ''
