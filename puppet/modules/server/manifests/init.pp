class server ( $hostname ) {

    exec { "update":
        path => "/bin:/usr/bin",
        command => "apt-get update",
    }

    # Few packages
    $packages = ["curl", "vim", "screen", "wget", "tidy"]
    package { $packages:
        ensure  => latest,
        require => Exec['update'],
    }

    # ScreenRC
    file { ".screenrc":
        ensure  => file,
        path    => '/root/.screenrc',
        source  => 'puppet:///modules/server/.screenrc',
        require => Package['screen'],
    }

}
