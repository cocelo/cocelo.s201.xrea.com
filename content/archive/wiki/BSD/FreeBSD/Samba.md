+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Samba"
date = "2009-10-23T15:02:26Z"
+++


# インストール  {#i13e2306}

```
# portinstall converters/libiconv
# portinstall net/samba33
```

# 設定  {#j045c586}

```
# vi /usr/local/etc/smb.conf
```


```
[global]
   workgroup = WORKGROUP
   netbios name = SMB
   server string = Samba Server
   security = user
   hosts allow = 192.168.1.
   load printers = no
   printing = bsd
   log file = /var/log/samba/log.%m
   max log size = 50
   passdb backend = tdbsam
   socket options = IPTOS_LOWDELAY TCP_NODELAY
   socket address = 192.168.1.205
   interfaces = 192.168.1.0/24
   bind interfaces only = yes
   dns proxy = no
   display charset = UTF-8
   unix charset = UTF-8
   dos charset = CP932

[share]
   comment = Shared Directories
   path = /home/share
   public = yes
   browseable = yes
   writable = yes
   create mode = 770
```

# 自動起動の設定  {#k78cc9f8}

```
# vi /etc/rc.conf
```


```
samba_enable="YES"
```

# 起動  {#j9fd5749}

```
# /usr/local/etc/rc.d/samba start
```

# ユーザーの追加  {#n000f93c}

```
# pdbedit -a -u user
```

# リンク  {#n79f9996}
- [Samba-JP](http://wiki.samba.gr.jp/mediawiki/ "Samba-JP")
