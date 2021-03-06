+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Apache_2.2/mod_fcgid"
date = "2008-10-20T17:08:17Z"
+++

# mod_fcgid の導入  {#w9387db1}
mod_fcgid は FastCGI の Apache モジュールの実装のひとつです。
別の実装として、 [mod_fastcgi](FreeBSD/Ports/Apache_2.2/mod_fastcgi "mod_fastcgi") がありますが、こちらは前述のモジュールより高速に動作します。
今回はこの mod_fcgid をインストールします。

# インストール  {#o371bbab}
www/mod_fcgid に該当モジュールがあるので、それをインストールします。


```
# cd /usr/ports/www/mod_fcgid/
# make install clean

```

インストール時のメッセージ。


```
************************************************************
To enable this module, add something like the following
lines to your server configuration file:

  LoadModule fcgid_module libexec/apache22/mod_fcgid.so

  <IfModule mod_fcgid.c>
    AddHandler fcgid-script .fcgi
  </IfModule>
************************************************************
```

# 設定ファイルの編集  {#f86b3059}
以前に mod_fastcgi をインストール、有効にしている方はまずはそちらを無効にします。


```
# vi /usr/local/etc/apache22/httpd.conf

```


```
LoadModule fastcgi_module libexec/apache22/mod_fastcgi.so
↓
#LoadModule fastcgi_module libexec/apache22/mod_fastcgi.so
```

次に mod_fcgid を有効 ( モジュールが読み込まれるよう ) にします。


```
#LoadModule fastcgi_module libexec/apache22/mod_fastcgi.so
LoadModule fcgid_module libexec/apache22/mod_fcgid.so
```

次に *.fcgi が mod_fcgid を使うようにします。
追記する箇所は **IfModule cgid_module** の下あたりが良いかと思います。


```
<IfModule fcgid_module>
    AddHandler fcgid-script .fcgi
</IfModule>
```

# Apache の再起動  {#o70c5001}
最後に Apache を再起動して設定完了です。


```
# /usr/local/etc/rc.d/apache22 restart

```

# リンク  {#mf86a6b6}
[The mod_fcgid Home Page, mod_fcgid is an Apache2 module for FastCGI protcol](http://fastcgi.coremail.cn/ "The mod_fcgid Home Page, mod_fcgid is an Apache2 module for FastCGI protcol")
[FastCGI環境でMT4を使うならMT-Dispatchを使うといいよ - Ogawa::Memoranda](http://as-is.net/blog/archives/001277.html "FastCGI環境でMT4を使うならMT-Dispatchを使うといいよ - Ogawa::Memoranda")
[FreeBSD + Apache2 + mod_fcgid + Ruby On Rails - ふわふわな毎日](http://d.hatena.ne.jp/nazone/20070221/p2 "FreeBSD + Apache2 + mod_fcgid + Ruby On Rails - ふわふわな毎日")
[Apache module mod_fastcgi](http://www.fastcgi.com/mod_fastcgi/docs/mod_fastcgi.html "Apache module mod_fastcgi")
