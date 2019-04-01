+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/cronolog"
date = "2008-10-16T04:12:07Z"
+++


# cronolog でログローテーション  {#e89edee5}
Web サイトのログは放置していると日々肥大していく一方です。
そこで、ログファイルを適切に分割、ローテーションし、管理を楽にします。

# cronolog の導入  {#m884a050}
Apache には標準で rotatelogs というパイプ型のログローテーションツールが付属していますが、これを更に高機能にした cronolog というツールが存在します。
これは日付毎にディレクトリを掘ったりできるので、非常に便利です。


```
# cd /usr/ports/sysutils/cronolog
# make install clean

```

# Apache のログローテーション  {#va28dd16}
正常にインストール出来たら Apache の ErrorLog および CustomLog を書き換えます。


```
# vi /usr/local/etc/apache22/httpd.conf

```


```
#ErrorLog "/var/log/httpd-error.log"
ErrorLog "|/usr/local/sbin/cronolog /var/log/apache22/%Y/%m/%d/httpd-error.log"
#CustomLog "/var/log/httpd-access.log" combined
CustomLog "|/usr/local/sbin/cronolog /var/log/apache22/%Y/%m/%d/httpd-access.log" combined
```

# Apache の再起動  {#wd522382}
Apache を再起動して設定を反映させます。


```
# /usr/local/etc/rc.d/apache22 restart
```

