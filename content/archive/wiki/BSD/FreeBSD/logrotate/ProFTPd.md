+++
title = "[PukiWiki:wiki] BSD/FreeBSD/logrotate/ProFTPd"
date = "2008-12-10T09:33:20Z"
+++

# 目次  {#nfd41020}

# ProFTPd  {#ef15ba47}

```
# vi /usr/local/etc/logrotate.d/proftpd

/var/log/proftpd/*.log {
    daily
    rotate 7
    create
    nocompress
    ifempty
    missingok
}
```

