# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Which box?
  config.vm.box = "debian-wheezy"
  config.vm.box_url = "http://boxes.monsieurbiz.com/debian-wheezy.box"

  # Port forwarding
  config.vm.network :forwarded_port, guest: 1080, host: 1080, auto_correct: true
  config.vm.network :forwarded_port, guest: 9000, host: 9090, auto_correct: true

  # Network
  config.vm.network :private_network, ip: "10.0.0.2"
  config.hostmanager.enabled            = true
  config.hostmanager.manage_host        = true
  config.hostmanager.ignore_private_ip  = false
  config.hostmanager.include_offline    = true
  config.vm.hostname                    = "vagrant-mage.dev"
  config.hostmanager.aliases            = %w(vagrant-mage)

  # Synced folders
  config.vm.synced_folder "htdocs", "/var/www/magento", nfs: true,
                                    mount_options: ["nolock", "async"],
                                    bsd__nfs_options: ["alldirs","async","nolock"]

  # Virtualbox customization
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "2", "--pae", "on", "--hwvirtex", "on", "--ioapic", "on"]
  end

  # "Provision" with hostmanager
  config.vm.provision :hostmanager

  # Puppet!
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path   = "puppet/manifests"
    puppet.module_path      = "puppet/modules"
    puppet.manifest_file    = "init.pp"

    # Factors
    puppet.facter = {
        "vagrant"           => "1",
        "hostname"          => "vagrant-mage.dev",
        "db_root_password"  => "mysql",
        "db_user"           => "magento",
        "db_password"       => "magento",
        "db_name"           => "magento",
        "db_name_tests"     => "magento_tests",
        "document_root"     => "/var/www/magento",
        "logs_dir"          => "/var/www/logs",
    }
  end

end
