+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Security/tripwire"
date = "2008-10-16T04:12:11Z"
+++


# Tripwire って？  {#x3cf7ec5}
ファイル改竄検知ツールです。例えば悪意あるユーザが既存のコマンドなどを置き換えようとした場合、それを検知してくれます。

# インストール  {#ubf79730}
portinstall でインストールします。


```
% sudo portinstall security/tripwire

LICENSE AGREEMENT for Tripwire(R) 2.3 Open Source

Please read the following license agreement.  You must accept the
agreement to continue installing Tripwire.

Press ENTER to view the License Agreement.

```

**[Enter]** を入力するとライセンスが表示される。


```
Please type "accept" to indicate your acceptance of this
license agreement. [do not accept]

```

ライセンスに同意出来る場合は **accept** を入力する。


```
Using configuration file ./install/install.cfg

Checking for programs specified in install configuration file....

/usr/sbin/sendmail exists.  Continuing installation.

/usr/bin/vi exists.  Continuing installation.


----------------------------------------------
Verifying existence of binaries...

./bin/siggen found
./bin/tripwire found
./bin/twprint found
./bin/twadmin found

This program will copy Tripwire files to the following directories:

        TWBIN: /usr/local/sbin
        TWMAN: /usr/local/man
     TWPOLICY: /usr/local/etc/tripwire
     TWREPORT: /var/db/tripwire/report
         TWDB: /var/db/tripwire
 TWSITEKEYDIR: /usr/local/etc/tripwire
TWLOCALKEYDIR: /usr/local/etc/tripwire

CLOBBER is false.

Continue with installation? [y/n]

```

インストールを続行しても良いなら ''y'' を入力する。


```
----------------------------------------------
Creating directories...

/usr/local/sbin: already exists
/usr/local/etc/tripwire: created
/var/db/tripwire/report: created
/var/db/tripwire: already exists
/usr/local/etc/tripwire: already exists
/usr/local/etc/tripwire: already exists
/usr/local/man: already exists
/usr/local/share/doc/tripwire: created

----------------------------------------------
Copying files...

/usr/local/share/doc/tripwire/COPYING: copied
/usr/local/share/doc/tripwire/TRADEMARK: copied
/usr/local/share/doc/tripwire/policyguide.txt: copied
/usr/local/etc/tripwire/twpol-FreeBSD.txt: copied

----------------------------------------------
The Tripwire site and local passphrases are used to
sign a variety of files, such as the configuration,
policy, and database files.

Passphrases should be at least 8 characters in length
and contain both letters and numbers.

See the Tripwire manual for more information.

----------------------------------------------
Creating key files...

(When selecting a passphrase, keep in mind that good passphrases typically
have upper and lower case letters, digits and punctuation marks, and are
at least 8 characters in length.)

```

次にサイトのパスフレーズを設定する。


```
Enter the site keyfile passphrase:
Verify the site keyfile passphrase:
Generating key (this may take several minutes)...Key generation complete.

(When selecting a passphrase, keep in mind that good passphrases typically
have upper and lower case letters, digits and punctuation marks, and are
at least 8 characters in length.)

```

次はローカルパスフレーズを設定する。


```
Enter the local keyfile passphrase:
Verify the local keyfile passphrase:
Generating key (this may take several minutes)...Key generation complete.

----------------------------------------------
Generating Tripwire configuration file...

----------------------------------------------
Creating signed configuration file...

```

次に上記で設定したサイトのパスフレーズを入力する。


```
Please enter your site passphrase:
Wrote configuration file: /usr/local/etc/tripwire/tw.cfg

A clear-text version of the Tripwire configuration file
/usr/local/etc/tripwire/twcfg.txt
has been preserved for your inspection.  It is recommended
that you delete this file manually after you have examined it.


----------------------------------------------
Customizing default policy file...

----------------------------------------------
Creating signed policy file...

```

もう一度サイトのパスフレーズを入力する。


