class mysql ( $root_password, $db_name, $db_user, $db_password, $db_name_tests ) {

    include mysql::service
    class { "mysql::install":
        root_password => $root_password,
        db_name       => $db_name,
        db_user       => $db_user,
        db_password   => $db_password,
        db_name_tests => $db_name_tests
    }

}
