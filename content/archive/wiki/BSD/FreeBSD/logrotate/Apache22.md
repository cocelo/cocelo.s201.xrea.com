+++
title = "[PukiWiki:wiki] BSD/FreeBSD/logrotate/Apache22"
date = "2008-12-10T09:33:20Z"
+++

# 目次  {#f1fad89e}

# Apache 2.2  {#q9e3d479}

```
# vi /usr/local/etc/logrotate.d/apache22

/var/log/apache22/*.log {
    daily
    rotate 7
    create
    nocompress
    ifempty
    missingok
    sharedscripts
    postrotate
        # child プロセスが Segmentation fault するのでコメントアウト
        #/usr/local/sbin/apachectl -k graceful
        /bin/kill -HUP `cat /opt/local/apache2/logs/httpd.pid 2>/dev/null` 2> /dev/null || true
    endscript
}
```

