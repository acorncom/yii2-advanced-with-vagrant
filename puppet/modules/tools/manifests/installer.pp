class tools::installer {

    $repo_path = '/usr/local/src/installer'
    $binary = '/usr/local/bin/installer'
    $url = 'git://github.com/jacquesbh/installer.git'

    exec { "clone jacquesbh/installer":
        creates => $repo_path,
        command => "git clone $url $repo_path",
        require => Package['git'],
    }

    -> file { "link installer bin":
        ensure  => link,
        path    => $binary,
        target  => "$repo_path/bin/Installer",
    }

    exec { "pull jacquesbh/installer":
        cwd     => $repo_path,
        onlyif  => "test `git log -1 | grep commit | awk '{ print \$2 }'` != `git ls-remote $url | grep master | awk '{ print \$1 }'`",
        command => 'git pull',
        require => Exec['clone jacquesbh/installer'],
    }

}
