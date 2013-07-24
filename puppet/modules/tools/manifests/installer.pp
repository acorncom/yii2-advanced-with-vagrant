class tools::installer {

    $repo_path = '/usr/local/src/Installer'
    $binary = '/usr/local/bin/Installer'
    $url = 'https://github.com/jacquesbh/Installer.git'

    exec { "clone jacquesbh/Installer":
        creates => $repo_path,
        command => "git clone $url $repo_path",
        require => Package['git'],
    }

    -> file { "link Installer bin":
        ensure  => link,
        path    => $binary,
        target  => "$repo_path/bin/Installer",
    }

    exec { "pull jacquesbh/Installer":
        cwd     => $repo_path,
        onlyif  => "test `git log -1 | grep commit | awk '{ print \$2 }'` != `git ls-remote $url | grep master | awk '{ print \$1 }'`",
        command => 'git pull',
        require => Exec['clone jacquesbh/Installer'],
    }

}
