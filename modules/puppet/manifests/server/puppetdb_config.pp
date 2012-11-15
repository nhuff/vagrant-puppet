define puppet::server::puppetdb_config (
  $configdir,
  $host = $::fqdn,
  $port = '8081',
) {
  file{"${config_dir}/routes.yaml":
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/puppet/routes.yaml',
  }

  Ini_setting {
    ensure  => present,
  }

  ini_setting {'puppetdbserver':
    setting => 'server',
    section => 'main',
    path    => "${configdir}/puppetdb.conf",
    value   => $host,
  }

  ini_setting {'puppetdbport':
    setting => 'port',
    section => 'main',
    path    => "${configdir}/puppetdb.conf",
    value   => $port,
  }

  ini_setting{'puppetmasterstoreconfig':
    section => 'master',
    setting => 'storeconfigs',
    value   => true,
    path    => "${configdir}/puppet.conf",
  }

  ini_setting {'puppetmasterstorebackend':
    section => 'master',
    setting => 'storeconfigs_backend',
    value   => 'puppetdb',
    path    => "${configdir}/puppet.conf",
  }
} 
