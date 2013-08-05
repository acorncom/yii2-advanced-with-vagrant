class mysql::service {

    service { 'mysql':
        ensure      => running,
        enable      => true,
        hasrestart  => true,
        hasstatus   => true,
    }

}
