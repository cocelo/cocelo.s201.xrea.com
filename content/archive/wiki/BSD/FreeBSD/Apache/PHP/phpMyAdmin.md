+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Apache/PHP/phpMyAdmin"
date = "2008-12-10T09:33:18Z"
+++

# phpMyAdmin Memo  {#n238e02d}


## Link  {#v8977b1d}
- [phpMyAdmin | MySQL Database Administration Tool | www.phpmyadmin.net](http://www.phpmyadmin.net/home_page/index.php "phpMyAdmin | MySQL Database Administration Tool | www.phpmyadmin.net")

## Install  {#k83a6a91}

```
# portinstall databases/phpmyadmin

phpMyAdmin-2.10.2 has been installed into:

    /usr/local/www/phpMyAdmin

Please edit config.inc.php to suit your needs.

To make phpMyAdmin available through your web site, I suggest
that you add something like the following to httpd.conf:

    Alias /phpmyadmin/ "/usr/local/www/phpMyAdmin/"

    <Directory "/usr/local/www/phpMyAdmin/">
        Options none
        AllowOverride Limit

        Order Deny,Allow
        Deny from all
        Allow from 127.0.0.1 .example.com
    </Directory>

# vi /usr/local/etc/apache22/Includes/phpmyadmin.conf

Alias /phpmyadmin/ "/usr/local/www/phpMyAdmin/"

<Directory "/usr/local/www/phpMyAdmin/">
   Options none
   AllowOverride Limit

   Order Deny,Allow
   Deny from all
   Allow from 192.168.1.0/24
</Directory>

# /usr/local/etc/rc.d/apache22 restart

# vi /usr/local/www/phpMyAdmin/config.inc.php

$i = 0;
$i++;

$cfg['Servers'][$i]['auth_type'] = 'cookie';

$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['port'] = '3308';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['compress'] = false;

$cfg['Servers'][$i]['extension'] = 'mysql';

$cfg['Servers'][$i]['controluser'] = 'root';
$cfg['Servers'][$i]['controlpass'] = 'hogehoge';

$cfg['blowfish_secret'] = 'hogehoge';
```

