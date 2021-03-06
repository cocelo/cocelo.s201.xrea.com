+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Tuning"
date = "2008-12-10T09:33:19Z"
+++

# FreeBSD Tuning  {#xddd9d43}


## Link  {#g550b70d}

### Official  {#gbbc7578}
- [On-line Manual of "security"](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=security&dir=jpman-6.2.2%2Fman&sect=7 "On-line Manual of "security"")
- [On-line Manual of "tuning"](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=tuning&dir=jpman-6.2.2%2Fman&sect=7 "On-line Manual of "tuning"")

### Other  {#p011ff87}
- [Firewall/ipf4 - Hiromi@tac](http://www.tac.tsukuba.ac.jp/~hiromi/index.php?Firewall%2Fipf4 "Firewall/ipf4 - Hiromi@tac")
- [AOL Q&A広場 起動時のfsckの自動実行](http://aol.okwave.jp/qa2454136.html "AOL Q&A広場 起動時のfsckの自動実行")
- [SYONテクニカル: 「daemontools」を利用したサービス監視](http://www.syon.co.jp/syontech/tech012.html "SYONテクニカル: 「daemontools」を利用したサービス監視")
- [FreeBSD/ネットワーク - BugbearR's Wiki](http://www.bugbearr.jp/?cmd=read&page=FreeBSD%2F%E3%83%8D%E3%83%83%E3%83%88%E3%83%AF%E3%83%BC%E3%82%AF "FreeBSD/ネットワーク - BugbearR's Wiki")
- [A basic guide to securing FreeBSD 4.x-STABLE](http://draenor.org/securebsd/secure.txt "A basic guide to securing FreeBSD 4.x-STABLE")
- [Tuning FreeBSD for different applications](http://silverwraith.com/papers/freebsd-tuning.php "Tuning FreeBSD for different applications")
- [大規模サイトの為のFreeBSDカーネルチューニング](http://www.nxhack.tarumi.kobe.jp/FreeBSD_kernel_tuning.html "大規模サイトの為のFreeBSDカーネルチューニング")
- [うにっくすさんの覚え書き - FreeBSD - 私的システムチューニング](http://www.nognog.com/techmemo/FreeBSD_Tuning_HOWTO.php "うにっくすさんの覚え書き - FreeBSD - 私的システムチューニング")
- [カーネルチューニング](http://apex.wind.co.jp/tetsuro/f-bsd/kernel.html "カーネルチューニング")
- [FreeBSDで上りの速度を速くしよう](http://himagine.s20.xrea.com/bamp/freebsd_upfast.html "FreeBSDで上りの速度を速くしよう")

## vipw  {#x790b017}
toor アカウント無効化。

## /var/cron/allow  {#n6f968df}
管理ユーザを記述。

## /etc/rc.conf  {#rdee848b}

```
# vi /etc/rc.conf

# SYN+FIN フラグの TCP パケットを破棄
# カーネルに TCP_DROP_SYNFIN オプションを付けた場合のみ利用可能
tcp_drop_synfin="YES"
# ICMP Redirect を破棄
icmp_drop_redirect="YES"
# syslogd セキュリティ設定
# 詳細は syslogd(8)
syslogd_flags="-ss"
# fsck 自動実行時の質問に全て yes で答える
fsck_y_enable="YES"
# カーネルレベル
kern_securelevel="1"
kern_securelevel_enable="YES"
# コマンドの実行履歴を取る
accounting_enable="YES"

```

## /etc/sysctl.conf  {#ve2ca565}

```
# vi /etc/sysctl.conf

net.inet.tcp.blackhole=2
net.inet.udp.blackhole=1
net.inet.icmp.drop_redirect=1
kern.polling.enable=1

```

[【banana2828】news.80.kg/vip.80.kgサーバ構築の巻](http://bbs.newsplus.jp/test/read.cgi/bbs/1163428652/37 "【banana2828】news.80.kg/vip.80.kgサーバ構築の巻")

```
# 忙しいサーバ用にパラメータを大きくする
# increase maximum file descriptors
kern.maxfiles=32768
kern.maxfilesperproc=16384
# increase listen queue
kern.ipc.somaxconn=8192
# increase socket buffer size
kern.ipc.maxsockbuf=2097152
# ICMP をたくさん処理する必要がある場合のパフォーマンス低下を防ぐ
# see http://qb5.2ch.net/test/read.cgi/operate/1097931665/666-676
net.inet.icmp.icmplim=3000
net.inet.icmp.icmplim_output=0
# 使える共有メモリのサイズを大きくする
# shared memory tunings
kern.ipc.shmall=16384
kern.ipc.shmmax=67108864
# ネットワーク送受信のバッファサイズを大きくする
# increase network send/receive buffer
net.inet.tcp.sendspace=131072
net.inet.tcp.recvspace=131072
net.inet.udp.maxdgram=131072
net.inet.udp.recvspace=131072
net.local.stream.sendspace=131072
net.local.stream.recvspace=131072
net.local.dgram.maxdgram=131072
net.local.dgram.recvspace=131072
net.inet.raw.recvspace=131072
net.inet.raw.maxdgram=131072

```

以下デフォルト値。
HP ProLiant ML115 標準構成 ( Mem 512M )

```
# sysctl kern.maxfiles
kern.maxfiles: 8136
# sysctl kern.maxfilesperproc
kern.maxfilesperproc: 7322
# sysctl kern.ipc.somaxconn
kern.ipc.somaxconn: 128
# sysctl kern.ipc.maxsockbuf
kern.ipc.maxsockbuf: 262144
# sysctl net.inet.tcp.sendspace
net.inet.tcp.sendspace: 32768
# sysctl net.inet.tcp.recvspace
net.inet.tcp.recvspace: 65536
# sysctl net.inet.udp.maxdgram
net.inet.udp.maxdgram: 9216
# sysctl net.inet.udp.recvspace
net.inet.udp.recvspace: 41600
# sysctl net.local.stream.sendspace
net.local.stream.sendspace: 8192
# sysctl net.local.stream.recvspace
net.local.stream.recvspace: 8192
# sysctl net.local.dgram.maxdgram
net.local.dgram.maxdgram: 2048
# sysctl net.local.dgram.recvspace
net.local.dgram.recvspace: 4096
# sysctl net.inet.raw.recvspace
net.inet.raw.recvspace: 8192
# sysctl net.inet.raw.maxdgram
net.inet.raw.maxdgram: 8192

```

## /boot/loader.conf  {#a4c8cd37}

```
autoboot_delay="3"
kern.ipc.nmbclusters="0"
kern.maxusers="512"

```

HP ProLiant ML115 標準構成 ( Mem 512M )

```
# sysctl kern.ipc.nmbclusters
kern.ipc.nmbclusters: 17216
# sysctl kern.maxusers
kern.maxusers: 253

```

autoboot_delay は起動時間の短縮。

kern.ipc.nmbclusters は Errata [20070116, update 20070212] を参照。

## /etc/fstab  {#t4c7a550}
/tmp を rw,nodev,nosuid に。

```
/dev/ad6s1e             /tmp            ufs     rw,nodev,nosuid 2       2
```

ついでに /cdrom を削除。

## /etc/ttys  {#r69f59a8}
コンソールから操作する場合はパスワードを要求。

```
console none                            unknown off insecure

```

## Other  {#z1379b21}

```
chmod 0750 /root
```

