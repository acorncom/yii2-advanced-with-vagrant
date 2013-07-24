class apache::service {

    service { 'apache2':
        ensure      => running,
        enable      => true,
        hasrestart  => true,
        hasstatus   => true,
        require     => Class['apache::install']
    }

}
