# Vagrantfile & Puppet manifests for Magento

## Requirements

You just need [Vagrant][vagrant] :)

## How start

Edit the `Vagrantfile`: `vim Vagrantfile`

*   Change the VM IP if needed. Default is: `10.0.0.2` (`10.0.0.1` is your machine)
*   Change the RAM or number of CPUs if needed.
*   On the puppet part: change the factors
    *   Change `hostname` with the development domain of your website
    *   Change `db_*` variables with your information or keep default values
    *   If you change the `document_root` don't forget to change the synced directory

Then `up` the VM: `vagrant up`

Now you can access to your Magento : `http://your-domain.org:8080`

If you want do remove the port `8080` and access to your website via `http://your-domain.org/` , you can do it with `ipfw`.  
Example : `ipfw add 100 fwd 127.0.0.1,8080 tcp from any to me 80` as root  
*`ipfw` isn't possible on Windows (but Windows sucks right?)

## MySQL

* Host: 127.0.0.1
* Port: 3307
* User: magento
* Pass: magento

With the information above you can connect to the MySQL server running on the virtual machine.

### Import database

If file exists `database.sql.gz` in the main directory (where the Vagrantfile is), puppet will import the database.

## Virtualhost

Per default the variable `MAGE_IS_DEVELOPER_MODE` is set to true.

The virtualhost is set on the `htdocs` directory.

## Mails

[MailCatcher][mailcatcher] is installed and configured into the `/etc/php5/apache2/php.ini` file.

### How it works

If mailcatcher is stopped: all emails are lost.

If mailcatcher is started: **all emails are catched**.

If you want to start MailCatcher, simply run this command (with vagrant user) : `mailcatcher --ip 0.0.0.0`

Then go to : http://localhost:1080

If you need to stop the mailcatcher daemon : Clic on "Quit" on the top right corner of the MailCatcher Web UI.

## Packages

Are installed:

* apache-mpm-itk (with magento virtualhost)
* mysql-server (with custom my.cnf)
* mysql-client
* php5 (and some modules)
* screen (with custom .screenrc for root)
* vim
* wget
* curl
* git
* composer.phar
* mailcatcher (gem)

### For Magento developers

* [n98-magerun.phar][magerun]
* [modman][modman]
* [The Installer][installer]


[vagrant]: http://vagrantup.com
[installer]: https://github.com/jacquesbh/Installer#readme
[modman]: https://github.com/colinmollenhour/modman
[magerun]: https://github.com/netz98/n98-magerun
