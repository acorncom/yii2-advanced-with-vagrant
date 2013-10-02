class tools::casperjs {

    # PhantomJS
    $phantomjs = "phantomjs-1.9.2-linux-x86_64"
    $phantomjs_filename = "${phantomjs}.tar.bz2"
    exec { "download phantomjs":
        creates => "/root/${phantomjs_filename}",
        cwd     => "/root",
        command => "wget https://phantomjs.googlecode.com/files/${phantomjs_filename} -O /root/${phantomjs_filename}",
    }

    -> exec { "untar phantomjs":
        creates => "/root/${phantomjs}",
        cwd     => "/root",
        command => "tar xvjf ${phantomjs_filename}",
    }

    -> exec { "install phantomjs":
        creates => "/usr/local/bin/phantomjs",
        cwd     => "/root",
        command => "cp ${phantomjs}/bin/phantomjs /usr/local/bin && chmod +x /usr/local/bin/phantomjs",
    }

    exec { "clone casperjs":
        creates => "/usr/local/src/casperjs",
        cwd     => "/usr/local/src",
        command => "git clone git://github.com/n1k0/casperjs.git casperjs",
        require => Exec['install phantomjs'],
    }

    -> exec { "install casperjs":
        creates => "/usr/local/bin/casperjs",
        cwd     => "/usr/local/bin",
        command => "ln -s /usr/local/src/casperjs/bin/casperjs",
    }

}
