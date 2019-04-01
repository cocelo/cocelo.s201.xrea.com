+++
title = "[PukiWiki:wiki] Linux/Gentoo_Linux/Stage_1_Install"
date = "2008-12-10T09:33:21Z"
+++

# Gentoo Linux Stage 1 Install Memo  {#hc5f083e}
Gentoo Linux Stage 1 インストール作業メモ。

**Stage 1 からインストールする場合はかなり面倒な手順を踏まないとダメなようです。実際ここに書いてある通りに進めるとエラーが出ます。詳細は下記のリンクをご覧ください。**

- [HOWTO Advanced Install - Gentoo Linux Wiki](http://gentoo-wiki.com/HOWTO_Advanced_Install#Bootstrapping_and_System "HOWTO Advanced Install - Gentoo Linux Wiki")
- [Gentoo Forums :: View topic - Fiordland Stage 1 Install Guide Ver. 2.0 \(updated\)](http://forums.gentoo.org/viewtopic-t-529639-highlight-stage+1.html "Gentoo Forums :: View topic - Fiordland Stage 1 Install Guide Ver. 2.0 \(updated\)")
- [Jackass! Development Labs :: View topic - Stage 1/3 Installation Guide: 2006.0, GCC 4.1.1, Glibc 2.4](http://jackass.homelinux.org/forums/viewtopic.php?t=133 "Jackass! Development Labs :: View topic - Stage 1/3 Installation Guide: 2006.0, GCC 4.1.1, Glibc 2.4")
- [Cocelo Style](http://d.hatena.ne.jp/cocelo/20070217/1171715157 "Cocelo Style")


## インストール準備  {#s7558146}
- [mirror.gentoo.gr.jp](http://mirror.gentoo.gr.jp/ "mirror.gentoo.gr.jp")

メディアは **/releases/amd64/2006.1/installcd** からダウンロード。

bootable image として CD-R ( or CD-RW ) に焼く。

正常に焼けている事が確認出来たらマシンにセット、起動。

## 起動後  {#r812d353}
まずは root のパスワードが設定されていないので passwd で設定する。

```
# passwd
```

キーマップが jp106 以外 ( Shift + 2 でシャープ ''#'' 以外になる時 ) loadkeys で jp106 を指定する。

```
# loadkeys jp106
```

リモートで作業したいので sshd デーモンを立ち上げる。

```
# /etc/init.d/sshd start
```

この後は全てリモートで作業する。

## ネットワークの設定  {#r365a854}
クライアントで使う場合は DHCP でも構わないと思うが、サーバなどでは static な IP のが良い場合が多々あると思うのでサーバ用途の時は下記のように設定する。

```
# ifconfig eth0 192.168.1.100 broadcast 192.168.1.255 netmask 255.255.255.0 up
```

デフォルトゲートウェイの設定

```
# route add default gw 192.168.1.1
```

DNS 名前解決の設定

```
# vim /etc/resolv.conf

domain clx.ath.cx
nameserver 192.168.1.101
```

**clx.ath.cx** には各自のドメインを入れる。

また、 **192.168.168.1.101** にはルータやプロバイダの DNS サーバを指定する。

なお、リモートで作業している場合は接続が中断されるが、設定した IP に従って再接続すれば作業を再開出来る。

## パーティション切り分け  {#c1d561f9}

```
# fdisk /dev/sdb
```

**sdb** は各自の環境で異なるので **dmesg** で確認すること

どの程度領域を確保するか悩みどころだけど、近年の HDD の GB あたりの単価で考えれば全ての領域に対して余裕を持たせてもいいかもしれない。

ちなみに今回 250GB の SATA HDD にセットアップしたパーティションは下記の通り。

```
/boot - 256M     - ext2
/     - 残り全て - reiserfs
swap  - 4096MB   - swap

```

フォーマットも忘れないこと。

```
# mke2fs /dev/sdb1
# mkswap /dev/sdb2
# swapon /dev/sdb2
# mkreiserfs /dev/sdb3

```

## パーティションのマウント  {#y6f77054}
パーティションを切ってもマウントしなければ意味がないので各自のパーティションに合わせたマウントをすること。

```
# mount /dev/sdb3 /mnt/gentoo
# mkdir /mnt/gentoo/boot
# mount /dev/sdb1 /mnt/gentoo/boot

```

## 時計合わせ  {#fb1c3ed3}

```
# date
# date 112233445566 ( ずれている場合 )
```

ntp-date くらい入れておいても良いと思うんだ･･･。

## Stage 1 のダウンロードと展開  {#oa68abe1}
Stage 1 を展開する為、 Current Directory を変更する。

```
# cd /mnt/gentoo
```

適当なミラー ( 上記に例を挙げた mirror.gentoo.gr.jp など ) から Stage 1 のファイルをダウンロードする。


```
# wget http://mirror.gentoo.gr.jp/releases/amd64/current/stages/stage1-amd64-2006.1.tar.bz2
# wget http://mirror.gentoo.gr.jp/releases/amd64/current/stages/stage1-amd64-2006.1.tar.bz2.DIGESTS
```

ダウンロードが完了したら MD5 チェックサム で確認する。

```
# md5sum -c stage1-amd64-2006.1.tar.bz2.DIGESTS
```

問題が無かったら tar コマンドでアーカイブを展開する。

```
# tar -xvjpf stage1-amd64-2006.1.tar.bz2
```

展開が終わったら Stage 1 アーカイブは不要なので削除する。

```
# rm -fr stage1-amd64-2006.1.tar.bz2*

```

## Portage スナップショットのダウンロードと展開  {#yfd5dc22}

```
# cd /mnt/gentoo
# wget http://mirror.gentoo.gr.jp/snapshots/portage-latest.tar.bz2
# wget http://mirror.gentoo.gr.jp/snapshots/portage-latest.tar.bz2.md5sum
# md5sum -c portage-latest.tar.bz2.md5sum
# tar xvjf /mnt/gentoo/portage-latest.tar.bz2 -C /mnt/gentoo/usr
# rm -fr portage-latest.tar.bz2*

```

## /etc/make.conf の設定  {#z1bec1a7}

```
# vim /mnt/gentoo/etc/make.conf

CHOST="x86_64-pc-linux-gnu"
CFLAGS="-march=nocona -O2 -fomit-frame-pointer -pipe"
CXXFLAGS="${CFLAGS}"
FEATURES="ccache"
MAKEOPTS="-j2"

GENTOO_MIRRORS="http://mirror.gentoo.gr.jp http://ftp.jaist.ac.jp/pub/Linux/Gentoo/ "
SYNC="rsync://rsync.asia.gentoo.org/gentoo-portage"

```

ハンドブックでは USE フラグの設定を後回しにしているが、ここで設定してしまう。

```
USE="mmx sse sse2 nptl"
```

まだ私自身もインストールしている最中なのでよくわかっていないのでとりあえず。

## ベースシステムコンパイルの準備  {#daa5c583}
DNS 名前解決の設定ファイルをコピー。

```
# cp -L /etc/resolv.conf /mnt/gentoo/etc/resolv.conf

```

/proc ファイルシステムのマウント。

```
# mount -t proc none /mnt/gentoo/proc

```

/dev ファイルシステムの bind マウント。

```
# mount -o bind /dev /mnt/gentoo/dev

```

/mnt/gentoo に chroot する。

```
# chroot /mnt/gentoo /bin/bash

```

環境変数を更新。

```
# env-update && source /etc/profile

```

Portage ツリーの更新。

```
# emerge --sync

```

## glibc のロケールを限定する。  {#ye3eadc3}

```
# nano -w /etc/locale.gen

#en_US ISO-8859-1
#en_US.UTF-8 UTF-8
#ja_JP.EUC-JP EUC-JP
#ja_JP.UTF-8 UTF-8
#ja_JP EUC-JP
```

通常ならこのように全てのロケールがコメントアウトされているので、これを下記のようにコメントアウトを外す。

```
en_US ISO-8859-1
en_US.UTF-8 UTF-8
ja_JP.EUC-JP EUC-JP
ja_JP.UTF-8 UTF-8
ja_JP EUC-JP

```

## ccache をインストールする  {#r8b61cd0}
make.conf で FEATURES に ccache を指定した場合、 ccache が使えるので ccache をインストールします。

```
# emerge --oneshot --nodeps ccache

```

また、ccache を使う場合はユーザのホームディレクトリにキャッシュが生成されてしまう為、ホームディレクトリにインボリックリンクを張ります。

```
# rm -r /root/.ccache
# mkdir /var/tmp/ccache
# ln -s /var/tmp/ccache /root/.ccache 

```

## bootstrap システムをコンパイルする  {#b7d58287}

```
# cd /usr/portage
# scripts/bootstrap.sh -f
```

**-f** オプションを付けるとまずソースコードをダウンロードしてからコンパイルを始める。

Gentoo を使ってる人でナローバンドな人はいいかもしれない。

･･･その前にうぶんつでも使ったようないい気がするけど･･･。

また、自分の環境では dev-perl/Locale-gettext-1.05 でエラーを吐いてしまったので手動で **emerge --nodeps libperl perl** とした。

参考文献
- [Gentoo Forums :: View topic - Stage 1, 2006.0, x86_64 emerge -e system error[SOLVED]](http://forums.gentoo.org/viewtopic-p-3382945.html "Gentoo Forums :: View topic - Stage 1, 2006.0, x86_64 emerge -e system error[SOLVED]")
    -  今度は dev-lang/perl でエラーが出てしまった。

## ベースシステム をコンパイルする  {#j7a9fccc}
上記で bootstrap するために必要なソフトウェアはコンパイルされたので、 Gentoo Linux のベースとなるソフトウェアをコンパイルする。

```
# emerge system
```

性能が貧弱なマシンだと数日かかるかもしれないので注意すること。

( そういう場合は素直に Stage 3 からインストールした方が良い )

## タイムゾーンの設定  {#bc21d46a}
シンボリックリンクを張るだけ。

```
# ln -sf /usr/share/zoneinfo/Japan /etc/localtime

```

続きは後ほど
