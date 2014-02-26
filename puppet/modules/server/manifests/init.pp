class server ( $hostname ) {

    file { "/etc/apt/sources.list.d/dotdeb.list":
        ensure => file,
        path   => "/etc/apt/sources.list.d/dotdeb.list",
        source => "puppet:///modules/server/dotdeb.list",
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
    $packages = ["curl", "tidy", "screen", "vim", "htop", "telnet"]
    package { $packages:
        ensure  => latest,
        require => Exec['update'],
    }

    # ScreenRC
    file { ".screenrc":
        ensure  => file,
        path    => '/root/.screenrc',
        source  => 'puppet:///modules/server/.screenrc',
    }
    file { ".screenrc for vagrant":
        ensure  => file,
        path    => '/home/vagrant/.screenrc',
        source  => 'puppet:///modules/server/.screenrc',
    }

}
