class apache ( $server_name, $document_root, $logs_dir ) {

    include apache::service
    class { "apache::install" :
        server_name   => "$server_name",
        document_root => "$document_root",
        logs_dir      => "$logs_dir",
    } ~> Class['apache::service']

}
