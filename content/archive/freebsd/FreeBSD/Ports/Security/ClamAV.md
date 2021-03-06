+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Security/ClamAV"
date = "2008-10-16T04:12:11Z"
+++


# ClamAV の導入  {#v29efcc4}
アンチウイルスソフトウェアである ClamAV をインストールします。


```
% sudo portinstall security/clamav
% rehash

```

# ClamAV の設定  {#iefd9293}

```
% sudo chmod 644 /usr/local/etc/clamd.conf
% sudo vi /usr/local/etc/clamd.conf

LogTime yes

```

# freshclam の設定  {#x0a0a59b}
デフォルトでは二時間ごとにウイルス定義を更新します。


```
% sudo chmod 644 /usr/local/etc/freshclam.conf
% sudo vi /usr/local/etc/freshclam.conf

LogVerbose yes

```

# 自動起動の設定  {#g7dbac9b}

```
% sudo vi /etc/rc.conf

clamav_clamd_enable="YES"
clamav_freshclam_enable="YES"

```

# 起動  {#t49ff540}

```
% sudo /usr/local/etc/rc.d/clamav-clamd start
% sudo /usr/local/etc/rc.d/clamav-freshclam start

```

# freshclam でウイルス定義を最新に  {#id7c610c}

```
% sudo freshclam

```

# ウイルス格納ディレクトリの作成  {#tee69f50}

```
% sudo mkdir -p /usr/local/var/clamd/virus
% sudo chown -R clamav:clamav /usr/local/var/clamd

```

# ウイルススキャン  {#r8180800}

```
% sudo clamdscan --move=/usr/local/var/clamd/virus /
```

