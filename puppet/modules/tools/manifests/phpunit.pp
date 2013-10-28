class tools::phpunit {

    exec { "install phpunit":
        cwd     => "/usr/local/bin",
        creates => "/usr/local/bin/phpunit",
        command => "wget --no-check-certificate https://phar.phpunit.de/phpunit.phar -O /usr/local/bin/phpunit",
        require => [ Package['php5'] ],
    }

    -> exec { "chmod phpunit":
        cwd     => "/usr/local/bin",
        onlyif  => "test `stat --format '%a' phpunit` -ne 755",
        command => "chmod 755 phpunit",
    }

}
