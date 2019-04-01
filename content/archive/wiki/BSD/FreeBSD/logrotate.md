+++
title = "[PukiWiki:wiki] BSD/FreeBSD/logrotate"
date = "2008-12-10T09:33:20Z"
+++

# logrotate Memo  {#f0923195}


## Link  {#t209b368}
- [はやぐい/FreeBSD 4.8 + logrotate](http://www.hayagui.com/logrotate.html "はやぐい/FreeBSD 4.8 + logrotate")

## Install  {#aadece83}

```
# portinstall sysutils/logrotate
# rehash

```

## Setting  {#vc52a71a}

```
# cp /usr/local/etc/logrotate.conf.sample /usr/local/etc/logrotate.conf
# vi /usr/local/etc/logrotate.conf

# see "man logrotate" for details
# rotate log files weekly
weekly

# keep 4 weeks worth of backlogs
rotate 4

# send errors to root
#errors root

# create new (empty) log files after rotating old ones
create

# uncomment this if you want your log files compressed
compress

# RPM packages drop log rotation information into this directory
include /usr/local/etc/logrotate.d

#/var/log/lastlog {
#    monthly
#    rotate 1
#}

# system-specific logs may be configured here

# mkdir /usr/local/etc/logrotate.d

# /usr/local/sbin/logrotate -v /usr/local/etc/logrotate.conf
# vi /etc/crontab

#
# logrotate
0	0	*	*	*	root	/usr/local/sbin/logrotate /usr/local/etc/logrotate.conf
```

