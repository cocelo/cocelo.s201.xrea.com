+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Install_After"
date = "2008-12-10T09:33:19Z"
+++

# FreeBSD インストール直後にする設定  {#h2babb74}


## Link  {#eaa15738}
- [FreeBSDTips - otsune FreeStyleWiki](http://www.otsune.com/fswiki/FreeBSDTips.html "FreeBSDTips - otsune FreeStyleWiki")

## /root/.cshrc  {#lc449da5}

```
# vi /root/.cshrc

        #set prompt = "`/bin/hostname -s`# "
        set prompt = "[%Broot@%m%b]%B%~%b%# "

# source /root/.cshrc

```

## ~/.cshrc  {#l478738d}

```
> vi ~/.cshrc

        set prompt = "[%n@%m]%B%~%b%# "

> source ~/.cshrc

```

## /etc/make.conf  {#u429d860}

```
# vi /etc/make.conf

CPUTYPE=athlon-xp
#CFLAGS= -O2 -fno-strict-aliasing -pipe
#CXXFLAGS+= -fmemoize-lookups -fsave-memoized
#COPTFLAGS= -O2 -pipe

NO_BLUETOOTH=	true
NO_GAMES=	true
NO_INET6=	true
NO_PROFILE=	true
NO_SENDMAIL=	true
NO_USB=		true

WITHOUT_X11=	yes
WITHOUT_IPV6=	yes

WITH_BDB_VER=	42

DOC_LANG=	en_US.ISO8859-1 ja_JP.eucJP

KERNCONF=	S2KERNEL

```

## /etc/motd  {#kfabec1c}

```
# vi /etc/motd

Welcome to FreeBSD!

```

## /etc/syslog.conf  {#id2bb6d6}

```
# touch /var/log/all.log
# chmod 600 /var/log/all.log
# vi /etc/syslog.conf

#*.*						/var/log/all.log
*.*						/var/log/all.log

```

## /etc/mail/aliases  {#fe9d3c94}

```
# vi /etc/mail/aliases

root: user

# newaliases

```

## その後  {#ccbeac71}
- [csup](/archive/wiki/BSD/FreeBSD/csup/ "csup")
- [Kernel](/archive/wiki/BSD/FreeBSD/Kernel/ "Kernel")
- [Portsnap](/archive/wiki/BSD/FreeBSD/portsnap/ "Portsnap")
- [portupgrade](/archive/wiki/BSD/FreeBSD/portupgrade/ "portupgrade")
- [Tuning](/archive/wiki/BSD/FreeBSD/Tuning/ "Tuning")

後は必要に応じて。