```
Please enter your site passphrase:
Wrote policy file: /usr/local/etc/tripwire/tw.pol

A clear-text version of the Tripwire policy file
/usr/local/etc/tripwire/twpol.txt
has been preserved for your inspection.  This implements
a minimal policy, intended only to test essential
Tripwire functionality.  You should edit the policy file
to describe your system, and then use twadmin to generate
a new signed copy of the Tripwire policy.


----------------------------------------------
The installation succeeded.

Please refer to /usr/local/share/doc/tripwire/
for release information and to the printed user documentation
for further instructions on using Tripwire 2.3 Open Source.

Creating tripwire database

```

最後にローカルのパスフレーズを入力する。


```
Please enter your local passphrase:
Parsing policy file: /usr/local/etc/tripwire/tw.pol
Generating the database...
*** Processing Unix File System ***
### Warning: File system error.
### Filename: /usr/local/krb5
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/man1
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/man2
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/man3
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/man4
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/man5
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/man6
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/man7
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/man8
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/man9
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/mann
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/krb5/man/manl
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/share/man/mann
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/lib/X11/xdm
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/lib/X11/xkb/compiled
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/man1
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/man2
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/man3
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/man4
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/man5
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/man6
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/man7
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/man8
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/man9
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/mann
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/X11R6/man/manl
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /etc/skeykeys
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /.login
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/src/sys/compile
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/tmp
### No such file or directory
### Continuing...
Wrote database file: /var/db/tripwire/s1.clx.ath.cx.twd
The database was successfully generated.

The tripwire database, configuration file and
policy file are signed using the local and site keys,
therefore according to the support staff at
tripwiresecurity.com, creating a floppy is not necessary.

```

最後にインストールされたコマンドが動作するようにパスを通します。


```
% rehash

```

# Tripwire の設定  {#wa302bf4}
ここではテキスト版の設定ファイルを編集します。


```
% sudo vi /usr/local/etc/tripwire/twcfg.txt

REPORTFILE    =/var/db/tripwire/report/$(HOSTNAME).twr
LOOSEDIRECTORYCHECKING =true
MAILNOVIOLATIONS =flase
EMAILREPORTLEVEL =4
REPORTLEVEL   =4

```

# 設定ファイルの暗号化  {#w8f85b2e}
設定ファイルを暗号化します。


```
% sudo twadmin --create-cfgfile -S /usr/local/etc/tripwire/site.key /usr/local/etc/tripwire/twcfg.txt

```

サイトのパスフレーズを入力します。


```
Please enter your site passphrase:
Wrote configuration file: /usr/local/etc/tripwire/tw.cfg

```

最後にテキスト版の設定ファイルを削除します。


```
% sudo rm -f /usr/local/etc/tripwire/twcfg.txt

```

