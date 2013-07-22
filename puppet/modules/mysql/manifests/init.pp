class mysql ( $root_password, $db_name, $db_user, $db_password ) {

    # MySQL server & client
    package { "mysql-server":
        ensure  => latest,
        notify  => Exec['setup the root password'],
        require => Class['server'],
    }
    package { "mysql-client":
        ensure  => latest,
        require => [ Package["mysql-server"], Class['server'] ],
    }

    # Check if mysql is running
    service { "mysql":
        ensure      => running,
        hasstatus   => true,
        hasrestart  => true,
        require     => Package["mysql-server"],
    }

    # Setup the root password
    exec { "setup the root password":
        refreshonly => true,
        path        => "/usr/bin",
        unless      => "mysqladmin -uroot -p${root_password} status",
        command     => "mysqladmin -uroot password ${root_password}",
    }

    # Create the magento database
    exec { "create-magento-db":
        path    => "/usr/bin",
        unless  => "mysql -uroot -p${root_password} ${db_name}",
        command => "mysqladmin -uroot -p${root_password} create ${db_name}",
        require => Service["mysql"],
    }

    # Create the magento user
    exec { "create-magento-user":
        path    => "/usr/bin",
        unless  => "mysql -u${db_user} -p${db_password} ${db_name}",
        command => "mysql -uroot -p${root_password} -e \"GRANT ALL ON *.* TO '${db_user}'@'localhost' IDENTIFIED BY '${db_password}' WITH GRANT OPTION;\"",
        require => Exec['create-magento-db'],
    }

}
