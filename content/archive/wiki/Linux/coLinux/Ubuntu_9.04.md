+++
title = "[PukiWiki:wiki] Linux/coLinux/Ubuntu_9.04"
date = "2009-12-29T04:38:50Z"
+++


# インストーラのダウンロード  {#f0db5ba3}
[Henry for coLinux](http://www.henrynestler.com/ "Henry for coLinux")
上記のページから devel-0.8.0 をダウンロードしてくる。
今回は devel-20091115 を選択。

# coLinux のインストール  {#c975e850}
デバックのチェックを外し、イメージファイルはダウンロードしない。

# ネットワークインストーラのダウンロード  {#f0b47ff5}
[9.04\(Jaunty Jackalope\) initrd.gz](http://www.ftp.ne.jp/Linux/packages/ubuntu/archive/dists/jaunty/main/installer-i386/current/images/netboot/ubuntu-installer/i386/initrd.gz "9.04\(Jaunty Jackalope\) initrd.gz")

ダウンロードしてきたらinstaller-initrd.gzにリネーム。

# インストール用バッチファイルの作成  {#y5f2fe88}
Path は各自要確認。


```
installer.bat

```


```
@echo off

fsutil file createnew D:\Profile\AppData\coLinux\Ubuntu\rootfs 3221225472
fsutil file createnew D:\Profile\AppData\coLinux\Ubuntu\swapfs 536870912
fsutil file createnew D:\Profile\AppData\coLinux\Ubuntu\userfs 1073741824

"C:\Program Files\coLinux\colinux-daemon.exe" @D:\Profile\AppData\coLinux\Ubuntu\installer.conf -p D:\Profile\AppData\coLinux\Ubuntu\pid -t nt

pause
```

# インストール用設定ファイルの作成  {#pe0ad227}


```
installer.conf

```


```
kernel="C:\Program Files\coLinux\vmlinux"
cobd0=D:\Profile\AppData\coLinux\Ubuntu\rootfs
cobd1=D:\Profile\AppData\coLinux\Ubuntu\swapfs
cobd2=D:\Profile\AppData\coLinux\Ubuntu\userfs
cofs0="C:\Program Files\coLinux"
root=/dev/ram0 vga=normal ramdisk_size=14409 rw --
ro
initrd="D:\Profile\AppData\coLinux\Ubuntu\installer-initrd.gz"
mem=256
cocon=100x30
eth0=ndis-bridge,"ローカル エリア接続"
eth1=slirp,,tcp:2222:22
ttys0=COM1,"BAUD=115200 PARITY=n DATA=8 STOP=1 dtr=on rts=on"
```

# atkbd.c: Use 'setkeycodes e059 ' to make it known.の対応  {#kebb997e}
[atkbd.c: Use 'setkeycodes e059 <keycode>' to make it known.の対応～Debian関係](http://www.millionwaves.com/archives/2005/11/atkbdc_use_setk.html "atkbd.c: Use 'setkeycodes e059 <keycode>' to make it known.の対応～Debian関係")

# インストール  {#wb8f49c5}

## インストーラー画面  {#bc208284}

#ref(000.JPG,nolink)

#ref(001.JPG,nolink)

#ref(002.JPG,nolink)

#ref(003.JPG,nolink)

#ref(004.JPG,nolink)

[Alt] + F2 でコンソール画面に切り替え。

## コンソール画面  {#vbef79f2}

#ref(005.JPG,nolink)


```
# mkdir -p /mnt/modules
# mount -t cofs cofs0 /mnt/modules
# tar -zxvf /mnt/modules/vmlinux-modules.tar.gz
# mkdir /target
```

[Alt] + F1 でインストーラ画面に切り替え

## インストーラー画面  {#f7256993}

#ref(006.JPG,nolink)

#ref(007.JPG,nolink)

#ref(008.JPG,nolink)

#ref(009.JPG,nolink)

#ref(010.JPG,nolink)

#ref(011.JPG,nolink)

#ref(012.JPG,nolink)

#ref(013.JPG,nolink)

#ref(014.JPG,nolink)

#ref(015.JPG,nolink)

#ref(016.JPG,nolink)

[Alt] + F2 でコンソール画面に切り替え。

## コンソール画面  {#u97eb5ea}

#ref(017.JPG,nolink)


```
# mke2fs -j /dev/cobd0
# tune2fs -i 0 -c 0 -r 0 /dev/cobd0
# mke2fs -j /dev/cobd2
# tune2fs -i 0 -c 0 -r 0 /dev/cobd2
# mount /dev/cobd0 /target
# mkdir /target/home
# mount /dev/cobd2 /target/home
# mkswap /dev/cobd1
# sync;sync;sync;
# swapon /dev/cobd1
# mkdir -p /target/dev
# mknod /target/dev/cobd0 b 117 0
# mknod /target/dev/cobd1 b 117 1
# mknod /target/dev/cobd2 b 117 2
# cd /target
# debootstrap --arch i386 jaunty /target http://ftp.jaist.ac.jp/pub/Linux/ubuntu/
```

回線速度にもよるが、15分程度かかる。

ダウンロードに失敗する場合は公式の[こちら](https://launchpad.net/ubuntu/+archivemirrors "こちら")のページからミラー先を選択すると良いかもしれない。

## chroot  {#l096f62d}


```
# chroot /target /bin/bash
# mount -t proc proc /proc
```

### コンソールの設定  {#mb1a948b}


```
# dpkg-reconfigure console-setup
```

### パッケージ取得先の変更  {#t4d1996e}


```
# vi /etc/apt/sources.list

```


```
# See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# newer versions of the distribution.

deb http://ja.archive.ubuntu.com/ubuntu jaunty main restricted
deb-src http://ja.archive.ubuntu.com/ubuntu jaunty main restricted

## Major bug fix updates produced after the final release of the
## distribution.
deb http://ja.archive.ubuntu.com/ubuntu jaunty-updates main restricted
deb-src http://ja.archive.ubuntu.com/ubuntu jaunty-updates main restricted

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## universe WILL NOT receive any review or updates from the Ubuntu security
## team.
deb http://ja.archive.ubuntu.com/ubuntu jaunty universe
deb-src http://ja.archive.ubuntu.com/ubuntu jaunty universe
deb http://ja.archive.ubuntu.com/ubuntu jaunty-updates universe
deb-src http://ja.archive.ubuntu.com/ubuntu jaunty-updates universe

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu-
## team, and may not be under a free licence. Please satisfy yourself as to-
## your rights to use the software. Also, please note that software in-
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb http://ja.archive.ubuntu.com/ubuntu jaunty multiverse
deb-src http://ja.archive.ubuntu.com/ubuntu jaunty multiverse
deb http://ja.archive.ubuntu.com/ubuntu jaunty-updates multiverse
deb-src http://ja.archive.ubuntu.com/ubuntu jaunty-updates multiverse

## Uncomment the following two lines to add software from the 'backports'
## repository.
## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
# deb http://jp.archive.ubuntu.com/ubuntu jaunty-backports main restricted universe multiverse
# deb-src http://jp.archive.ubuntu.com/ubuntu jaunty-backports main restricted universe multiverse

deb http://ja.archive.ubuntu.com/ubuntu jaunty-security main restricted
deb-src http://ja.archive.ubuntu.com/ubuntu jaunty-security main restricted
deb http://ja.archive.ubuntu.com/ubuntu jaunty-security  universe
deb-src http://ja.archive.ubuntu.com/ubuntu jaunty-security universe
deb http://ja.archive.ubuntu.com/ubuntu jaunty-security multiverse
deb-src http://ja.archive.ubuntu.com/ubuntu jaunty-security multiverse
```

### パッケージ情報の更新  {#s25fc783}


```
# apt-get update
```

### 日本語ロケールの追加  {#u9d9ff3f}


```
# apt-get install language-pack-ja
```

### キーマップの設定  {#s1a5b4fc}


```
# apt-get install console-data
    Select keymap from full list
        pc / qwerty / Japanese / Standard / Standard
```

### タイムゾーンの設定  {#d7bc35f2}


```
# dpkg-reconfigure tzdata
```

### fstab の設定  {#a6d13094}


```
# echo /dev/cobd0 /     ext3 defaults 1 1 >> /etc/fstab
# echo /dev/cobd1 swap  swap defaults 0 0 >> /etc/fstab
# echo /dev/cobd2 /home ext3 defaults 1 1 >> /etc/fstab
# echo none       /proc proc defaults 0 0 >> /etc/fstab
```

### ネットワークの設定  {#td1166b5}


```
# echo auto lo >> /etc/network/interfaces
# echo iface lo inet loopback >> /etc/network/interfaces
# echo auto eth0 >> /etc/network/interfaces
# echo iface eth0 inet dhcp >> /etc/network/interfaces
# echo auto eth1 >> /etc/network/interfaces
# echo iface eth1 inet dhcp >> /etc/network/interfaces
```


```
# echo 127.0.0.1 localhost ubuntu-colinux > /etc/hosts
# echo ubuntu-colinux > /etc/hostname
```

### 一般ユーザの追加とsudoの設定  {#g065f8f0}


```
# passwd root
# adduser ユーザ名
# adduser ユーザ名 users
# adduser ユーザ名 sudo
```


```
# visudo
%sudo ALL=NOPASSWD: ALL
```

### IPv6 を無効に  {#m58eed63}


```
# echo install ipv6 /sbin/modprobe -n -i ipv6 > /etc/modprobe.d/blacklist-ipv6.conf
```

9.10からは以下の方法で無効化できる。


```
# echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
# echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
# sysctl -p
```

### ハードウェア時刻同期を無効に  {#l2d1a97b}


```
# echo HWCLOCKACCESS=no >> /etc/default/rcS
```

### SYN-flood protections を無効に  {#pb4d5128}
devel-20091115 のカーネルは 2.6.25.20 なので SYN-flood protections が使えない。
何も設定しなくても問題はないが、起動時にエラーが出るので net.ipv4.tcp_syncookies をコメントアウト。


```
# vi /etc/sysctl.d/10-network-security.conf
```


```
net.ipv4.tcp_syncookies=1
↓コメントアウト
#net.ipv4.tcp_syncookies=1
```

### 「Setting up console font and keymap ...」の待ち時間を短くする  {#a232e526}
「Setting up console font and keymap ...」で暫く待たされるので途中で処理を終了する。


```
# vi /etc/init.d/console-setup
```


```
set -e

test -f /bin/setupcon || exit 0
↓追記
set -e

uname -r | grep -qe "-co-" && exit 0

test -f /bin/setupcon || exit 0
```

### haltの「Unable to iterate IDE devices」メッセージを出さないように  {#m59bfefb}


```
# vi /etc/init.d/halt
```


```
	# Don't shut down drives if we're using RAID.
	hddown="-h"
↓変更
	# Don't shut down drives if we're using RAID.
	if uname -r | grep -qe "-co-"
	then
		hddown=""
	else
		hddown="-h"
	fi
```

## シャットダウン  {#j2fd97b4}


```
# exit
# halt
```

# 起動用バッチファイルの作成  {#h481fe14}


```
start.bat

```


```
@echo off

"C:\Program Files\coLinux\colinux-daemon.exe" @D:\Profile\AppData\coLinux\Ubuntu\start.conf -p D:\Profile\AppData\coLinux\Ubuntu\pid -t nt

pause
```

# 起動用設定ファイルの作成  {#id4309fe}


```
start.conf

```


```
kernel="C:\Program Files\coLinux\vmlinux"
cobd0=D:\Profile\AppData\coLinux\Ubuntu\rootfs
cobd1=D:\Profile\AppData\coLinux\Ubuntu\swapfs
cobd2=D:\Profile\AppData\coLinux\Ubuntu\userfs
root=/dev/cobd0
ro
initrd="C:\Program Files\coLinux\initrd.gz"
mem=256
cocon=100x30
eth0=ndis-bridge,"ローカル エリア接続"
eth1=slirp,,tcp:2222:22
ttys0=COM1,"BAUD=115200 PARITY=n DATA=8 STOP=1 dtr=on rts=on"
```

# 初期設定  {#t4a3fdcd}

## システムの更新  {#peb4e83f}


```
# sudo apt-get update
# sudo apt-get upgrade
# sudo apt-get dist-upgrade
# sudo apt-get clean
# sudo apt-get autoclean
```

## SSH のインストール  {#we213137}


```
# sudo apt-get install openssh-server
# sudo perl -i -pe 's/(PermitRootLogin )yes/\1no/' /etc/ssh/sshd_config
# sudo /etc/init.d/ssh restart
```

## ntp のインストール  {#n460f8f8}


```
# sudo apt-get install ntp
```

### Windows の NTP サーバを有効にする  {#c8ac6324}
以下のサイトを参考にして Windows の NTP サーバ機能を有効にする。

[W32Timeで時刻合わせ: べつになんでもないこと](http://puppet.asablo.jp/blog/2008/12/16/4012034 "W32Timeで時刻合わせ: べつになんでもないこと")

### coLinux の NTP サーバの設定  {#ia1496f1}


```
# sudo perl -i -pe 's/^(server ntp.ubuntu.com)$/#\1/' /etc/ntp.conf
# sudo perl -i -pe 's/^(restrict.*)$/#\1/g' /etc/ntp.conf
# sudo sh -c 'echo >> /etc/ntp.conf'
# sudo sh -c 'echo restrict default ignore >> /etc/ntp.conf'
# sudo sh -c 'echo restrict 127.0.0.1 >> /etc/ntp.conf'
# sudo sh -c 'echo restrict -4 10.0.2.2 >> /etc/ntp.conf'
# sudo sh -c 'echo server -4 10.0.2.2 iburst >> /etc/ntp.conf'
# sudo /etc/init.d/ntp restart
```

## 普段使いそうなパッケージのインストール  {#s9358fd3}


```
# sudo apt-get install dnsutils man manpages-ja manpages-ja-dev zsh screen vim lv wget nkf subversion git-core build-essential
```

## Japanese Team 追加パッケージ情報の追加  {#v78294c7}


```
# wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add -
# wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add -
# sudo wget https://www.ubuntulinux.jp/sources.list.d/jaunty.list -O /etc/apt/sources.list.d/ubuntu-ja.list
# sudo apt-get update
# sudo apt-get clean
# sudo apt-get autoclean
```

## シャットダウン  {#efa9d225}


```
# halt
```

# サービス登録  {#y1b43a42}

サービス起動用の設定ファイルの作成。


```
service.conf

```


```
kernel="C:\Program Files\coLinux\vmlinux"
cobd0=D:\Profile\AppData\coLinux\Ubuntu\rootfs
cobd1=D:\Profile\AppData\coLinux\Ubuntu\swapfs
cobd2=D:\Profile\AppData\coLinux\Ubuntu\userfs
root=/dev/cobd0
ro
initrd="C:\Program Files\coLinux\initrd.gz"
mem=256
cocon=100x30
eth0=ndis-bridge,"ローカル エリア接続"
eth1=slirp,,tcp:2222:22
ttys0=COM1,"BAUD=115200 PARITY=n DATA=8 STOP=1 dtr=on rts=on"
```

コマンドプロンプトを起動する。
Vista 以降では管理者権限で起動する。


```
"C:\Program Files\coLinux\colinux-daemon.exe" @D:\Profile\AppData\coLinux\Ubuntu\service.conf --install-service "coLinux - Ubuntu" -p D:\Profile\AppData\coLinux\Ubuntu\pid
net start "coLinux - Ubuntu"
```

# サービス削除  {#a8e85882}


```
net stop "coLinux - Ubuntu"
"C:\Program Files\coLinux\colinux-daemon.exe" --remove-service "coLinux - Ubuntu"
```

# カーネル再構築  {#i4ef5fee}

[カーネル再構築](/archive/wiki/Linux/coLinux/Ubuntu_9.04/Build_Kernel/ "カーネル再構築")

# その他ディストリ向けのインストーラー(initrd)の作成  {#kc1bb980}

[busybox](/archive/wiki/Linux/BusyBox/ "busybox")

# Tips  {#v164a815}

## ネットワークインターフェースの修正  {#xca34e07}
/etc/udev/rules.d/70-persistent-net.rulesを編集する。
