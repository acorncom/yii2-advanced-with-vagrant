class mysql::install ( $root_password, $db_name, $db_user, $db_password, $db_name_tests ) {

    # MySQL server & client
    package { "mysql-server":
        ensure  => latest,
        require => [ Class['server'], File['/etc/mysql/my.cnf'] ],
        notify  => Service['mysql'],
    }

    -> package { "mysql-client":
        ensure  => latest,
    }

    file { "/etc/mysql":
        ensure => directory,
    }

    -> file { "/etc/mysql/my.cnf":
        ensure => file,
        source => "puppet:///modules/mysql/my.cnf",
        owner  => "root",
        group  => "root",
        notify => Service['mysql'],
    }

    # Stop mysql
    exec { "stop mysql":
        refreshonly => true,
        command     => "service mysql stop"
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

    # Create the Yii2 database
    exec { "create-yii-db":
        path    => "/usr/bin",
        onlyif  => "test ! `mysql -uroot -p${root_password} -e 'use ${db_name}' && echo $?`",
        command => "mysqladmin -uroot -p${root_password} create ${db_name}",
        require => Exec['setup the root password'],
        notify  => Exec['import database'],
    }

    # Import the database dump if it exists
    exec { "import database":
        refreshonly => true,
        cwd         => "/vagrant",
        onlyif      => "test -f database.sql.gz",
        command     => "gunzip -c database.sql.gz | mysql -uroot -p${root_password} ${db_name}",
    }

    # Create the Yii2 test database
    exec { "create-yii-test-db":
        path    => "/usr/bin",
        onlyif  => "test ! `mysql -uroot -p${root_password} -e 'use ${db_name_tests}' && echo $?`",
        command => "mysqladmin -uroot -p${root_password} create ${db_name_tests}",
        require => Exec["create-yii-db"],
    }

    # Create the Yii2 user
    exec { "create-yii2-user":
        path    => "/usr/bin",
        onlyif  => "test ! `mysql -u${db_user} -p${db_password} -e 'use ${db_name}' && echo $?`",
        command => "mysql -uroot -p${root_password} -e \"GRANT ALL ON *.* TO '${db_user}'@'localhost' IDENTIFIED BY '${db_password}' WITH GRANT OPTION;\"",
        require => [ Exec["create-yii-db"], Exec["create-yii-test-db"] ],
    }
}
