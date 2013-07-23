class tools::installer {

    $repo_path = '/usr/local/src/Installer'
    $binary = '/usr/local/bin/Installer'

    exec { "clone jacquesbh/Installer":
        creates => $repo_path,
        command => "git clone https://github.com/jacquesbh/Installer.git $repo_path",
        require => Package['git'],
    }

    -> file { "link Installer bin":
        ensure  => link,
        path    => $binary,
        target  => "$repo_path/bin/Installer",
    }

    exec { "pull jacquesbh/Installer":
        cwd     => $repo_path,
        command => 'git pull',
        require => Exec['clone jacquesbh/Installer'],
    }

}
