+++
title = "[PukiWiki:wiki] BSD/FreeBSD/csup"
date = "2008-12-10T09:33:19Z"
+++

# csup Memo  {#t0bffe7e}


## Link  {#gb5c7127}
- [CSUP\(1\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=csup&dir=jpman-6.3.2%2Fman&sect=0 "CSUP\(1\)")
- [allbsd.org](http://www.allbsd.org/#pub-cvsup "allbsd.org")

## Version  {#t457d245}
- CSUP_1_0

## Install  {#x61d2770}
csup は FreeBSD 6.2 RELEASE から標準で入っています。

## 同期  {#xace58bd}

```
# csup -h cvsup.jp.freebsd.org -4 -1 -Z -l /var/run/csup.pid -L 2 /usr/share/examples/cvsup/standard-supfile

```

### 必要のないカゴテリを取得しない  {#m49e1824}

```
# vi /var/db/sup/refuse

doc/bn*
doc/da*
doc/de*
doc/el*
doc/es*
doc/fr*
doc/hu*
doc/id*
doc/it*
doc/mn*
doc/nl*
doc/no*
doc/pl*
doc/pt*
doc/ru*
doc/sr*
doc/tr*
doc/zh*

```

### /usr/src と /usr/ports で make update  {#y8dd807a}

```
# vi /etc/make.conf

SUP_UPDATE=	yes
SUP=		/usr/bin/csup
SUPFLAGS=	-4 -1 -Z -l /var/run/csup.pid -L 2
SUPHOST=	cvsup.jp.freebsd.org
SUPFILE=	/usr/share/examples/cvsup/standard-supfile
PORTSSUPFILE=	/usr/share/examples/cvsup/ports-supfile
DOCSUPFILE=	/usr/share/examples/cvsup/doc-supfile

# cd /usr/src
# make update
```

