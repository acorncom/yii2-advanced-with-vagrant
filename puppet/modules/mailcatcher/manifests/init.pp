class mailcatcher () {

    package { ["ruby1.9.1-dev", "libsqlite3-dev"]:
        ensure  => latest,
        require => Exec["update"],
    }

    -> package { "mailcatcher":
        ensure   => latest,
        provider => gem,
        require  => [ Class["php"], Class['apache'] ],
        notify   => Service["apache2"],
    }

}
