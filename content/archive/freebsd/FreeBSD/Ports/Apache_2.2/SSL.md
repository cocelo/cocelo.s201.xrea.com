+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Apache_2.2/SSL"
date = "2008-10-16T04:12:07Z"
+++


# SSL 通信を有効にする  {#x5a86c30}
Apache 1.3 などでは httpd.conf に全て設定内容が記述されていましたが、 Apache 2.2 から設定内容が分散されて記述されるようになりました。
ここでは SSL 用の Include を有効にします。


```
# vi /usr/local/etc/apache22/httpd.conf

#Include etc/apache22/extra/httpd-ssl.conf
Include etc/apache22/extra/httpd-ssl.conf

```

# サーバ証明書、サーバ秘密鍵の準備  {#r893818b}
暗号化された通信 ( SSL ) を行うのでサーバ証明書とサーバ秘密鍵を用意します。
CA を自前で用意している場合 ( 自己認証局を構築している場合 ) はサーバ証明書とサーバ秘密鍵を発行します。
ベリサイン等にサーバ証明書を発行してもらった場合はそちらのサーバ証明書とサーバ秘密鍵をお使いください。


```
# chmod 444 /usr/local/etc/apache22/server.crt
# chmod 400 /usr/local/etc/apache22/server.key

```

# SSL の設定  {#idaa5003}
Apache SSL 用の設定ファイルを編集します。


```
# vi /usr/local/etc/apache22/extra/httpd-ssl.conf

ServerName www.clx.ath.cx:443
ServerAdmin webmaster@clx.ath.cx

```

# 再起動  {#w5df7fbb}
設定が完了したら再起動します。


```
# /usr/local/etc/rc.d/apache22 restart
```

