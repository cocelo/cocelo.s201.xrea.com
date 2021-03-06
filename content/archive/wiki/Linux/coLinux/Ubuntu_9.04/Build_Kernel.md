+++
title = "[PukiWiki:wiki] Linux/coLinux/Ubuntu_9.04/Build_Kernel"
date = "2009-12-16T09:00:12Z"
+++


# カーネル再構築  {#q265d5ed}

# gcc のインストール  {#q526154b}


```
# sudo apt-get install gcc-4.3 g++-4.3 gcc-4.2 g++-4.2 gcc-4.1 g++-4.1
```

update-alternativesでgccのバージョンを変更する。


```
# sudo update-alternatives --config gcc
```

## 「gcc の alternatives がありません。」の対処  {#k137142b}

「gcc の alternatives がありません。」とか言われたら[debianでgccのバージョンを切り替える - kinneko@転職先募集中の日記](http://d.hatena.ne.jp/kinneko/20080828/p7 "debianでgccのバージョンを切り替える - kinneko@転職先募集中の日記")を参考に、gccのalternativesを作成する。


```
# sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.3 43 \
--slave /usr/bin/g++ g++ /usr/bin/g++-4.3 \
--slave /usr/bin/gcov gcov /usr/bin/gcov-4.3

# sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.2 42 \
--slave /usr/bin/g++ g++ /usr/bin/g++-4.2 \
--slave /usr/bin/gcov gcov /usr/bin/gcov-4.2

# sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.1 41 \
--slave /usr/bin/g++ g++ /usr/bin/g++-4.1 \
--slave /usr/bin/gcov gcov /usr/bin/gcov-4.1
```

# 再構築に必要なパッケージのインストール  {#nb33a038}

再構築に必要なパッケージのインストール。


```
# sudo apt-get install kernel-package libncurses-dev initramfs-tools
# sudo apt-get install unzip zip bison texinfo flex
```

# Linux Kernel 2.6.26.8  {#f5d84adf}

## ソースファイルの取得  {#i06bc0cf}
[こちらのサイト](http://www.henrynestler.com/colinux/autobuild/devel-20091215/ "こちらのサイト")から最新のソースファイルを取得する。(今回は colinux-0.8.0-20091215.src.tgz を取得)


```
# cd /usr/src
# sudo wget http://www.henrynestler.com/colinux/autobuild/devel-20091215/colinux-0.8.0-20091215.src.tgz
```

## ソースファイルの解凍とパッチ適用  {#q2b15b05}
coLinux のソースファイルを解凍、パッチ適用。


```
# sudo tar -xvzf colinux-0.8.0-20091215.src.tgz
# cd colinux-20091215
# sudo ./configure
# sudo make kernel
Making Kernel 2.6.26.8あたりで[Ctrl]+C
```

## カーネル設定  {#k97903fc}

デフォルトの設定ファイルのコピー。


```
# cd ../build/linux-2.6.26.8-source
# sudo cp ../../colinux-20091215/conf/linux-2.6.26.8-config .config
```

カーネル設定。


```
# sudo make oldconfig
# sudo make menuconfig
```


```
    Processor type and features --->
        Processor family --->
            (*) Opteron/Athlon64/Hammer/K8
    Networking --->
        Networking options --->
            < > The IPv6 protocol
    Device Drivers --->
        [*] Network device support --->
            <*> Universal TUN/TAP device driver support
            < > PPP (point-to-point protocol) support
    File systems --->
        <*> Ext4dev/ext4 extended fs support development (EXPERIMENTAL)
        < > Reiserfs support
        < > JFS filesystem support
        < > XFS filesystem support
        < > OCFS2 file system support
        DOS/FAT/NT Filesystems --->
            (932) Default codepage for FAT
            (euc-jp) Default iocharset for FAT
        [*] Network File Systems --->
            <M> SMB file system support (OBSOLETE, please use CIFS)
                [*] Use a default NLS
                    (cp932) Default Remote NLS Option
            < > NCP file system support (to mount NetWare volumes)
        -*- Native language support --->
            (euc-jp) Default NLS Option
            <*> Japanese charsets (Shift-JIS, EUC-JP)
            <*> NLS UTF-8
    Kernel hacking --->
        [ ] Kernel debugging
```

## コンパイルとパッケージの作成  {#afc010c0}

vmlinuxとinitrd.gz、モジュールファイルの作成。
CONCURRENCY_LEVELで並列コンパイル。
MAKEFLAGSでgcc-4.1とg++-4.1を使うように。


```
# sudo CONCURRENCY_LEVEL=2 MAKEFLAGS="CC=gcc-4.1 CXX=g++-4.1" make-kpkg --initrd --revision=20091215.1 kernel_image kernel_headers
```

vmlinuxをリネーム。


```
# sudo mv vmlinux vmlinux-2.6.26.8-co-0.8.0
```

## モジュールのインストール  {#od124181}
コンパイルしたモジュールをインストール。


```
# cd ..
# sudo dpkg -i linux-image-2.6.26.8-co-0.8.0_20091215.1_i386.deb
```

## モジュールパッケージの作成  {#d8080d29}
再インストールや他のディストリ向けに vmlinux-modules.tar.gz を作成する。


```
# sudo ar -x linux-image-2.6.26.8-co-0.8.0_20091215.1_i386.deb
# sudo tar -xvzf data.gz
# sudo tar -cvzf vmlinux-modules-2.6.26.8-co-0.8.0.tar.gz lib
```

## ファイルのコピー  {#q6af612d}

以下の三つのファイルをホスト側にコピーする。

- /boot/initrd.img-2.6.26.8-co-0.8.0
- /usr/src/linux-2.6.26.8/vmlinux-2.6.26.8-co-0.8.0
- /usr/src/vmlinux-modules-2.6.26.8-co-0.8.0.tar.gz

あとは以下のようにservice.confを書き換えれば作業完了。
Pathは各自要確認。


```
service.conf

```


```
kernel=D:\Profile\AppData\coLinux\vmlinux-2.6.26.8-co-0.8.0
cobd0=D:\Profile\AppData\coLinux\Ubuntu\rootfs
cobd1=D:\Profile\AppData\coLinux\Ubuntu\swapfs
cobd2=D:\Profile\AppData\coLinux\Ubuntu\userfs
root=/dev/cobd0
ro
initrd=D:\Profile\AppData\coLinux\initrd.img-2.6.26.8-co-0.8.0
mem=256
cocon=100x30
eth0=ndis-bridge,"ローカル エリア接続"
eth1=slirp,,tcp:2222:22
ttys0=COM1,"BAUD=115200 PARITY=n DATA=8 STOP=1 dtr=on rts=on"
```

# Linux Kernel 2.6.25.20  {#jab98d94}

coLinux devel 0.8.0 ( Linux Kernel 2.6.25.20 )

## ソースファイルの取得  {#ka6567d7}

[こちらのサイト](http://www.henrynestler.com/colinux/testing/devel-0.8.0/20091115-Snapshot/ "こちらのサイト")から最新のソースファイルを取得する。(今回は devel-colinux-20091115.tar.gz と linux-2.6.25.20-co-20091115-2.patch.gz を取得)
更に Ring サーバからカーネル 2.6.25.20 を取得する。


```
# cd /usr/src
# sudo wget http://www.henrynestler.com/colinux/testing/devel-0.8.0/20091115-Snapshot/devel-colinux-20091115.tar.gz
# sudo wget http://www.henrynestler.com/colinux/testing/devel-0.8.0/20091115-Snapshot/kernel-patches/linux-2.6.25.20-co-20091115-2.patch.gz
# sudo wget http://www.ring.gr.jp/pub/linux/kernel.org/kernel/v2.6/linux-2.6.25.20.tar.bz2
```

## ソースファイルの解凍とパッチ  {#naf7eb6a}

coLinux のソースファイルを解凍。


```
# sudo tar -xvzf devel-colinux-20091115.tar.gz
```

Linux カーネルのソースファイルを解凍、パッチ当て。


```
# sudo sh -c 'bzip2 -dc linux-2.6.25.20.tar.bz2 | tar xvf -'
# cd linux-2.6.25.20
# sudo sh -c 'gzip -cd ../linux-2.6.25.20-co-20091115-2.patch.gz | patch -p1'
```

uname に表示されるローカルカーネルバージョン。


```
# sudo sh -c 'echo -co-0.8.0 > localversion-cooperative'
```

## カーネル設定  {#g0480bc6}

デフォルトの設定ファイルのコピー。


```
# sudo cp ../devel-colinux-20091115/conf/linux-2.6.25.20-config .config
```

カーネル設定。


```
# sudo make menuconfig
```


```
    Processor type and features --->
        Processor family --->
            (*) Opteron/Athlon64/Hammer/K8
    Networking --->
        Networking options --->
            < > The IPv6 protocol
    Device Drivers --->
        [*] Network device support --->
            <*> Universal TUN/TAP device driver support
            < > PPP (point-to-point protocol) support
    File systems --->
        < > Reiserfs support
        < > JFS filesystem support
        < > XFS filesystem support
        DOS/FAT/NT Filesystems --->
            (932) Default codepage for FAT
            (euc-jp) Default iocharset for FAT
        [*] Network File Systems --->
            <M> SMB file system support (OBSOLETE, please use CIFS)
                [*] Use a default NLS
                    (cp932) Default Remote NLS Option
            < > NCP file system support (to mount NetWare volumes)
        -*- Native language support --->
            (euc-jp) Default NLS Option
            <*> Japanese charsets (Shift-JIS, EUC-JP)
    Kernel hacking --->
        [ ] Kernel debugging
```

## コンパイルとパッケージの作成  {#c2e0a25a}

vmlinuxとinitrd.gz、モジュールファイルの作成。
CONCURRENCY_LEVELで並列コンパイル。
MAKEFLAGSでgcc-4.1とg++-4.1を使うように。


```
# sudo CONCURRENCY_LEVEL=2 MAKEFLAGS="CC=gcc-4.1 CXX=g++-4.1" make-kpkg --initrd --revision=colinux.1 kernel_image kernel_headers
```

vmlinuxをリネーム。


```
# sudo mv vmlinux vmlinux-2.6.25.20-co-0.8.0
```

## モジュールのインストール  {#a4c68e9b}

デフォルトのモジュールをリネーム。


```
# sudo mv /lib/modules/2.6.25.20-co-0.8.0 /lib/modules/2.6.25.20-co-0.8.0.old
```

コンパイルしたモジュールをインストール。


```
# cd ..
# sudo dpkg -i linux-image-2.6.25.20-co-0.8.0_colinux.1_i386.deb
```

## モジュールパッケージの作成  {#md2d3a11}

再インストールや他のディストリ向けに vmlinux-modules.tar.gz を作成する。


```
# sudo ar -x linux-image-2.6.25.20-co-0.8.0_colinux.1_i386.deb
# sudo tar -xvzf data.gz
# sudo tar -cvzf vmlinux-modules-2.6.25.20-co-0.8.0.tar.gz lib
```

## ファイルのコピー  {#v7bd53b6}

以下の三つのファイルをホスト側にコピーする。

- /boot/initrd.img-2.6.25.20-co-0.8.0
- /usr/src/linux-2.6.25.20/vmlinux-2.6.25.20-co-0.8.0
- /usr/src/vmlinux-modules-2.6.25.20-co-0.8.0.tar.gz

あとは以下のようにservice.confを書き換えれば作業完了。
Pathは各自要確認。


```
service.conf

```


```
kernel=D:\Profile\AppData\coLinux\vmlinux-2.6.25.20-co-0.8.0
cobd0=D:\Profile\AppData\coLinux\Ubuntu\rootfs
cobd1=D:\Profile\AppData\coLinux\Ubuntu\swapfs
cobd2=D:\Profile\AppData\coLinux\Ubuntu\userfs
root=/dev/cobd0
ro
initrd=D:\Profile\AppData\coLinux\initrd.img-2.6.25.20-co-0.8.0
mem=256
cocon=100x30
eth0=ndis-bridge,"ローカル エリア接続"
eth1=slirp,,tcp:2222:22
ttys0=COM1,"BAUD=115200 PARITY=n DATA=8 STOP=1 dtr=on rts=on"
```

# 参考リンク  {#z9d6431e}
[coLinuxのメモ - カーネルのコンパイル](http://scratchpad.fc2web.com/colinux/kernel.html "coLinuxのメモ - カーネルのコンパイル")
[CoLinux TIPS - Silicon Linux Wiki](http://www.si-linux.co.jp/wiki/silinux/index.php?CoLinux%20TIPS#m2566b0d "CoLinux TIPS - Silicon Linux Wiki")
