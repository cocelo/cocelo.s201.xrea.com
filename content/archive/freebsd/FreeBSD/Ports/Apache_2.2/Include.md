+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Apache_2.2/Include"
date = "2008-10-16T04:12:07Z"
+++


# エラーページ ( 404 Not Found 等 ) を日本語に  {#b724097e}
通常 HTTP 404 などでは英語のページが表示されますが、これを日本語表示にします。


```
# vi /usr/local/etc/apache22/httpd.conf

# Multi-language error messages
Include etc/apache22/extra/httpd-multilang-errordoc.conf

```

# 文字エンコーディングを日本語に  {#t7e4f5c3}
デフォルトの設定だと文字エンコーディングが設定されていないので、これを文字エンコーディングを表示言語によって判別します。


```
# vi /usr/local/etc/apache22/httpd.conf

# Language settings
Include etc/apache22/extra/httpd-languages.conf

```

# Apache の情報を Web 上で参照出来るように  {#rd841fcf}
どのモジュールを使用しているか、などは apachectl 等のツールや設定ファイルを見て判断しますが、これを Web 上で参照出来るようにします。


```
# vi /usr/local/etc/apache22/httpd.conf

# Real-time info on requests and configuration
Include etc/apache22/extra/httpd-info.conf

```

アクセス制御の設定をローカルネットワークに限定します。


```
# vi /usr/local/etc/apache22/extra/httpd-info.conf

<Location /server-status>
    SetHandler server-status
    Order deny,allow
    Deny from all
    Allow from 192.168.1.0/24
</Location>

ExtendedStatus On

<Location /server-info>
    SetHandler server-info
    Order deny,allow
    Deny from all
    Allow from 192.168.1.0/24
</Location>

```

# Apache のマニュアルを参照出来るように  {#y299ea8b}
Apache の設定をしていると、度々マニュアルを参照することになると思います。
これをサーバで表示出来るようにして、無駄なトラフィックを発生させないようにします。


```
# vi /usr/local/etc/apache22/httpd.conf

# Local access to the Apache HTTP Server Manual
Include etc/apache22/extra/httpd-manual.conf

```

# その他の Apache の設定  {#e66ac05a}
KeepAlive やフッタ情報に付与する情報などの設定を行います。


```
# vi /usr/local/etc/apache22/httpd.conf

# Various default settings
Include etc/apache22/extra/httpd-default.conf

```

KeepAlive などの設定例は [チューニング](/archive/freebsd/FreeBSD/Ports/Apache_2.2/Tuning/ "チューニング") をご覧ください。


```
# vi /usr/local/etc/apache22/extra/httpd-default.conf

ServerTokens OS

ServerSignature Off

```

# 再起動  {#k7537422}
Apache を再起動します。


```
# /usr/local/etc/rc.d/apache22 restart
```

