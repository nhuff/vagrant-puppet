#!/bin/sh
grep master /etc/hosts
if [ $? != 0 ]; then
  echo '192.168.234.10 master master.vm' >> /etc/hosts
fi
/usr/bin/puppet agent --test --server master.vm
