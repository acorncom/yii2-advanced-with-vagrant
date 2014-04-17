class apache ( $server_name, $document_root, $logs_dir, $document_root_backend ) {

    include apache::service
    class { "apache::install" :
        server_name   => "$server_name",
        document_root => "$document_root",
        logs_dir      => "$logs_dir",
        document_root_backend => "$document_root_backend",
    } ~> Class['apache::service']

}
