class tools::magerun {

    exec { "install magerun":
        cwd     => "/usr/local/bin",
        creates => "/usr/local/bin/n98-magerun.phar",
        command => "wget --no-check-certificate https://raw.github.com/netz98/n98-magerun/master/n98-magerun.phar",
        require => [ Package['php5'] ],
    }

    -> exec { "chmod magerun":
        cwd     => "/usr/local/bin",
        onlyif  => "test `stat --format '%a' n98-magerun.phar` -ne 755",
        command => "chmod 755 n98-magerun.phar",
    }

}
