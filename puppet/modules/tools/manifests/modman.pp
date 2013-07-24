class tools::modman {

    $repo_path = '/usr/local/src/modman'
    $binary = '/usr/local/bin/modman'
    $git = 'https://github.com/colinmollenhour/modman.git'

    exec { "clone colinmollenhour/modman":
        creates => $repo_path,
        command => "git clone $git $repo_path",
        require => Package['git'],
    }

    -> exec { "chmod modman binary":
        cwd     => "$repo_path",
        onlyif  => "test `stat --format '%a' modman` -ne 755",
        command => "chmod 755 $repo_path/modman",
    }

    -> file { "link modman bin":
        ensure  => link,
        path    => $binary,
        target  => "$repo_path/modman",
    }

    exec { "pull colinmollenhour/modman":
        cwd     => $repo_path,
        onlyif  => "test `git log -1 | grep commit | awk '{ print \$2 }'` != `git ls-remote $git | grep master | awk '{ print \$1 }'`",
        command => 'git pull',
        require => Exec['clone colinmollenhour/modman'],
    }

}
