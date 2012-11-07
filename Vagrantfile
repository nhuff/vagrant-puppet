# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "centos63"
  config.vm.define :master do |master|
      master.vm.provision :shell, :path => "puppet-up.sh"
      master.vm.network :hostonly, '192.168.234.10'
      master.vm.host_name = 'master.vm'
  end
end