# ポリシーファイルの作成  {#n035fade}
ポリシーファイルの作成にあたって、[和泉宏明](http://www.aritia.org/hizumi/ "和泉宏明")氏が作られた [Perl スクリプト](http://www.aritia.org/hizumi/dsl/page_21.htm#%81%A0%20%8E%A9%93%AE%93I%82%C9%8FC%90%B3 "Perl スクリプト")を使用します。

## Perl スクリプトの取得  {#c0bab804}

```
% fetch http://www.aritia.org/hizumi/linux/tripwire_pol.pl.txt
% sudo mv tripwire_pol.pl.txt /usr/local/etc/tripwire/tripwire_pol.pl
% sudo chown root:wheel /usr/local/etc/tripwire/tripwire_pol.pl
% sudo chmod 700 /usr/local/etc/tripwire/tripwire_pol.pl

```

## Perl スクリプトからポリシーファイルの作成  {#j442e0e4}

```
% sudo sh -c '/usr/local/etc/tripwire/tripwire_pol.pl /usr/local/etc/tripwire/twpol.txt > /usr/local/etc/tripwire/twpol.txt.tmp'
% sudo rm -f /usr/local/etc/tripwire/twpol.txt
% sudo mv /usr/local/etc/tripwire/twpol.txt.tmp /usr/local/etc/tripwire/twpol.txt

```

# 結果を root に送信する  {#lfc6d4e3}

```
% sudo vi /usr/local/etc/tripwire/twpol.txt

( emailto = root )
{
# Tripwire Binaries
(
  rulename = "Tripwire Binaries",
  severity = $(SIG_HI)
)
( snip )
(
  rulename = "Security Control",
  severity = $(SIG_HI)
)
{
  /etc/group                           -> $(SEC_CRIT) ;
  /etc/crontab                         -> $(SEC_CRIT) ;
}
}
```

# ポリシーファイルの暗号化  {#nc06755e}

```
% sudo twadmin --create-polfile -S /usr/local/etc/tripwire/site.key /usr/local/etc/tripwire/twpol.txt

```

サイトのパスワードを入力する。


```
Please enter your site passphrase:
Wrote policy file: /usr/local/etc/tripwire/tw.pol

```

テキスト版のポリシーファイルを削除する。


```
% sudo rm -f /usr/local/etc/tripwire/twpol.txt

```

# データベースの作成  {#p51a872f}

```
% sudo tripwire --init

```

ローカルのパスワードを入力する。


```
Please enter your local passphrase:
Parsing policy file: /usr/local/etc/tripwire/tw.pol
Generating the database...
*** Processing Unix File System ***
( snip )
### Warning: File system error.
### Filename: /usr/local/etc/tripwire/twcfg.txt
### No such file or directory
### Continuing...
### Warning: File system error.
### Filename: /usr/local/etc/tripwire/twpol.txt
### No such file or directory
### Continuing...
Wrote database file: /var/db/tripwire/s1.clx.ath.cx.twd
The database was successfully generated.

```

Warning が出ているため、設定ファイルの設定を見直す。
その前に設定ファイルが暗号化されているため、これを復号化してから作業する。


```
% sudo sh -c 'twadmin --print-polfile > /usr/local/etc/tripwire/twpol.txt'
% sudo vi /usr/local/etc/tripwire/twpol.txt

  $(TWDB)                              -> $(SEC_CONFIG) -i ;
  $(TWPOL)/tw.pol                      -> $(SEC_BIN) -i ;
  $(TWPOL)/tw.cfg                      -> $(SEC_BIN) -i ;
  #$(TWPOL)/twcfg.txt                   -> $(SEC_BIN) ;
  #$(TWPOL)/twpol.txt                   -> $(SEC_BIN) ;
  $(TWLKEY)/$(HOSTNAME)-local.key      -> $(SEC_BIN) ;
  $(TWSKEY)/site.key                   -> $(SEC_BIN) ;

```

ポリシーファイルの暗号化


```
% sudo twadmin --create-polfile -S /usr/local/etc/tripwire/site.key /usr/local/etc/tripwire/twpol.txt

```

サイトのパスワードを入力する


```
Please enter your site passphrase:
Wrote policy file: /usr/local/etc/tripwire/tw.pol

```

テキスト版のポリシーファイルの削除


```
% sudo rm -f /usr/local/etc/tripwire/twpol.txt

```

古いデータベースを削除して、新しいデータベースを作成する。


```
% sudo rm -f /var/db/tripwire/s1.clx.ath.cx.twd
% sudo tripwire --init

Please enter your local passphrase:
Parsing policy file: /usr/local/etc/tripwire/tw.pol
Generating the database...
*** Processing Unix File System ***
Wrote database file: /var/db/tripwire/s1.clx.ath.cx.twd
The database was successfully generated.

```

# 動作確認  {#yc4971b3}

```
% sudo tripwire --check

Parsing policy file: /usr/local/etc/tripwire/tw.pol
*** Processing Unix File System ***
Performing integrity check...
Wrote report file: /var/db/tripwire/report/s1.clx.ath.cx.twr


Tripwire(R) 2.4.0 Integrity Check Report

Report generated by:          root
Report created on:            Wed Nov 14 02:28:16 2007
Database last updated on:     Never

===============================================================================
Report Summary:
===============================================================================

Host name:                    s1.clx.ath.cx
Host IP address:              192.168.1.100
Host ID:                      None
Policy file used:             /usr/local/etc/tripwire/tw.pol
Configuration file used:      /usr/local/etc/tripwire/tw.cfg
Database file used:           /var/db/tripwire/s1.clx.ath.cx.twd
Command line used:            tripwire --check

===============================================================================
Rule Summary:
===============================================================================

-------------------------------------------------------------------------------
  Section: Unix File System
-------------------------------------------------------------------------------

  Rule Name                       Severity Level    Added    Removed  Modified
  ---------                       --------------    -----    -------  --------
  Local files                     66                0        0        0
  Tripwire Binaries               100               0        0        0
* Tripwire Data Files             100               1        0        0
  System Administration Programs  100               0        0        0
  User Utilities                  100               0        0        0
  Libraries, include files, and other system files
                                  100               0        0        0
  Sources                         100               0        0        0
  (/usr/src)
  NIS                             100               0        0        0
  (/var/yp)
  /etc                            100               0        0        0
  Security Control                100               0        0        0
  Root's home                     100               0        0        0
  FreeBSD Kernel                  100               0        0        0
  (/boot)
  Linux Compatibility             100               0        0        0
  (/compat)
  Invariant Directories           66                0        0        0
  Temporary directories           33                0        0        0

Total objects scanned:  67467
Total violations found:  1

===============================================================================
Object Summary:
===============================================================================

-------------------------------------------------------------------------------
# Section: Unix File System
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
Rule Name: Tripwire Data Files (/var/db/tripwire)
Severity Level: 100
-------------------------------------------------------------------------------

Added:
"/var/db/tripwire/s1.clx.ath.cx.twd"

===============================================================================
Error Report:
===============================================================================

No Errors

-------------------------------------------------------------------------------
*** End of report ***

Tripwire 2.4 Portions copyright 2000 Tripwire, Inc. Tripwire is a registered
trademark of Tripwire, Inc. This software comes with ABSOLUTELY NO WARRANTY;
for details use --version. This is free software which may be redistributed
or modified only under certain conditions; see COPYING for details.
All rights reserved.
Integrity check complete.

```

# シェルスクリプトの作成  {#f415ed6c}
シェルスクリプトを作成し、 **periodic security** で毎日実行します。
**LOCALPASS SITEPASS HOST** は各自の環境に合わせてください。


```
% sudo vi /usr/local/etc/periodic/security/420.tripwire

#!/bin/sh

if [ -r /etc/defaults/periodic.conf ]; then
    . /etc/defaults/periodic.conf
    source_periodic_confs
fi

rc=0
case "${daily_status_security_tripwire_enable:-YES}" in
	[Nn][Oo])
		;;
	*)
		# Config start.
		LOCALPASS=ローカルパスフレーズ
		SITEPASS=サイトパスフレーズ
		HOST=ホスト名
		# Config end.
		TRIPWIRE=/usr/local/sbin/tripwire
		TWADMIN=/usr/local/sbin/twadmin
		TIPWIRE_POL=/usr/local/etc/tripwire/tripwire_pol.pl
		POLICY_TXT=/usr/local/etc/tripwire/twpol.txt
		POLICY_TMP=/usr/local/etc/tripwire/twpol.txt.tmp
		SITE_KEY=/usr/local/etc/tripwire/site.key
		LOG=/var/log/tripwire.log
		# Start
		echo ""
		echo "Checking for a current tripwire database:"
		echo ""
		# Tipwire
		$TRIPWIRE --check --email-report > $LOG
		# Policy
		$TWADMIN --print-polfile > $POLICY_TXT
		$TIPWIRE_POL $POLICY_TXT > $POLICY_TMP
		$TWADMIN --create-polfile -S $SITE_KEY -Q $SITEPASS $POLICY_TMP >> $LOG
		rm -f /usr/local/etc/tripwire/twpol.*
		# Database
		rm -f /var/db/tripwire/$HOST.twd
		$TRIPWIRE --init -P $LOCALPASS >> $LOG
		;;
esac

exit "$rc"

```

実行権限を付与して、テスト実行してみます。


```
% sudo chmod 700 /usr/local/etc/periodic/security/420.tripwire
% sudo /usr/local/etc/periodic/security/420.tripwire
% sudo cat /var/log/tripwire.log

```

# リンク  {#t01f4c01}
[ファイル改竄検知システム（Tripwire）の導入](http://www.crimson-snow.net/hmsvr/bsd/memo/tripwire.html "ファイル改竄検知システム（Tripwire）の導入")
