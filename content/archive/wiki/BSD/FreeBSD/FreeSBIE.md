+++
title = "[PukiWiki:wiki] BSD/FreeBSD/FreeSBIE"
date = "2008-12-10T09:33:19Z"
+++


# 7.0R で FreeSBIE を構築  {#g3b3be9a}
FreeBSD 7.0-RELEASE で FreeSBIE を構築してみます。

目標として **sysinstall を使わないインストール** を目指します。

# インストール  {#x5db8ea4}
まずは ports からインストールします。


```
# portinstall sysutils/freesbie

```

作業ディレクトリは **/usr/local/share/freesbie/** で、以降はここで作業します。


```
# cd /usr/local/share/freesbie/

```

# 設定ファイルの編集  {#x0428320}
設定ファイルが読み込まれる順序は **conf/freesbie.defaults.conf** -> **conf/freesbie.conf** なので、デフォルトから設定を変えたい項目のみ **conf/freesbie.conf** に記述してください。


```
# vi conf/freesbie.conf

KERNELCONF=/usr/local/share/freesbie/conf/i386/FREESBIE
MAKE_CONF=/usr/local/share/freesbie/conf/make.conf
SRC_CONF=/usr/local/share/freesbie/conf/src.conf
EXTRA="adduser customroot etcmfs rootmfs varmfs"

```

# make.conf の編集  {#u0f8171e}
デフォルトの make.conf を書き換えます。


```
# printf "CPUTYPE?=i686\n" > conf/make.conf

```

# src.conf の編集  {#j5427df2}
通常でしたら src.conf はないと思いますので、新規に作成します。


```
# printf "WITHOUT_GAMES=\nWITHOUT_PROFILE=\n" > conf/src.conf

```

# カーネルの設定  {#xd9bc9a0}
FreeSBIE から起動する為に **GEOM_LABEL,GEOM_UZIP,UNIONFS** を GENELIC カーネルに書き足します。


```
# cp /usr/src/sys/i386/conf/GENERIC conf/i386/FREESBIE
# perl -pe "s/ident\t\tGENERIC/ident\t\tFREESBIE/" conf/i386/FREESBIE
# printf "\noptions \tGEOM_LABEL\t\t# Provides labelization\n" >> conf/i386/FREESBIE
# printf "options \tGEOM_UZIP\t\t# Read-only compressed disks\n" >> conf/i386/FREESBIE
# printf "options \tUNIONFS\t\t\t# Union filesystem\n" >> conf/i386/FREESBIE

```

# customroot プラグインの設定  {#b95e19bf}
**extra/customroot** が FreeSBIE 起動時のルート ( **/'' ) なので、直下に **etc'' ディレクトリ、設定ファイル等を配置します。

以下の例では **/etc/rc.conf** を作成しています。


```
# mkdir extra/customroot/etc
# printf "hostname=\42freesbie.localdomain\42\n" > extra/customroot/etc/rc.conf
# printf "ifconfig_DEFAULT=\42DHCP\42\n\n" >> extra/customroot/etc/rc.conf
# printf "dumpdev=\42NO\42\n\n" >> extra/customroot/etc/rc.conf
# printf "sshd_enable=\42YES\42\n" >> extra/customroot/etc/rc.conf

```

# ISO イメージの作成  {#t98df43d}
初回ビルド時には時間がかかるので、遠隔操作の場合は screen などを立ち上げてから、作業を開始しておくと良いです。


```
# make iso

```

