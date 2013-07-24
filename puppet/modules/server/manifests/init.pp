class server ( $hostname ) {

    exec { "update":
        path => "/bin:/usr/bin",
        command => "apt-get update",
    }

    package { "curl":
        ensure  => latest,
        require => Exec['update'],
    }

}
