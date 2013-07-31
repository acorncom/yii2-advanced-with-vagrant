class php () {

    # Install package
    package { "php5":
        ensure  => latest,
        require => [ Class['server'], Package['apache2'] ],
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
    ]
    package { $modules :
        ensure  => latest,
        require => [ Package['php5'], Class['server'], Package['apache2'], Package['mysql-server'] ],
    }

}
