class mysql::install ( $root_password, $db_name, $db_user, $db_password ) {

    # MySQL server & client
    package { "mysql-server":
        ensure  => latest,
        require => Class['server'],
    }

    -> file { "/etc/mysql/my.cnf":
        ensure  => file,
        source  => "puppet:///modules/mysql/my.cnf",
        owner   => "root",
        group   => "root",
        notify  => Exec['remove innodb files'],
        require => Exec['stop mysql'],
    }

    -> package { "mysql-client":
        ensure  => latest,
    }

    # Stop mysql
    exec { "stop mysql":
        refreshonly => true,
        command     => "service mysql stop"
    }


    # Remove ib files
    exec { "remove innodb files":
        refreshonly => true,
        command     => "rm -rf /var/lib/mysql/ib*",
        notify      => Service['mysql'],
    }

    # Setup the root password
    exec { "setup the root password":
        path    => "/usr/bin",
        unless  => "mysqladmin -uroot -p${root_password} status",
        command => "mysqladmin -uroot password ${root_password}",
        require => [ Package['mysql-client'], Service['mysql'], Package['mysql-server'] ],
    }

    # ~/.my.cnf
    -> file { "/root/.my.cnf":
        ensure  => present,
        content => template("mysql/.my.cnf"),
    }

    # Create the magento database
    exec { "create-magento-db":
        path    => "/usr/bin",
        unless  => "mysql -uroot -p${root_password} ${db_name}",
        command => "mysqladmin -uroot -p${root_password} create ${db_name}",
        require => Exec['setup the root password'],
        notify  => Exec['import database'],
    }

    exec { "import database":
        refreshonly => true,
        cwd         => "/vagrant",
        onlyif      => "test -f database.sql.gz",
        command     => "gunzip -c database.sql.gz | mysql -uroot -p${root_password} ${db_name}",
    }

    # Create the magento user
    exec { "create-magento-user":
        path    => "/usr/bin",
        unless  => "mysql -u${db_user} -p${db_password} ${db_name}",
        command => "mysql -uroot -p${root_password} -e \"GRANT ALL ON *.* TO '${db_user}'@'%' IDENTIFIED BY '${db_password}' WITH GRANT OPTION;\"",
        require => Exec["create-magento-db"],
    }

}
