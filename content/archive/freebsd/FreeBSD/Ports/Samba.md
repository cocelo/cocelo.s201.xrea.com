+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Samba"
date = "2010-08-08T19:34:46Z"
+++


# インストール  {#i13e2306}

```
# portinstall converters/libiconv
# portinstall net/samba34
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

   hosts allow = 192.168.1.

   load printers = no
   disable spoolss = yes
   printcap name = /dev/null
   log file = /var/log/samba/log.%m

   socket options = IPTOS_LOWDELAY TCP_NODELAY

   dns proxy = no

   display charset = UTF-8
   unix charset = UTF-8
   dos charset = CP932

[home]
   comment = Home Directories
   browseable = no
   writable = yes

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
