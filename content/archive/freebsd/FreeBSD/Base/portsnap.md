+++
title = "[PukiWiki:freebsd] FreeBSD/Base/portsnap"
date = "2008-11-16T12:52:30Z"
+++


# portsnap って？  {#t85480c7}
[こちら](http://wiki.fdiary.net/BSDmad/?portsnap "こちら") のサイトで詳しく解説されています。

[On-line Manual of "portsnap"](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=portsnap&dir=jpman-6.2.2%2Fman&sect=8 "On-line Manual of "portsnap"")
[Using Portsnap](http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/portsnap.html "Using Portsnap")
[BSD にくびったけ - portsnap](http://wiki.fdiary.net/BSDmad/?portsnap "BSD にくびったけ - portsnap")

# portsnap.conf の設定  {#zb10eb56}

```
# vi /etc/portsnap.conf

WORKDIR=/var/db/portsnap
PORTSDIR=/usr/ports
SERVERNAME=portsnap.allbsd.org
KEYPRINT=****************************************************************
REFUSE arabic chinese french german hebrew hungarian
REFUSE korean polish portuguese russian ukrainian vietnamese
REFUSE x11 x11-clocks x11-fm x11-fonts
REFUSE x11-servers x11-themes x11-toolkits x11-wm

```

# 更新の仕方  {#d8ae7b64}
初回は下記のコマンドを実行して下さい。
なお、既存のportsディレクトリは削除されてしまうのでご注意下さい。


```
# portsnap fetch extract update

```

初回以降の更新は差分で行われます。
更新するには下記のコマンドを実行して下さい。


```
# portsnap fetch update

```

# 自動更新  {#f905c8a3}
以下のような内容のシェルスクリプトを作成して、 INDEX の自動更新を行います。
シェルスクリプトを作成するにあたって、下記のサイトに掲載されているシェルスクリプトを参考にしました。
[BSD にくびったけ - portsnap](http://wiki.fdiary.net/BSDmad/?portsnap "BSD にくびったけ - portsnap")


```
# mkdir -p /usr/local/etc/periodic/daily
# vi /usr/local/etc/periodic/daily/999.portsnap-status

```


```
#!/bin/sh
#

# If there is a global system configuration file, suck it in.
#
if [ -r /etc/defaults/periodic.conf ]
then
    . /etc/defaults/periodic.conf
    source_periodic_confs
fi

rc=0
case "${daily_portsnap_status_enable:-NO}" in
	[Yy][Ee][Ss])
		echo ""
		echo "Ports/Packages update check:"

		(portsnap cron && portsnap -I update) >/dev/null 2>&1

		if [ $? != 0 ]; then
			echo "[Error] portsnap abort."
			exit $?
		fi

		if [ -x /usr/local/sbin/portsdb ]; then
			/usr/local/sbin/portsdb -u >/dev/null 2>&1

			if [ $? != 0 ]; then
				echo "[Error] portsdb abort."
				exit $?
			fi
		fi

		if [ -x /usr/local/sbin/pkgdb ]; then
			/usr/local/sbin/pkgdb -u >/dev/null 2>&1

			if [ $? != 0 ]; then
				echo "[Error] pkgdb abort."
				exit $?
			fi
		fi

		if [ -x /usr/local/sbin/portversion ]; then
			/usr/local/sbin/portversion -vL '=' | sed '/ja.*doc.*/d'
		else
			/usr/sbin/pkg_version -vL '=' | sed '/ja.*doc.*/d'
		fi

		rc=$?
		echo ""
		;;
	*)
		;;
esac

exit "$rc"
```

自動実行されるように権限を付与します。


```
# chmod 755 /usr/local/etc/periodic/daily/999.portsnap-status

```

更に上記のスクリプトはperiodicで実行され、daily_portsnap_status_enableがYES(大文字小文字問わず)の時に実行されるようになっています。
なので、上記のスクリプトを実行したい場合には/etc/periodic.confを以下のように編集して下さい。


```
# vi /etc/periodic.conf

```


```
# fetch INDEX for portsnap.
daily_portsnap_status_enable="YES"
```

なお、このシェルスクリプトはあくまでINDEXの更新のみなので、実際に更新を行う場合は以下のようにportsnapでportsをアップデートしてからportsをインストールして下さい。


```
# portsnap fetch update
```

