node default {
  puppet::server::instance{'master1':
    configdir => '/etc/puppet/master1',
    manifestdir => '/vagrant/manifests',
    modulepath => '/vagrant/modules',
  }
}
