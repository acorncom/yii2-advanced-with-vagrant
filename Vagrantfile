# -*- mode: ruby -*-
# vi: set ft=ruby :

hostname = "vagrant-mage.dev"

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "magento" do |magento|

    # VMWare Fusion customization
    magento.vm.provider :vmware_fusion do |vmware, override|

      # Which box?
      override.vm.box = "debian-wheezy-fusion"
      override.vm.box_url = "http://boxes.monsieurbiz.com/debian-wheezy-fusion.box"

      # Customize VM
      vmware.vmx["memsize"] = "1024"
      vmware.vmx["numvcpus"] = "1"

    end

    # Virtualbox customization
    magento.vm.provider :virtualbox do |virtualbox, override|

      # Which box?
      override.vm.box = "debian-wheezy"
      override.vm.box_url = "http://boxes.monsieurbiz.com/debian-wheezy.box"

      # Customize VM
      virtualbox.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1", "--pae", "on", "--hwvirtex", "on", "--ioapic", "on"]

    end

    # Network
    magento.hostmanager.enabled            = true
    magento.hostmanager.manage_host        = true
    magento.hostmanager.ignore_private_ip  = false
    magento.hostmanager.include_offline    = true
    magento.vm.hostname                    = hostname

    # Synced folders
    # magento.vm.synced_folder "htdocs", "/var/www/magento"
    magento.vm.synced_folder "htdocs", "/var/www/magento", nfs: true,
                                      mount_options: ["nolock", "async"],
                                      bsd__nfs_options: ["alldirs","async","nolock"]

    # "Provision" with hostmanager
    magento.vm.provision :hostmanager

    # Puppet!
    magento.vm.provision :puppet do |puppet|
      puppet.manifests_path   = "puppet/manifests"
      puppet.module_path      = "puppet/modules"
      puppet.manifest_file    = "init.pp"

      # Factors
      puppet.facter = {
          "vagrant"           => "1",
          "hostname"          => hostname,
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

end
