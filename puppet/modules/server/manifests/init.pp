class server ( $hostname ) {

    exec { "update":
        path => "/bin:/usr/bin",
        command => "apt-get update",
    }

    file { "set the hostname":
        ensure  => file,
        path    => "/etc/hostname",
        content => $hostname,
    }

}
