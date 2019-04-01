+++
title = "[PukiWiki:wiki] BSD/FreeBSD/logrotate/ices"
date = "2008-12-10T09:33:20Z"
+++


# ices 0.4  {#zc6f38e2}

```
# vi /usr/local/etc/logrotate.d/ices0

/var/log/ices/*.log {
   daily
   rotate 7
   create
   nocompress
   ifempty
   missingok
   sharedscripts
   postrotate
      /bin/kill -HUP `cat /var/log/ices/ices.pid`
   endscript
}
```

