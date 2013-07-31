class server ( $hostname ) {

    file { "sources":
        ensure => file,
        path   => "/etc/apt/sources.list",
        source => "puppet:///modules/server/sources.list",
        owner  => "root",
        group  => "root",
    }
    -> exec { "import dotdeb gpg":
        onlyif  => "test `/usr/bin/apt-key list | /bin/grep dotdeb.org | /usr/bin/wc -l` -eq 0",
		command => "/usr/bin/wget -q http://www.dotdeb.org/dotdeb.gpg -O -| /usr/bin/apt-key add -",
	}
    -> exec { "update":
        path    => "/bin:/usr/bin",
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
