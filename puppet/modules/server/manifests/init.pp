class server ( $hostname ) {

    exec { "update":
        path => "/bin:/usr/bin",
        command => "apt-get update",
    }

}
