class php () {

    include apache

    # Install package
    package { "php5":
        ensure  => latest,
        require => [ Class['server'], Class['apache'] ],
    }

    # Install modules
    $modules = [
        "php5-cli",
        "php5-common",
        "php5-gd",
        "php5-mysql",
        "php5-curl",
        "php5-intl",
        "php5-mcrypt"
    ]
    package { $modules :
        ensure  => latest,
        require => [ Class['server'], Class['apache'], Class['mysql'] ],
    }

}
