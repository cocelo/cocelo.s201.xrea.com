+++
title = "[PukiWiki:wiki] BSD/FreeBSD/SHOUTcast"
date = "2008-12-10T09:33:19Z"
+++

# SHOUTcast Memo  {#v8f4c4e6}


## Install  {#q02d61d4}

```
# portinstall audio/shoutcast

```

compat5 もインストールされるのでカーネルの設定に注意すること。


```
*******************************************************************************
*                                                                             *
* Do not forget to add COMPAT_FREEBSD5 into                                   *
* your kernel configuration (enabled by default).                             *
*                                                                             *
* To configure and recompile your kernel see:                                 *
* http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/kernelconfig.html *
*                                                                             *
*******************************************************************************

# vi /etc/rc.conf

shoutcast_enable="YES"

# chmod 644 /usr/local/etc/shoutcast/sc_serv.conf
# vi /usr/local/etc/shoutcast/sc_serv.conf

MaxUser=16(最大接続数)
Password=passwd(クライアント用PASS)
PortBase=8000(任意のポート)
LogFile=/var/log/sc_serv.log
ShowLastSongs=20
AdminPassword=adminpasswd(管理者用PASS)
PublicServer=never(デフォルトだとshoutcast.comにラジオ放送中である事を通知してしまうのでそれを防止)

# /usr/local/etc/rc.d/shoutcast start
```

