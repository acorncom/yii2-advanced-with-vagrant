# Init puppet provisioner for Magento installation

Exec {
    path => [
        '/usr/local/bin',
        '/opt/local/bin',
        '/usr/bin',
        '/usr/sbin',
        '/bin',
        '/sbin'
    ],
    logoutput => false,
}

# The server
class { "server":
    hostname => "${hostname}"
}

# Apache
class { "apache":
    server_name     => "${server::hostname}",
    document_root   => "${document_root}",
    logs_dir        => "${logs_dir}"
}

# MySQL
class { "mysql":
    root_password   => "${db_root_password}",
    db_name         => "${db_name}",
    db_user         => "${db_user}",
    db_password     => "${db_password}",
    db_name_tests   => "${db_name_tests}",
}

# PHP
class { "php":
}


# Includes
include server
include apache
include mysql
include php
include mailcatcher
include git
include tools
