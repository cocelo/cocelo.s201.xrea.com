+++
title = "[PukiWiki:freebsd] FreeBSD/Base/csup"
date = "2008-10-16T04:12:05Z"
+++


# csup について  {#gf71406f}
昔は cvsup というソフトウェアでソースツリーの更新や ports の更新を行っていました。
この cvsup というソフトウェアは Modula-3 という言語で書かれていたため、動作が非常に遅いというのも有名です。
そこで近年、この cvsup を C 言語で書き直されたソフトウェアが csup です。

# 応答速度の良いサーバを選択する  {#m1da796c}
詳細は [こちら](/archive/freebsd/FreeBSD/Utility/fastest_cvsup/ "こちら") をご覧ください。

# ソースツリーの同期  {#y642d016}

```
# csup -h cvsup2.jp.freebsd.org -4 -1 -Z -l /var/run/csup.pid -L 2 /usr/share/examples/cvsup/standard-supfile

```

# make update でソースツリーの更新  {#z32cd005}

```
# vi /etc/make.conf

SUP_UPDATE=	yes
SUP=		/usr/bin/csup
SUPFLAGS=	-4 -1 -Z -l /var/run/csup.pid -L 2
SUPHOST=	cvsup2.jp.freebsd.org
SUPFILE=	/usr/share/examples/cvsup/standard-supfile
#PORTSSUPFILE=	/usr/share/examples/cvsup/sup/ports-supfile
#DOCSUPFILE=	/usr/share/examples/cvsup/sup/doc-supfile

```

# make update の仕方  {#y7bcc643}

```
# cd /usr/src
# make update

```

# 注意事項  {#ob06df89}
たまに csup を cron で定期的に実行されている方がいらっしゃいますが、それは間違いです。
サーバのリソースを提供されている方もボランティアで提供されているので、 SA が出た時意外などは無闇に csup はしないようにしましょう。

# リンク  {#y765016f}
[On-line Manual of "csup"](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=csup&dir=jpman-6.2.2%2Fman&sect=1 "On-line Manual of "csup"")
[Using CVSup](http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/cvsup.html "Using CVSup")