# ISO イメージの再作成  {#zb571616}
カーネルだけ変更したい場合など、一部の処理のみやり直したい場合は **/usr/obj/usr/local/share/freesbie/** 以下の **.done_*** ファイルを削除する事によって、該当処理をやり直す事ができます。

以下の例では extra プラグインのやり直しを行います。


```
# rm /usr/obj/usr/local/share/freesbie/.done_extra
# make iso

```

# HDD の初期化  {#y1ffab4c}
まずは既存のHDDを初期化します。

全てのデータが削除されるので、該当 HDD の内容はバックアップを忘れないで下さい。


```
# dd if=/dev/zero of=/dev/ad0 bs=512 count=32

```

# スライスの作成  {#ye151b05}
下記のようなファイルを作成して、 fdisk に読ませます。

対話的な fdisk は少し閉口してしまうものがあるので、一度 sysinstall を実行して、その値をメモしておいた方が良いです。

下記の例は VMware 仮想 HDD 8G 割り当ての環境でのスライスです。

# 実際はこの程度の HDD 容量の場合はひとつだけスライスを切れば大丈夫です


```
# vi vmware.conf

g     c17753     h15     s63

p     1          165     63           4193847
p     2          165     4193910      4193910
p     3          165     8387820      4193910
p     4          165     12581730     4194855

a     1

```

上記のファイルを fdisk に読ませてスライスを作成します。


```
# fdisk -f vmware.conf -iv ad0

******* Working on device /dev/ad0 *******
fdisk: invalid fdisk partition table found
fdisk: WARNING line 5: number of cylinders (17753) may be out-of-range
    (must be within 1-1024 for normal BIOS operation, unless the entire disk
    is dedicated to FreeBSD)
parameters extracted from in-core disklabel are:
cylinders=17753 heads=15 sectors/track=63 (945 blks/cyl)

Figures below won't work with BIOS for partitions not in cyl 1
parameters to be used for BIOS calculations are:
cylinders=17753 heads=15 sectors/track=63 (945 blks/cyl)

Information from DOS bootblock is:
1: sysid 165 (0xa5),(FreeBSD/NetBSD/386BSD)
    start 63, size 4193847 (2047 Meg), flag 80 (active)
        beg: cyl 0/ head 1/ sector 1;
        end: cyl 341/ head 14/ sector 63
2: sysid 165 (0xa5),(FreeBSD/NetBSD/386BSD)
    start 4193910, size 4193910 (2047 Meg), flag 0
        beg: cyl 342/ head 0/ sector 1;
        end: cyl 683/ head 14/ sector 63
3: sysid 165 (0xa5),(FreeBSD/NetBSD/386BSD)
    start 8387820, size 4193910 (2047 Meg), flag 0
        beg: cyl 684/ head 0/ sector 1;
        end: cyl 1/ head 14/ sector 63
4: sysid 165 (0xa5),(FreeBSD/NetBSD/386BSD)
    start 12581730, size 4194855 (2048 Meg), flag 0
        beg: cyl 2/ head 0/ sector 1;
        end: cyl 344/ head 14/ sector 63
fdisk: Geom not found: "ad0"

```

# ディスクラベルの割り当てを決める  {#g46a7e22}
ディスクラベルを書き込む前に、まずは全体の割り当てを決めます。

注意事項として、最初のスライスの一番初めのディスクラベルにルートファイルシステムを配置してください。

## ad0s1  {#j6750268}
| Label  | Mount | Size |
| ad0s1a | /     | 256M |
| ad0s1b | swap  |   1G |
| ad0s1d | /var  | 256M |
| ad0s1e | /tmp  | 256M |
| ad0s1f | /usr  | 256M |


```
# vi label_ad0s1

# /dev/ad0s1:

8 partitions:
#        size   offset    fstype   [fsize bsize bps/cpg]
  a:   256M       16    4.2BSD
  b:     1G        *      swap
  c:      *        *    unused
  d:   256M        *    4.2BSD
  e:   256M        *    4.2BSD
  f:      *        *    4.2BSD

```

## ad0s2  {#y96b0380}
| Label  | Mount       | Size |
| ad0s2d | /usr/src    |   1G |
| ad0s2e | /usr/ports  |   1G |


```
# vi label_ad0s2

# /dev/ad0s2:

8 partitions:
#        size   offset    fstype   [fsize bsize bps/cpg]
  c:      *        *    unused
  d:     1G        *    4.2BSD
  e:      *        *    4.2BSD

```

## ad0s3  {#sc8dd408}
| Label  | Mount       | Size |
| ad0s3d | /usr/obj    |   1G |
| ad0s3e | /usr/local  |   1G |


```
# vi label_ad0s3

# /dev/ad0s3:

8 partitions:
#        size   offset    fstype   [fsize bsize bps/cpg]
  c:      *        *    unused
  d:     1G        *    4.2BSD
  e:      *        *    4.2BSD

```

## ad0s4  {#xd5dd046}
| Label  | Mount     | Size |
| ad0s4d | /usr/jail |   1G |
| ad0s4e | /home     |   1G |


```
# vi label_ad0s4

# /dev/ad0s4:

8 partitions:
#        size   offset    fstype   [fsize bsize bps/cpg]
  c:      *        *    unused
  d:     1G        *    4.2BSD
  e:      *        *    4.2BSD

```

# ディスクラベルの書き込み  {#pdc51b5a}
上記で作成したファイルを bsdlabel に読ませればディスクラベルが書き込まれます。


```
# bsdlabel -R ad0s1 label_ad0s1
# bsdlabel -R ad0s2 label_ad0s2
# bsdlabel -R ad0s3 label_ad0s3
# bsdlabel -R ad0s4 label_ad0s4

```

# フォーマット  {#yc10aee2}
ルートファイルシステムと swap 以外は全て soft-update を有効にしてフォーマットします。


```
# newfs ad0s1a
# newfs -U ad0s1d
# newfs -U ad0s1e
# newfs -U ad0s1f
# newfs -U ad0s2d
# newfs -U ad0s2e
# newfs -U ad0s3d
# newfs -U ad0s3e
# newfs -U ad0s4d
# newfs -U ad0s4e

```

# マウント  {#cc4822b0}
正常にフォーマットされていたら各ラベルをマウントします。


```
# swapon /dev/ad0s1b
# mount /dev/ad0s1a /mnt
# mkdir /mnt/var /mnt/tmp /mnt/usr
# mount /dev/ad0s1d /mnt/var
# mount /dev/ad0s1e /mnt/tmp
# mount /dev/ad0s1f /mnt/usr
# mkdir /mnt/usr/src /mnt/usr/ports /mnt/usr/obj
# mkdir /mnt/usr/local /mnt/usr/jail /mnt/home
# mount /dev/ad0s2d /mnt/usr/src
# mount /dev/ad0s2e /mnt/usr/ports
# mount /dev/ad0s3d /mnt/usr/obj
# mount /dev/ad0s3e /mnt/usr/local
# mount /dev/ad0s4d /mnt/usr/jail
# mount /dev/ad0s4e /mnt/home

```

# ファイルのコピー  {#x42484db}
FreeSBIE の内容をコピーします。


```
# cp -fp /* /mnt/
# cp -fpR /bin /mnt/
# cp -fpR /boot /mnt/
# cp -fpR /dev /mnt/
# cp -fpR /dist /mnt/
# cp -fpR /etc /mnt/
# cp -fpR /lib /mnt/
# cp -fpR /libexec /mnt/
# cp -fpR /media /mnt/
# cp -fpR /proc /mnt/
# cp -fpR /rescue /mnt/
# cp -fpR /root /mnt/
# cp -fpR /sbin /mnt/
# cp -fpR /usr /mnt/
# cp -fpR /var /mnt/

```

# /etc/fstab の編集  {#x7b2f3f8}
HDD から起動できるように /etc/fstab を編集します。


```
# vi /mnt/etc/fstab

# Device		Mountpoint	FStype	Options		Dump	Pass#
/dev/ad0s1b		none		swap	sw		0	0
/dev/ad0s1a		/		ufs	rw		1	1
/dev/ad0s1d		/var		ufs	rw		2	2
/dev/ad0s1e		/tmp		ufs	rw,nosuid	2	2
/dev/ad0s1f		/usr		ufs	rw		2	2
/dev/ad0s2d		/usr/src	ufs	rw		2	2
/dev/ad0s2e		/usr/ports	ufs	rw		2	2
/dev/ad0s3d		/usr/obj	ufs	rw		2	2
/dev/ad0s3e		/usr/local	ufs	rw		2	2
/dev/ad0s4d		/usr/jail	ufs	rw		2	2
/dev/ad0s4e		/home		ufs	rw		2	2
/dev/acd0		/cdrom		cd9660	ro,noauto	0	0

```

# リンク  {#vd6382e6}
- [FreeSBIE - Free System Burned In Economy](http://www.freesbie.org/ "FreeSBIE - Free System Burned In Economy")
- [fdisk\(8\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=fdisk&dir=jpman-7.0.2%2Fman&sect=0 "fdisk\(8\)")
- [bsdlabel\(8\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=bsdlabel&dir=jpman-7.0.2%2Fman&sect=0 "bsdlabel\(8\)")
- [摂南大学 SU-FreeSBIE 2.0 日本語版](http://www.eng.setsunan.ac.jp/sst_lab/2006/su-freesbie.html#usb-inst "摂南大学 SU-FreeSBIE 2.0 日本語版")
- [FreeBSD from Scratch :memo](http://www.es.dis.titech.ac.jp/~k-shi/item/3146 "FreeBSD from Scratch :memo")
