+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Subversion"
date = "2008-12-10T09:33:19Z"
+++

# 目次  {#c9af4bc5}

# リンク  {#q923e8b2}
- [WikiPedia.ja:Subversion](https://ja.wikipedia.org/wiki/Subversion "WikiPedia.ja:Subversion")
- [Subversion Manual](http://subversion.bluegate.org/doc/index.html "Subversion Manual")
- [TortoiseSVN Manual](http://tortoisesvn.net/docs/release/TortoiseSVN_ja/index.html "TortoiseSVN Manual")

# はじめに  {#ne058c94}
[pkgtools.conf](/archive/wiki/BSD/FreeBSD/portupgrade/#ue11c464 "pkgtools.conf") を設定しておく。

# インストール  {#u21e1614}

```
# portinstall devel/subversion
# rehash
```

httpd.conf に dav_module が二つあると思うので一つを削除 or コメントアウト。

```
# cat /usr/local/etc/apache22/httpd.conf | grep dav_module
LoadModule dav_module libexec/apache22/mod_dav.so
LoadModule dav_module libexec/apache22/mod_dav.so

# vi /usr/local/etc/apache22/httpd.conf

#LoadModule dav_module libexec/apache22/mod_dav.so

```

# Sandbox ( 練習用リポジトリ ) の作成  {#s89cd1a3}

```
# mkdir -p /usr/local/var/svn/repos
# svnadmin create /usr/local/var/svn/repos/sandbox
# chown -R svn:svn /usr/local/var/svn/repos/sandbox

```

# OpenSSH on Subversion  {#n4d2cc22}
svn専用ユーザを追加する。


```
# pw groupadd -n svn
# pw useradd -n svn -c "Subversion Comit User" -d /home/svn -g svn -h - -s /bin/sh
# mkdir -p /home/svn/.ssh
# chown -R svn:svn /home/svn

```

一般ユーザの公開鍵を **/home/svn/.ssh** にコピーする。
通常の公開鍵だとシェルでのログインも出来てしまうので、 command 等を公開鍵の先頭に追記する。 ( 実際は一行 )


```
command="svnserve -t --tunnel-user=コミットユーザ名 -r /usr/local/var/svn/repos"
,no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-dss AAAAB（中略）M6BA== ****@examle.com

```

sshd_config で AllowUsers を設定している場合は svn ユーザを追加する。


```
# grep AllowUsers /etc/ssh/sshd_config

AllowUsers user svn

# /etc/rc.d/sshd restart

```

# Apache WebDAV on Subversion  {#bcbb1f73}


```
# vi /usr/local/etc/apache22/Includes/subversion.conf

<Location /svn>
	DAV svn
	SVNParentPath /usr/local/var/svn/repos
	SVNListParentPath On

	<LimitExcept GET PROPFIND OPTIONS REPORT>
		Deny from all
	</LimitExcept>
</Location>

```

リポジトリ一覧を見せたくない場合は SVNListParentPath を off にする。
