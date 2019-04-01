+++
title = "[PukiWiki:freebsd] FreeBSD/Utility/fastest_cvsup"
date = "2008-10-16T04:12:14Z"
+++


# fastest_cvsup の導入  {#l29bcd35}
fastest_cvsup は応答が良い cvsup サーバを探してくれるツールです。

# インストール  {#i5534103}
portinstall でインストールします。


```
% sudo portinstall sysutils/fastest_cvsup
% rehash

```

# 使用方法  {#ad179728}
使用方法は下記の通りです。
この場合は cvsup2.jp.freebsd.org が応答が良いことになります。


```
% fastest_cvsup -c jp

>>  Querying servers in countries: jp
--> Connecting to cvsup.jp.freebsd.org [210.224.172.75]...
    - server replied: OK 17 0 SNAP_16_1h CVSup server ready
    - time taken: 30.77 ms
--> Connecting to cvsup2.jp.freebsd.org [203.216.196.85]...
    - server replied: OK 17 0 SNAP_16_1h CVSup server ready
    - time taken: 19.70 ms
--> Connecting to cvsup3.jp.freebsd.org [59.106.2.11]...
    - server replied: OK 17 0 SNAP_16_1h CVSup server ready
    - time taken: 23.74 ms
--> Connecting to cvsup4.jp.freebsd.org [133.1.240.15]...
    - server replied: ! Access limit exceeded; try again later
    - time taken: 36.54 ms
--> Connecting to cvsup5.jp.freebsd.org [210.161.150.4]...
    - server replied: OK 17 0 SNAP_16_1h CVSup server ready
    - time taken: 31.58 ms
--> Connecting to cvsup6.jp.freebsd.org [59.106.2.11]...
    - server replied: OK 17 0 SNAP_16_1h CVSup server ready
    - time taken: 23.78 ms

>>  Speed Daemons:
    - 1st: cvsup2.jp.freebsd.org    19.70 ms
    - 2st: cvsup3.jp.freebsd.org    23.74 ms
    - 3st: cvsup6.jp.freebsd.org    23.78 ms
```

