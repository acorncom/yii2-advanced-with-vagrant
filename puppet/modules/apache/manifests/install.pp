class apache::install ( $server_name, $document_root, $logs_dir ) {

    Exec {
        path => [
            '/usr/local/bin',
            '/opt/local/bin',
            '/usr/bin',
            '/usr/sbin',
            '/bin',
            '/sbin'
        ],
    }

    # Install the package
    package { "apache2":
        name    => "apache2-mpm-itk",
        ensure  => latest,
        require => Class['server'],
    }

    # The shell of www-data
    -> exec { 'change www-data shell':
        onlyif  => "test `cat /etc/passwd | grep www-data | awk -F ':' '{ print \$7 }'` != '/bin/bash'",
        command => 'chsh -s /bin/bash www-data'
    }

    # The virtualhost file
    -> file { "site-magento":
        path    => "/etc/apache2/sites-available/magento",
        ensure  => present,
        content => template("apache/magento.vhost"),
        notify  => Class['apache::service'],
    }

    # Disable 000-default vhost
    exec { "Disable 000-default":
        onlyif  => "test -f /etc/apache2/sites-enabled/000-default",
        command => "a2dissite 000-default",
        require => [ Package['apache2'] ],
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

    # Mods
    exec { 'enable mod rewrite':
        onlyif  => 'test `apache2ctl -M 2> /dev/null | grep rewrite | wc -l` -ne 1',
        command => 'a2enmod rewrite',
        require => Package['apache2'],
    } ~> Service['apache2']

    exec { 'enable mod ssl':
        onlyif  => 'test `apache2ctl -M 2> /dev/null | grep ssl | wc -l` -ne 1',
        command => 'a2enmod ssl',
        require => Package['apache2'],
    } ~> Service['apache2']

    exec { 'enable mod headers':
        onlyif  => 'test `apache2ctl -M 2> /dev/null | grep headers | wc -l` -ne 1',
        command => 'a2enmod headers',
        require => Package['apache2'],
    } ~> Service['apache2']

    # Add www-data to vagrant group
    exec { "Add www-data to vagrant group":
        onlyif  => "test `groups www-data | grep vagrant` -eq 0",
        command => 'usermod -aG vagrant www-data',
        require => Package['apache2'],
    }

}
