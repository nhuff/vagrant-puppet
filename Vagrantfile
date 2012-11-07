# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "centos63"
  config.vm.box_url = 'https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box'
  config.vm.define :master do |master|
      master.vm.provision :shell, :path => "puppet-up.sh"
      master.vm.network :hostonly, '192.168.234.10'
      master.vm.host_name = 'master.vm'
  end
  config.vm.define :client do |client|
    client.vm.network :hostonly, '192.168.234.11'
    client.vm.host_name = 'client.vm'
  end
end
