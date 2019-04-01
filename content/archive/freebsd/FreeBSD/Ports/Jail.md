+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Jail"
date = "2009-04-05T06:32:20Z"
+++


# Jail について  {#af00bd61}
皆さん chroot ってご存知でしょうか。 Linux を使った事がある方、もしくは BIND を運営している方などは苦い思い出などあるかと思います。;-)
FreeBSD の jail(8) は chroot(8) を更に強化したようなもので、 jail(8) 内からはホストのプロセスなどは一切見えません。
機能的に言えば、最近の仮想化技術などをイメージすると分かりやすいと思います。

# ezjail について  {#ee8f54a6}
ezjail は実は単なるシェルスクリプトで、その本質は mount_nullfs(8) にあります。
jail(8) 自体は FreeBSD 独自の実装ですが、例えば full jail を一から構築すると、システム一台の容量まるまる占有する事になります。
日本語に訳すと jail(8) は監獄という意味ですが、その言葉の意味通り、必要なだけ監獄がある事に越した事はありませんが、増やした分だけ占有されるのは些か問題があります。

そこで ezjail の出番です。
最初に mount_nullfs(8) について少し話しましたが、これはイメージ的にはシンボリックリンクやハードリンクと言えば分かりやすいと思います。
突っ込んだ事を言うと mount_nullfs(8) はシンボリックリンクやハードリンクとはまったく違う実装方法なのですが、システムの深いところと関わっているので、私もはっきりとこういう実装方法だよ、とは言えません。
なので、今回は mount_nullfs(8) の実装方法について触れませんが、いつか紹介したいと思います。

# パッチの適用  {#p0ab7cf0}
ezjail 3.0 のパッチを通りすがりさんが作成して下さいました。
この場を借りてお礼申し上げます。

