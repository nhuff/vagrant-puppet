#!/bin/bash

if [ ! -f /etc/yum.repos.d/puppetlabs.repo ]; then
  rpm -ivh http://yum.puppetlabs.com/el/6Server/products/x86_64/puppetlabs-release-6-6.noarch.rpm
fi
rpm -q puppet
if [ $? != 0 ]; then 
  yum -y install puppet
fi
service iptables status && service iptables stop
puppet apply --debug --verbose --modulepath=/vagrant/modules /vagrant/puppet-up.pp
