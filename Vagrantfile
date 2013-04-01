# -*- mode: ruby -*-
# vi: set ft=ruby:

Vagrant::Config.run do |config|
  config.dns.tld           = 'dev.services.gov.uk'
  config.dns.patterns      = [/^.*dev.service.gov.uk$/]
  config.ssh.forward_agent = true
  config.vm.box            = 'ubuntu-precise-cloud-image'
  config.vm.box_url        = 'http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-vagrant-amd64-disk1.box'
  config.vm.customize        ["modifyvm", :id, "--rtcuseutc", "on"]
  config.vm.customize        ['modifyvm', :id, '--memory', 1024]
  config.vm.customize        ['modifyvm', :id, '--cpus', 2]
  config.vm.customize        ['modifyvm', :id, '--name', 'ubuntu-1204-dev']
  config.vm.host_name      = 'vm.dev.services.gov.uk'
  if File.exist? 'Vagrantfile.local'
    instance_eval File.read('Vagrantfile.local'), 'Vagrantfile.local'
  end
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path  = "manifests"
    puppet.manifest_file   = "site.pp"
    puppet.module_path     = "modules"
  end
end