- [ezjail 3.0 - ezjail-admin パッチ](http://cocelo.s201.xrea.com/patch/ezjail-3.0-ezjail-admin.patch "ezjail 3.0 - ezjail-admin パッチ")

ezjail では make.conf や src.conf ( FreeBSD 7.0-RELEASE から導入されました ) がデフォルトの位置のものしか使えませんが、以下のパッチを適用すれば、任意の make.conf や src.conf が指定できます。

上記のファイルを任意のディレクトリにダウンロードし、 **${PORTSDIR}/sysutils/ezjail/files/patch-ezjail-admin** として配置してください。


```
% sudo fetch http://cocelo.s201.xrea.com/patch/ezjail-3.0-ezjail-admin.patch
% sudo mkdir /usr/ports/sysutils/ezjail/files
% sudo mv ezjail-3.0-ezjail-admin.patch /usr/ports/sysutils/ezjail/files/patch-ezjail-admin

```

# ezjail の導入  {#ydb2355c}
ezjail の導入はとても早く終わります。
ものの数分ないし、数十秒で終わります。


```
% sudo portinstall sysutils/ezjail

```

# 設定ファイルのコピー  {#nfccb8bf}
設定ファイルをコピーします。


```
% sudo cp /usr/local/etc/ezjail.conf.sample /usr/local/etc/ezjail.conf

```

# ezjail.conf の編集  {#w7b9569a}
以下は設定箇所の簡単な説明です。

- ezjail のルートディレクトリ

```
# Location of jail root directories
#
# Note: If you have spread your jails to multiple locations, use softlinks
# to collect them in this directory
ezjail_jaildir=/usr/jails

```

- ディレクトリのテンプレート

```
# Location of the tiny skeleton jail template
ezjail_jailtemplate=${ezjail_jaildir}/newjail

```

- installworld のターゲットディレクトリ

```
# Location of the huge base jail
ezjail_jailbase=${ezjail_jaildir}/basejail

```

- FreeBSD のソースツリー

```
# Location of your copy of FreeBSD's source tree
ezjail_sourcetree=/usr/src

```

- ( パッチを適用している場合は新規に書き足す ) make.conf の位置

```
# Location of make.conf
ezjail_makeconf=/etc/make.conf.jails

```

- ( パッチを適用している場合で、FreeBSD 7.0-RELEASE 以上の場合は新規に書き足す ) src.conf の位置

```
# Location of src.conf
ezjail_srcconf=/etc/src.conf.jails

```

# make.conf 及び src.conf の作成  {#h0a68bbe}
jail 環境に必要のないものを指定した make.conf を作成します。
以下は6系リリースまでのものです。


```
% sudoedit /etc/make.conf.jails

NO_ACPI=YES
NO_ATM=YES
NO_AUTHPF=YES
NO_BLUETOOTH=YES
NO_BOOT=YES
NO_DICT=YES
NO_FORTRAN=YES
NO_GAMES=YES
NO_GDB=YES
NO_GPIB=YES
NO_I4B=YES
NO_INET6=YES
NO_INFO=YES
NO_IPFILTER=YES
NO_KERBEROS=YES
NO_LPR=YES
NO_MAN=YES
NO_MODULES=YES
NO_NETCAT=YES
NO_NIS=YES
NO_PF=YES
NO_PROFILE=YES
NO_RCMDS=YES
NO_SHAREDOCS=YES
NO_USB=YES
NO_BIND=YES
NO_BIND_DNSSEC=YES
NO_BIND_ETC=YES
NO_BIND_LIBS_LWRES=YES
NO_BIND_MTREE=YES
NO_BIND_NAMED=YES
NO_BIND_UTILS=YES

```

以下は7.0-RELEASE以降のものです。


```
% sudoedit /etc/src.conf.jails

WITHOUT_ACPI=yes
WITHOUT_ATM=yes
WITHOUT_AUDIT=yes
WITHOUT_AUTHPF=yes
WITHOUT_BIND=yes
WITHOUT_BLUETOOTH=yes
WITHOUT_BOOT=yes
WITHOUT_CALENDAR=yes
WITHOUT_DICT=yes
WITHOUT_EXAMPLES=yes
WITHOUT_FORTH=yes
WITHOUT_FORTRAN=yes
WITHOUT_GAMES=yes
WITHOUT_GCOV=yes
WITHOUT_GDB=yes
WITHOUT_GPIB=yes
WITHOUT_GROFF=yes
WITHOUT_GSSAPI=yes
WITHOUT_HTML=yes
WITHOUT_I4B=yes
WITHOUT_INET6=yes
WITHOUT_IPFILTER=yes
WITHOUT_IPX=yes
WITHOUT_KERBEROS=yes
WITHOUT_LPR=yes
WITHOUT_MAN=yes
WITHOUT_NCP=yes
WITHOUT_NETCAT=yes
WITHOUT_NIS=yes
WITHOUT_OBJC=yes
WITHOUT_PF=yes
WITHOUT_PROFILE=yes
WITHOUT_RCMDS=yes
WITHOUT_RCS=yes
WITHOUT_RESCUE=yes
WITHOUT_SENDMAIL=yes
WITHOUT_SETUID_LOGIN=yes
WITHOUT_SHAREDOCS=yes
WITHOUT_SYSCONS=yes
WITHOUT_USB=yes
WITHOUT_ZFS=yes

```

# world の実行  {#f96e6b51}
ezjail-admin update を実行します。
暫く時間がかかるので注意しましょう。


```
% sudo ezjail-admin update

```

# ディレクトリ構成について  {#ucbb8718}
上記項目の ezjail.conf でいくつか設定しましたが、各ディレクトリの役割について解説します。

## ezjail_jaildir  {#t2b6c8d0}
全て ezjail はこのルートディレクトリ以下に jail(8) を作成します。
また、 mount_nullfs(8) されるディレクトリも、このルートディレクトリ以下になります。
デフォルトは **/usr/jails** です。

## ezjail_jailtemplate  {#v3f92a8d}
将来的に編集するかもしれないファイルが格納されています。
例えば /etc/make.conf や /etc/rc.conf など。
デフォルトは **${ezjail_jaildir}/newjail** です。

## ezjail_jailbase  {#a476fdf7}
新しく jail(8) を作った際に必要な shell や実行ファイル、ライブラリなど、 jail(8) で編集する必要ないファイルが格納されており、ここのディレクトリから mount_nullfs(8) されます。
ファイルが作られる ( 更新される ) タイミングは ezjail-admin update ( buildworld installworld ) 実行時です。
デフォルトは **${ezjail_jaildir}/basejail** です。

## Flavours ( Option )  {#r28dabd0}
このディレクトリはオプションで使用する事が出来ます。
例えば localtime などはどの jail(8) でも共通なので /etc/localtime を予めコピーしておくなどです。
サンプルファイルが **/usr/local/share/examples/ezjail/default** に格納されています。
また、デフォルトは **${ezjail_jaildir}/flavours** です。

# jail 環境で不要なファイルを削除する  {#vd3c47a2}
jail で不要なファイルを削除する為に [Files to Remove from Jails](http://memberwebs.com/stef/freebsd/jails/docs/jail_remove.html "Files to Remove from Jails") から 6.x 用のファイルをダウンロードします。


```
% cd ~
% fetch http://memberwebs.com/stef/freebsd/jails/docs/6.x/jail-remove.txt
% sudo sed "s#^/#/usr/jails/newjail/#" < jail-remove.txt | xargs rm -rfv
% sudo sed "s#^/#/usr/jails/basejail/#" < jail-remove.txt | xargs rm -rfv

```

# 一部コマンドを /usr/bin/true にリンクする  {#b41a075e}
一部のコマンドでエラーが出るので 一部のコマンドを /usr/sbin/true にシンボリックリンクを貼ります。


```
% cd /usr/jails/basejail
% sudo ln usr/bin/true sbin/init

```

# Flavours について  {#s4ac4704}
まずはサンプルの設定ファイルと、その他必要なファイルをコピーします。

なお、後述の jail の作成の際の **-f default** を変えれば **/usr/jails/flavours/** の default 以外のディレクトリに変更出来ます。
例えば Web サーバ用の設定 ( -f http ) と SMTP サーバ ( -f smtp ) の設定を分けたりする事も出来ます。

/etc/localtime

```
% sudo mkdir -p /usr/jails/flavours/default/etc
% sudo cp -p /usr/share/zoneinfo/Asia/Tokyo /usr/jails/flavours/default/etc/localtime

```

/etc/wall_cmos_clock

```
% sudo touch /usr/jails/flavours/default/etc/wall_cmos_clock

```

/etc/fstab

```
% sudo touch /usr/jails/flavours/default/etc/fstab

```

/etc/resolv.conf

```
% sudo sh -c 'grep nameserver /etc/resolv.conf > /usr/jails/flavours/default/etc/resolv.conf'

```

/etc/make.conf

```
% sudoedit /usr/jails/flavours/default/etc/make.conf

WRKDIRPREFIX=           /var/ports
DISTDIR=                /var/ports/distfiles
PACKAGES=               /var/ports/packages

CPUTYPE?=athlon64

WITHOUT_X11=            yes
WITHOUT_IPV6=           yes

```

/etc/rc.conf

```
% sudoedit /usr/jails/flavours/default/etc/rc.conf

# Pretuned by German Engineers

# No network interfaces in jails
network_interfaces=""

# Prevent rpc
rpcbind_enable="NO"

# Prevent loads of jails doing their cron jobs at the same time
cron_flags="$cron_flags -J 15"

# Prevent syslog to open sockets
syslogd_flags="-ss"

# Prevent sendmail to try to connect to localhost
sendmail_enable="NO"
sendmail_submit_enable="NO"
sendmail_outbound_enable="NO"
sendmail_msp_queue_enable="NO"

```

/etc/periodic.conf

```
% sudoedit /usr/jails/flavours/default/etc/periodic.conf

daily_output="/var/log/daily.log"
weekly_output="/var/log/weekly.log"
monthly_output="/var/log/monthly.log"
daily_status_security_output="/var/log/daily_status_security.log"
daily_status_disks_enable="NO"
daily_status_network_enable="NO"
daily_status_security_noamd="YES"
daily_status_security_chkmounts_enable="NO"
daily_status_security_ipfdenied_enable="NO"
daily_status_security_ipfwdenied_enable="NO"
daily_status_security_ipfwlimit_enable="NO"
daily_status_security_ip6fwdenied_enable="NO"
daily_status_security_ip6fwlimit_enable="NO"
weekly_whatis_enable="NO"

```

/etc/crontab

```
% sudoedit /usr/jails/flavours/default/etc/crontab

SHELL=/bin/sh
PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin
HOME=/var/log

0       *       *       *       *       root    newsyslog
1       3       *       *       *       root    periodic daily
15      4       *       *       6       root    periodic weekly
30      5       1       *       *       root    periodic monthly

```

/etc/syslog.conf

```
% sudo cp /etc/syslog.conf /usr/jails/flavours/default/etc/syslog.conf

```

/var/log/all.log

```
% sudo mkdir -p /usr/jails/flavours/default/var/log
% sudo touch /usr/jails/flavours/default/var/log/all.log
% sudo chmod 600 /usr/jails/flavours/default/var/log/all.log

```

/etc/newsyslog.conf

```
% sudo cp /etc/newsyslog.conf /usr/jails/flavours/default/etc/newsyslog.conf

```

# jail の作成  {#w2a824f1}
jail を作成します。

hoge.example.com と IP アドレスは各自の環境に合わせてください。


```
% sudo ezjail-admin create -f default jailname 192.168.0.2

```

ifconfig で alias を振ります。


```
% sudo ifconfig fxp0 inet 192.168.0.2 netmask 255.255.255.255 alias

```

# 自動起動の設定  {#h6c4a907}
自動起動の設定を行います。


```
% sudoedit /etc/rc.conf

ezjail_enable="YES"
jail_set_hostname_allow="NO"
jail_socket_unixiproute_only="YES"
jail_sysvipc_allow="NO"
ifconfig_fxp0_alias0="inet 192.168.0.2 netmask 255.255.255.255"

```

# ezjail の起動  {#bedb4c16}
ezjail を起動します。


```
% sudo /usr/local/etc/rc.d/ezjail.sh start jailname

```

# 動作確認  {#u5f4bf74}
ezjail-admin list で作成したホストが立ち上がっているかどうか確認します。


```
% ezjail-admin list

```

# ports を使う  {#z1210a96}
ports が使えないと何かと不便なので ports を使えるようにします。


```
% sudo ezjail-admin update -P

```

portsnap を使って ports を取得してきてくれます。
更新の場合も上記コマンドを打てば更新してくれます。
また、同時に INDEX.db の更新をしておけば後々楽かと思います。


```
% sudo env PORTSDIR=/usr/jails/basejail/usr/ports portsdb -u

```

ホストと共有しても良い場合はfstabに以下を書き足します。


```
% sudoedit /etc/fstab.jailname

/usr/ports /usr/jails/jailname/basejail/usr/ports nullfs ro 0 0
/usr/src /usr/jails/jailname/basejail/usr/src nullfs ro 0 0

```

NFS を使用する場合は以下のようになります。


```
% sudoedit /etc/fstab.jailname

192.168.1.100:/usr/ports /usr/jails/jailname/basejail/usr/ports nfs ro 0 0
192.168.1.100:/usr/src /usr/jails/jailname/basejail/usr/src nfs ro 0 0

```

jail にインストールされている ports で更新されたものを調べるには下記のようにします。


```
% env PKG_DBDIR=/usr/jails/JAILNAME/var/db/pkg pkg_version -l '<'

```

## jailaudit  {#y8b21c3f}
ports を導入した場合はホスト環境に jailaudit を導入すると良いです。
これは jail 用の portaudit で、個々の jail に portaudit を導入しないで、ホスト環境から一元管理する事が出来ます。


```
% sudo portinstall ports-mgmt/jailaudit

```

# jail にログイン  {#bcbba904}
jail 環境にログインします。


```
% sudo ezjail-admin console jailname

```

# jail のパスワードの設定  {#rab8963f}
jail 環境にログインしたらパスワードの設定を行います。


```
# passwd

```

# jail の削除の仕方  {#vb79783a}
jail を削除する時は下記のようにコマンドを入力すれば削除出来ます。


```
% sudo /usr/local/etc/rc.d/ezjail.sh stop jailname
% sudo ezjail-admin delete -w jailname

```

# 付録： jail 構築の際に使えそうな Ports  {#y76c5011}
- [ports-mgmt/jailaudit](http://www.freebsd.org/cgi/cvsweb.cgi/ports/ports-mgmt/jailaudit/ "ports-mgmt/jailaudit")
    -  jail 環境下にインストールされている Ports の脆弱性をホスト環境からチェック出来る
- [ports-mgmt/pkg_replace](http://www.freebsd.org/cgi/cvsweb.cgi/ports/ports-mgmt/pkg_replace/ "ports-mgmt/pkg_replace")
    -  portupgrade 互換。依存関係がない
- [ports-mgmt/portconf](http://www.freebsd.org/cgi/cvsweb.cgi/ports/ports-mgmt/portconf/ "ports-mgmt/portconf")
    -  portupgrade portmaster 'make install' 時に MAKE ARGS を指定出来る。上記の pkg_replace と合わせて使用すれば jail 内の Ports 管理が楽になるかも

# リンク  {#vb521de3}
[ezjail - Jail administration framework](http://erdgeist.org/arts/software/ezjail/ "ezjail - Jail administration framework")
[jailaudit](http://anonsvn.h3q.com/projects/jailaudit/ "jailaudit")
[pkg_replace](http://portutil.sourceforge.jp/ "pkg_replace")
[FreeBSD Jail Software and Docs](http://memberwebs.com/stef/freebsd/jails/ "FreeBSD Jail Software and Docs")
[ezjail - otsune FreeStyleWiki](http://www.otsune.com/fswiki/ezjail.html "ezjail - otsune FreeStyleWiki")
[otsune's FreeBSD memo :: jailの作り方](http://www.otsune.com/bsd/jail/fulljail.html "otsune's FreeBSD memo :: jailの作り方")
[コンパクトなJail環境の構築](http://hk-tech.homeip.net/pcserver/jail.html "コンパクトなJail環境の構築")
