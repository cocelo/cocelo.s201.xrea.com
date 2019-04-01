+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Apache_2.2/Accept_Filter"
date = "2008-10-16T04:12:06Z"
+++


# Accept Filter  {#e2ea42f6}
Accept Filter については[こちら](http://httpd.apache.org/docs/2.2/ja/mod/core.html#acceptfilter "こちら")を参照してください。
要は完全な HTTP ヘッダが送られてくるまでサーバープロセスに渡さないってことらしいです。 ( なんか間違ってる気が･･･ )

# インストール  {#e78ba8db}
Accept Filter を使うには kldload による方法と、カーネル再構築の二通りあります。
カーネル再構築の方法については [こちら](/archive/freebsd/FreeBSD/Base/Kernel/ "こちら") をご参照ください。

## kldload  {#rdcdf453}
kldload でモジュールを有効にします。


```
% kldload accf_http accf_data

```

## カーネル再構築  {#pafe39b0}
カーネル再構築の際は options で指定します。


```
options ACCEPT_FILTER_HTTP
options ACCEPT_FILTER_DATA

```

# 有効にする  {#j49c8004}
Accept Filter を有効にする為に、 rc.conf に以下の内容を記述します。


```
% sudo vi /etc/rc.conf

apache22_http_accept_enable="YES"

```

# 再起動  {#dcabeab9}
再起動して ps を打ってみましょう。


```
% sudo /usr/local/etc/rc.d/apache22 restart

% ps -ax | grep httpd
  786  ??  Ss     0:00.83 /usr/local/sbin/httpd
  865  ??  I      0:00.00 /usr/local/sbin/httpd
  866  ??  I      0:00.00 /usr/local/sbin/httpd
  867  ??  I      0:00.00 /usr/local/sbin/httpd
  868  ??  I      0:00.00 /usr/local/sbin/httpd
  869  ??  I      0:00.00 /usr/local/sbin/httpd
```

