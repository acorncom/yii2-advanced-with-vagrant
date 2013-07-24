class tools::composer {

    exec { "install composer":
        creates => "/usr/local/bin/composer.phar",
        command => "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin",
        require => [ Package['php5'], Package['curl'] ],
    }

}
