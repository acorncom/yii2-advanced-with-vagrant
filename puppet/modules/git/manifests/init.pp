class git {

    package { 'git':
        ensure  => latest,
        require => Class['server']
    }

}
