class apache::install ( $server_name, $document_root, $logs_dir ) {

    # Install the package
    package { "apache2":
        ensure  => latest,
        require => Class['server'],
    }

    # The virtualhost file
    -> file { "site-magento":
        path    => "/etc/apache2/sites-available/magento",
        ensure  => present,
        content => template("apache/magento.vhost"),
        notify  => Class['apache::service'],
    }

    # Enable the virtualhost
    exec { "Enable the virtualhost":
        command => "a2ensite magento",
        creates => "/etc/apache2/sites-enabled/magento",
        require => [ Package['apache2'], File['site-magento'] ],
        notify  => Class['apache::service'],
    }

    # Set the host in local loop
    host { "magento":
        ensure  => present,
        ip      => "127.0.0.1",
        name    => $server_name,
    }

    # Create the directories
    file { "document_root":
        ensure  => directory,
        path    => $document_root,
    }
    file { "logs_dir":
        ensure  => directory,
        path    => $logs_dir,
    }

}
