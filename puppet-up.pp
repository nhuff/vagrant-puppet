node default {
  include apache
  include apache::mod_ssl

  apache::conf_snippet{'proxy':
    content => "LoadModule proxy_module modules/mod_proxy.so\nLoadModule proxy_http_module modules/mod_proxy_http.so\n",
  }
  
  puppet::server::instance{'master1':
    configdir => '/etc/puppet/master1',
    manifestdir => '/vagrant/manifests',
    modulepath => '/vagrant/modules',
  }
  unicorn::instance{'master1':
    basedir     => '/etc/puppet/master1',
    port        => '18140',
  }
  $puppet_port = '8140'
  $unicorn_port = '18140'
  $puppet_vardir = '/var/lib/puppet'
  apache::vhost{'pupppet-master1':
    content => template('puppet/apache_vhost.erb'),
  }
  Yumrepo<| |> -> Package<| |>
  yumrepo{'ahc':
    baseurl         => 'http://config.ahc.umn.edu/repo/RHEL/$releasever/$basearch',
    descr           => 'Repo for in house built rpms',
    enabled         => '1',
    gpgcheck        => '0',
    metadata_expire => '180',
    name            => 'ahc',
  }
  package{'epel-release':
    ensure => 'latest',
  }
}
