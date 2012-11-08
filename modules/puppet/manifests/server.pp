class puppet::server {
  package{'puppet-server': ensure => 'installed'}
  service{'puppetmaster': ensure => 'stopped'}
}
