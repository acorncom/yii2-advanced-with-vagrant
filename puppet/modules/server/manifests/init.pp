class server ( $hostname ) {

    exec { "update":
        path => "/bin:/usr/bin",
        command => "apt-get update",
    }

    # Few packages
    $packages = ["curl", "vim", "screen"]
    package { $packages:
        ensure  => latest,
        require => Exec['update'],
    }

}
