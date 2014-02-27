# Vagrantfile & Puppet manifests for Yii2

## Requirements

You just need [Vagrant][vagrant] and vagrant-hostmanager

Install vagrant-hostmanager as follows:

    vagrant plugin install vagrant-hostmanager

## How start

Edit the `Vagrantfile`: `vim Vagrantfile`

*   Change the VM IP if needed. Default is: `192.168.200.20` (`192.168.200.1` is your machine)
*   Change the RAM or number of CPUs if needed.
*   On the puppet part: change the factors
    *   Change `hostname` with the development domain of your website
    *   Change `db_*` variables with your information or keep default values
    *   If you change the `document_root` don't forget to change the synced directory

Then `up` the VM: `vagrant up`

Now you can access to your Yii setup : `http://www.yii2.dev`

## MySQL

You need to use an SSH connection.

With the information below you can connect to the MySQL server running on the virtual machine.

## Default information

* SSH Host: 192.168.200.20
* SSH User: vagrant
* SSH Pass: vagrant
* SSH Port: 2222 (default by vagrant)
* MySQL Host: 127.0.0.1
* MySQL Port: 3306
* MySQL User: yii2
* MySQL Pass: yii2

### Import database

If file exists `database.sql.gz` in the main directory (where the Vagrantfile is), puppet will import the database during the first `up`.

## Virtualhost

Per default the variable `YII_DEBUG` is set to true for this Apache setup, but will be false automatically on deploy.

The virtualhost is set on the `htdocs` directory.

## Mails

[MailCatcher][mailcatcher] is installed and configured into the `/etc/php5/apache2/php.ini` file.

### How it works

If mailcatcher is stopped: all emails are lost.

If mailcatcher is started: **all emails are catched**.

If you want to start MailCatcher, simply run this command (with vagrant user) : `mailcatcher --ip 0.0.0.0`

Then go to : http://www.yii2.dev:1080

If you need to stop the mailcatcher daemon : Clic on "Quit" on the top right corner of the MailCatcher Web UI.

## Packages

Are installed:

* apache-mpm-itk (with yii2 virtualhost)
* mysql-server (with custom my.cnf)
* mysql-client
* php5 (and the following modules)
    - bcmatch
    - bz2
    - calendar
    - ctype
    - curl
    - date
    - dba
    - dom
    - ereg
    - exif
    - fileinfo
    - filter
    - ftp
    - gd
    - gettext
    - hash
    - iconv
    - intl
    - json
    - libxml
    - mbstring
    - mcrypt
    - mhash
    - mysql
    - mysqli
    - openssl
    - pcre
    - pdo
    - pdo_mysql
    - phar
    - posix
    - readline
    - reflection
    - session
    - shmop
    - simplexml
    - soap
    - sockets
    - spl
    - sysvmsg
    - tidy
    - tokenizer
    - wddx
    - xdebug
    - xml
    - xmlreader
    - xmlwriter
    - zip
    - zlib
* screen (with custom .screenrc for root)
* vim
* wget
* curl
* git
* composer.phar
* mailcatcher (gem)

[vagrant]: http://vagrantup.com
[mailcatcher]: http://mailcatcher.me

## Credit
Giving credit where credit is due.  Almost all of the hard work on this was done here:
https://github.com/monsieurbiz/vagrant-magento

I just forked and tweaked it to work well with Yii 2