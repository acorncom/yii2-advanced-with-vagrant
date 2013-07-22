class apache ( $server_name, $document_root, $logs_dir ) {

    # Install the package
    package { "apache2":
        ensure  => latest,
        before  => File['/etc/apache2/sites-available/magento'],
        require => [ Package["mysql-server"], Class['server'] ],
    }

    # The virtualhost file
    file { "/etc/apache2/sites-available/magento":
        ensure  => present,
        content => template("apache/magento.vhost"),
        notify  => Exec['apache2-reload'],
    }

    # Enable the virtualhost
    file { "Enable the virtualhost":
        ensure  => link,
        path    => "/etc/apache2/sites-enabled/magento",
        target  => "/etc/apache2/sites-available/magento",
    }

    # Check if apache is running
    service { "apache2":
        ensure      => running,
        hasstatus   => true,
        hasrestart  => true,
        require     => Package["apache2"],
    }

    # Reload apache (events only)
    exec { "apache2-reload":
        command     => "/etc/init.d/apache2 reload",
        refreshonly => true,
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
