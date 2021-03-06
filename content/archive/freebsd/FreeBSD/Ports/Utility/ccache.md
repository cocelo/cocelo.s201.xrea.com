+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Utility/ccache"
date = "2009-12-04T19:39:42Z"
+++


# ccache って？  {#qa947c16}
ccache はプログラムのコンパイル時の中間結果を保存して再利用することが出来るユーティリティです。

# インストール  {#ye6c921d}
portinstall でインストール。


```
% sudo portinstall devel/ccache
```

インストールの終わりに下記のように表示されます。


```
=== NOTE ===
Please read /usr/local/share/doc/ccache/ccache-howto-freebsd.txt for
information on using ccache with FreeBSD ports and src.
```

# distccと併用しない場合  {#e7a78944}

## make.conf の設定  {#a0b25030}
上記のインフォメーションに目を通して設定します。


```
% sudoedit /etc/make.conf
```


```
.if exists(/usr/local/libexec/ccache) && \
	!empty(.CURDIR:M/usr/ports*) && \
	!defined(NOCCACHE)
CC=/usr/local/libexec/ccache/world-cc
CXX=/usr/local/libexec/ccache/world-c++
.endif
```

## csh/tcsh の環境変数を設定  {#df9d93b1}
csh/tcsh をお使いの方は /etc/csh.cshrc の設定を行います。


```
% sudoedit /etc/csh.cshrc
```


```
setenv PATH /usr/local/libexec/ccache:$PATH
setenv CCACHE_PATH /usr/bin:/usr/local/bin
setenv CCACHE_DIR "/var/db/ccache"
setenv CCACHE_LOGFILE "/var/log/ccache.log"
```

## sh/bash/zsh の環境変数を設定  {#i67bdf72}
sh/bash/zsh をお使いの方は /etc/profile の設定を行います。


```
% sudoedit /etc/profile
```


```
export PATH="/usr/local/libexec/ccache:${PATH}"
export CCACHE_PATH="/usr/bin:/usr/local/bin"
export CCACHE_DIR="/var/db/ccache"
export CCACHE_LOGFILE="/var/log/ccache.log"
```

## キャッシュディレクトリの作成  {#f4bb251b}
キャッシュを保存しておくディレクトリを作成しておきます。


```
% sudo mkdir -p /var/db/ccache
```
