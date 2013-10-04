class tools::magerun {

    exec { "install magerun":
        cwd     => "/usr/local/bin",
        creates => "/usr/local/bin/magerun",
        command => "wget --no-check-certificate https://raw.github.com/netz98/n98-magerun/master/n98-magerun.phar -O /usr/local/bin/magerun",
        require => [ Package['php5'] ],
    }

    -> exec { "chmod magerun":
        cwd     => "/usr/local/bin",
        onlyif  => "test `stat --format '%a' magerun` -ne 755",
        command => "chmod 755 magerun",
    }

}
