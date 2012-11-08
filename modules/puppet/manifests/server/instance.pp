define puppet::server::instance (
  $configdir,
  $port        = '8140',
  $rundir      = '',
  $logdir      = '',
  $vardir      = '',
  $manifestdir = '',
  $modulepath  = '',
) {
  include puppet::server
  include puppet::server::params
  $r_rundir = $rundir ? {
    ''      => $puppet::server::params::rundir,
    default => $rundir,
  }
  $r_logdir = $logdir ? {
    ''      => $puppet::server::params::logdir,
    default => $logdir,
  }
  $r_vardir = $vardir ? {
    ''      => $puppet::server::params::vardir,
    default => $vardir,
  }
  $r_manifestdir = $manifestdir ? {
    ''      => "${configdir}/manifests",
    default => $manifestdir,
  }
  $r_modulepath = $modulepath ? {
    ''      => "${configdir}/modules:/usr/share/puppet/modules",
    default => $modulepath,
  }
  file{$configdir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  Ini_setting{
    path    => "${configdir}/puppet.conf",
    section => 'master',
    ensure  => 'present',
    require => File[$configdir],
  }
  ini_setting {"psi-${title}-masterport":
    setting => 'masterport',
    value   => $port,
  }
  ini_setting{"psi-${title}-vardir":
    setting => 'vardir',
    value   => $r_vardir,
  }
  ini_setting{"psi-${title}-logdir":
    setting => 'logdir',
    value   => $r_logdir,
  }
  ini_setting{"psi-${title}-rundir":
    setting => 'rundir',
    value   => $r_rundir,
  }
  ini_setting{"psi-${title}-pidfile":
    setting => 'pidfile',
    value   => "${r_rundir}/${title}.pid",
  }
  ini_setting{"psi-${title}-ssldir":
    setting => 'ssldir',
    value   => "${r_vardir}/ssl",
  }
  ini_setting{"psi-${title}-manifestdir":
    setting => 'manifestdir',
    value   => $r_manifestdir,
  }
  ini_setting{"psi-${title}-modulepath":
    setting => 'modulepath',
    value   => $r_modulepath,
  }
  exec{'puppetmaster':
    command => "/usr/bin/puppet master --confdir=${configdir}",
    unless  => '/usr/bin/pgrep -u puppet puppet',
  }
}
