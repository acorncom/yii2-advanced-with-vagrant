# Init puppet provisioner for Magento installation

# The server
class { "server":
    hostname => "super-cool.com"
}

# Apache
class { "apache":
    server_name => "${server::hostname}",
    document_root => "/var/www/magento",
    logs_dir => "/tmp"
}

# MySQL
class { "mysql":
    root_password   => "mysql",
    db_name         => "magento",
    db_user         => "magento",
    db_password     => "magento",
}

# PHP
# class { "php5":
#     db_user => "magento",
#     db_pass => "magento",
#     db_name => "magento",
# }


# Includes
include server
include apache
include mysql
# include php5
