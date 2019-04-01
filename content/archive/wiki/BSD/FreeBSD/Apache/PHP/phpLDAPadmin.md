+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Apache/PHP/phpLDAPadmin"
date = "2008-12-10T09:33:18Z"
+++

# phpLDAPadmin Memo  {#l77fb7ad}


## Link  {#ed43427e}
- [phpLDAPadmin: LDAP browser to manager your LDAP server](http://phpldapadmin.sourceforge.net/ "phpLDAPadmin: LDAP browser to manager your LDAP server")

## Memo  {#y2338977}
インストール後に出てくるメッセージの中の Alias が間違ってた。

## Install  {#jf2459e7}

```
# portinstall net/phpldapadmin

phpldapadmin-1.0.2,1 has been installed into:

    /usr/local/www/phpldapadmin

Please edit config.php to suit your needs.

To make phpLDAPadmin available through your web site, I suggest that
you add something like following to httpd.conf:

    Alias /phpldapadmin/ "/usr/local/www/phpldapadmin/htdocs"

    <Directory "/usr/local/www/phpldapadmin/htdocs">
        Options none
        AllowOverride none

        Order Deny,Allow
        Deny from all
        Allow from 127.0.0.1 .example.com
    </Directory>

Please note: if you are upgrading from version 0.9.7 or earlier, the
layout of the phpldapadmin-1.0.2,1 files has been completely reworked. You will
need to modify your apache configuration and merge the settings from
your original configuration file:

    /usr/local/www/phpldapadmin/config.php

 to

   /usr/local/www/phpldapadmin/config/config.php

# vi /usr/local/etc/apache22/Includes/phpldapadmin.conf

Alias /phpldapadmin "/usr/local/www/phpldapadmin/htdocs"

<Directory "/usr/local/www/phpldapadmin/htdocs">
   Options none
   AllowOverride none

   Order Deny,Allow
   Deny from all
   Allow from 192.168.1.0/24
</Directory>

# /usr/local/etc/rc.d/apache22 restart

```

## Setting  {#he2cf1f7}

```
# vi /usr/local/www/phpldapadmin/config/config.php
```

