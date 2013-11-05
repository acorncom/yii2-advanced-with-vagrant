class php () {

    # Install package
    package { "php5":
        ensure  => latest,
        require => [ Class['server'], Package['apache2'], File['/etc/apt/sources.list.d/dotdeb.list'] ],
        notify  => Service['apache2'],
    }

    -> file { "/etc/php5/apache2/php.ini":
        ensure => file,
        source => "puppet:///modules/php/php.ini",
        notify => Service['apache2'],
        owner  => "root",
        group  => "root",
    }

    -> file { "/etc/php5/mods-available/xdebug.ini":
        ensure => file,
        source => "puppet:///modules/php/xdebug.ini",
        notify => Service['apache2'],
        owner  => "root",
        group  => "root",
    }

    # Install modules
    $modules = [
        "php5-cli",
        "php5-common",
        "php5-gd",
        "php5-mysql",
        "php5-curl",
        "php5-intl",
        "php5-mcrypt",
        "php5-tidy",
        "php5-readline",
        "php5-xdebug",
    ]
    package { $modules :
        ensure  => latest,
        require => [ Package['php5'], Class['server'], Package['apache2'], Package['mysql-server'] ],
    }

}
