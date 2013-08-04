# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Which box?
  config.vm.box = "debian-wheezy"
  config.vm.box_url = "http://boxes.monsieurbiz.com/debian-wheezy.box"

  # Port forwarding
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 3306, host: 3307
  config.vm.network :forwarded_port, guest: 1080, host: 1080

  # Network
  config.vm.network :private_network, ip: "10.0.0.2"

  # Synced folders
  config.vm.synced_folder "htdocs", "/var/www/magento", :nfs => true

  # Virtualbox customization
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end
  
  # Puppet!
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path   = "puppet/manifests"
    puppet.module_path      = "puppet/modules"
    puppet.manifest_file    = "init.pp"

    # Factors
    puppet.facter = {
        "vagrant"           => "1",
        "hostname"          => "super-cool.com",
        "db_root_password"  => "mysql",
        "db_user"           => "magento",
        "db_password"       => "magento",
        "db_name"           => "magento",
        "document_root"     => "/var/www/magento",
        "logs_dir"          => "/var/www/logs",
    }
  end

end
