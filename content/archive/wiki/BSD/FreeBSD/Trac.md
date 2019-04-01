+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Trac"
date = "2008-12-10T09:33:19Z"
+++

# Trac Memo  {#ocba9563}


## Link  {#b0604be1}
- [WikiPedia.ja:Trac](https://ja.wikipedia.org/wiki/Trac "WikiPedia.ja:Trac")
- [The Trac Project - Trac](http://trac.edgewall.org/ "The Trac Project - Trac")
- [Trac Hacks - Plugins Macros etc. - Trac](http://trac-hacks.org/ "Trac Hacks - Plugins Macros etc. - Trac")
- [インタアクト株式会社--業務内容--公開資料](http://www.i-act.co.jp/project/products/products.html "インタアクト株式会社--業務内容--公開資料")
- [TracのOpenID認証プラグインを試す - Ogawa::Memoranda](http://as-is.net/blog/archives/001214.html "TracのOpenID認証プラグインを試す - Ogawa::Memoranda")
- [pm/Tracメモ - Yuna's Trac - Trac](http://yuna.ultimania.org/wiki/pm/Trac%E3%83%A1%E3%83%A2 "pm/Tracメモ - Yuna's Trac - Trac")

## Memo  {#ce350ec0}
japanese/trac はどうも更新が遅れがち？

アレげだったら ports 使わないって手もアリかも。

## First Step  {#o46aea8c}
[pkgtools.conf](/archive/wiki/BSD/FreeBSD/portupgrade/#ue11c464 "pkgtools.conf") を設定しておく。

[Subversion](/archive/wiki/BSD/FreeBSD/Subversion/ "Subversion") をインストールしておく。

[Apache](/archive/wiki/BSD/FreeBSD/Apache/ "Apache") をインストールしておく。

## Trac Install  {#bdf39bd7}

```
# portinstall japanese/trac
# mkdir -p /usr/local/www/trac/sandbox
# trac-admin /usr/local/www/trac/sandbox initenv

```

いろいろ聞かれるので適切に答える。


```
Project Name [My Project]> Sandbox ( Enter )
Database connection string [sqlite:db/trac.db]> ( Enter )
Repository type [svn]> ( Enter )
Path to repository [/path/to/repos]> /usr/local/www/subversion/sandbox ( Enter )
Templates directory [/usr/local/share/trac/templates]> ( Enter )

# chown -R www:www /usr/local/www/trac/sandbox

```

## mod_python Install  {#u1e5f758}


```
# portinstall www/mod_python3

```

## Apache Setting  {#c5597565}


```
# vi /usr/local/etc/apache22/httpd.conf

```

追加。


```
LoadModule python_module libexec/apache22/mod_python.so

```

後は見えるように設定。


```
# vi /usr/local/etc/apache22/Includes/trac.conf

<Location /trac>
	SetHandler mod_python
	PythonHandler trac.web.modpython_frontend
	PythonOption TracEnvParentDir /usr/local/www/trac
	PythonOption TracUriRoot /trac
</Location>
```

