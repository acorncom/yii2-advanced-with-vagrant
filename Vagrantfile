# -*- mode: ruby -*-
# vi: set ft=ruby :
# Some info on how to adjust this file: http://garylarizza.com/blog/2013/02/01/repeatable-puppet-development-with-vagrant/

hostname = "www.yii2.dev"

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # VMWare Fusion customization
  config.vm.provider :vmware_fusion do |vmware, override|

    # Which box?
    override.vm.box = "opscode-ubuntu-13.04-x64-vmware"
    override.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/vmware/opscode_ubuntu-13.04_chef-provisionerless.box"

    # Customize VM
    vmware.vmx["memsize"] = "1024"
    vmware.vmx["numvcpus"] = "1"

  end

  # Virtualbox customization
  config.vm.provider :virtualbox do |virtualbox, override|

    # Which box? http://opscode.github.io/bento/
    override.vm.box = "opscode-ubuntu-13.04-x64"
    override.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-13.04_chef-provisionerless.box"

    # Customize VM
    virtualbox.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1", "--pae", "on", "--hwvirtex", "on", "--ioapic", "on"]

  end

  # Network
  config.vm.network :private_network, ip: "192.168.200.20"
  config.vm.hostname                    = hostname

  config.hostmanager.enabled            = true
  config.hostmanager.manage_host        = true
  config.hostmanager.ignore_private_ip  = false
  config.hostmanager.include_offline    = true

  # Synced folders
  config.vm.synced_folder "www", "/var/www"
  # config.vm.synced_folder "htdocs", "/var/www/magento", nfs: true,
  #                                   mount_options: ["nolock", "async"],
  #                                   bsd__nfs_options: ["alldirs","async","nolock"]

  # "Provision" with hostmanager
  config.vm.provision :hostmanager

  # Next, we have to get puppet onto our machine
  config.vm.provision :shell, :path => "ubuntu.sh"

  # Puppet!
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path   = "puppet/manifests"
    puppet.module_path      = "puppet/modules"
    puppet.manifest_file    = "init.pp"

    # Factors
    puppet.facter = {
        "vagrant"           => "1",
        "hostname"          => hostname,
        "db_root_password"  => "mysql",
        "db_user"           => "yii2",
        "db_password"       => "yii2",
        "db_name"           => "yii2",
        "db_name_tests"     => "yii2_tests",
        "document_root"     => "/var/www/frontend/web",
        "document_root_backend"     => "/var/www/backend/web",
        "logs_dir"          => "/var/www/logs",
    }
  end

end
