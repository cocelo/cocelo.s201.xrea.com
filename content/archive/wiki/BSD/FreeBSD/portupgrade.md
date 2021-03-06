+++
title = "[PukiWiki:wiki] BSD/FreeBSD/portupgrade"
date = "2008-12-10T09:33:20Z"
+++

# portupgrade Memo  {#k5ae25ae}


## Install  {#zbf67bca}

```
# mkdir /var/log/ports

# cd /usr/ports/ports-mgmt/portupgrade
# make install clean

NOTE: If you upgrade, it's recomended to run pkgdb -L to restore lost
      dependencies.

      Fill ALT_PKGDEP section in pkgtools.conf file for portupgrade
      be aware of alternative dependencies you use.
      E.g.
      ALT_PKGDEP = {
        'www/apache13' => 'www/apache13-modssl',
        'print/ghostscript-afpl' => 'print/ghostscript-gnu',
      }

      Note also, portupgrade knows nothing how to handle ports with different
      suffixes (E.g. -nox11). So you should explicitly define variables
      (E.g. WITHOUT_X11=yes) for the ports in /etc/make.conf or pkgtools.conf
      (MAKE_ARGS section) files.

# mkdir /usr/ports/packages
# mkdir /usr/ports/packages/All

# cd /usr/ports/ports-mgmt/portaudit
# make install clean

# rehash

```

## Setting  {#w48acbb7}

### pkgtools.conf  {#ue11c464}

```
# cd /usr/local/etc/
# cp pkgtools.conf.sample pkgtools.conf
# chmod 644 pkgtools.conf
# vi pkgtools.conf

  # 無視するカテゴリ？
  IGNORE_CATEGORIES = [
	'games',
	'chinese',
	'french',
	'german',
	'hebrew',
	'korean',
	'russian',
	'ukrainian',
	'vietnamese',
	'x11',
	'x11-clocks',
	'x11-fm',
	'x11-fonts',
	'x11-servers',
	'x11-themes',
	'x11-toolkits',
	'x11-wm',
  ]
  # 野良 Ports 置き場
  EXTRA_CATEGORIES = [
  ]
  # ローカル INDEX ファイル？
  ALT_INDEX = [
  ]
  # ローカル MOVED ファイル？
  ALT_MOVED = [
  ]
  # portupgrade でアップデートしたくない Ports など。
  # 主に package などを指定する？
  HOLD_PKGS = [
	'bsdpan-*',
  ]
  # package をアップデートする。
  # USE_PKGS は更新される package が見つからなければ Ports で更新する。
  USE_PKGS = [
  ]
  # USE_PKGS_ONLY は更新される package が見つからない場合は更新しない。
  USE_PKGS_ONLY = [
  ]
  # 代替パッケージ
  ALT_PKGDEP = {
	'devel/apr-svn' => 'devel/apr',
	'ftp/proftpd-mysql' => 'ftp/proftpd',
	'devel/subversion-perl' => 'devel/subversion',
	'devel/subversion-python' => 'devel/subversion',
	'devel/subversion-ruby' => 'devel/subversion',
	'www/clearsilver-python' => 'www/clearsilver',
  }
  # portupgrade 関連のフロントエンドで make 時に引数を参照する。
  MAKE_ARGS = {
	'*' => [
		'WITH_BDB_VER=42',
		'WITHOUT_X11=yes',
		'WITHOUT_IPV6=yes',
	],
	'converters/libiconv' => [
		'WITH_EXTRA_PATCHES=yes',
	],
	'databases/mysql50-*' => [
		'WITH_CHARSET=utf8',
		'WITH_XCHARSET=all',
		'WITH_COLLATION=utf8_general_ci',
		'BUILD_STATIC=yes',
		'BUILD_OPTIMIZED=yes',
	],
	'devel/apr' => [
		'APR_UTIL_WITH_BERKELEY_DB=yes',
		'APR_UTIL_WITH_LDAP=yes',
	],
  	'devel/subversion' => [
		'WITH_PERL=yes',
		'WITH_RUBY=yes',
		'WITH_PYTHON=yes',
		'WITH_MOD_DAV_SVN=yes',
		'WITH_APACHE2_APR=yes',
		'WITH_BERKELEYDB=db42',
	],
  	'ftp/proftpd' => [
		'WITH_LDAP=yes',
		'WITH_OPENSSL=yes',
	],
  	'japanese/trac' => [
		'WITH_SILVERCITY=yes',
		'WITH_DOCUTILS=yes',
	],
	'lang/php5' => [
		'WITH_APACHE=yes',
		'WITH_MULTIBYTE=yes',
		'WITH_MAILHEAD=yes',
	],
	'lang/php5-extensions' => [
		'WITH_BCMATH=yes',
		'WITH_BZ2=yes',
		'WITH_CALENDAR=yes',
		'WITH_CURL=yes',
		'WITH_DOM=yes',
		'WITH_EXIF=yes',
		'WITH_FILEINFO=yes',
		'WITH_FTP=yes',
		'WITH_GD=yes',
		'WITH_GETTEXT=yes',
		'WITH_IMAP=yes',
		'WITH_JSON=yes',
		'WITH_LDAP=yes',
		'WITH_MBSTRING=yes',
		'WITH_MCRYPT=yes',
		'WITH_MHASH=yes',
		'WITH_MYSQL=yes',
		'WITH_OPENSSL=yes',
		'WITH_SOAP=yes',
		'WITH_SOCKETS=yes',
		'WITH_XSL=yes',
		'WITH_ZIP=yes',
		'WITH_ZLIB=yes',
	],
	'mail/dovecot' => [
		'WITH_LDAP=yes',
		'WITH_MYSQL=yes',
	],
	'mail/postfix' => [
		'WITH_BDB=yes',
		'WITH_DOVECOT=yes',
		'WITH_MYSQL=yes',
		'WITH_OPENLDAP=yes',
		'WITH_PCRE=yes',
		'WITH_TLS=yes',
		'WITH_VDA=yes',
	],
	'net/openldap23-server' => [
		'WITH_SASL=yes',
	],
	'net/samba3' => [
		'WITHOUT_CUPS=yes',
		'WITH_SYSLOG=yes',
	],
	'security/cyrus-sasl2' => [
		'WITHOUT_GSSAPI=yes',
		'WITHOUT_OTP=yes',
	],
	'www/apache22' => [
		'WITH_MYSQL=yes',
		'WITH_DBM=bdb',
			'WITH_BERKELEYDB=db42',
		'WITH_SUEXEC=yes',
			'SUEXEC_DOCROOT=/home',
		'WITH_LDAP_MODULES=yes',
		'WITH_PROXY_MODULES=yes',
		'WITH_APR_FROM_PORTS=yes',
	],
	'www/clearsilver' => [
		'WITH_PYTHON=yes',
	],
  }
  PORTUPGRADE_ARGS = ENV['PORTUPGRADE'] || \
	'-v -D -L /var/log/ports/'

```

## Memo  {#k1147411}
ALT_PKGDEP で依存関係が壊れるのが直ればいいんだけど･･･。

EXTRA_CATEGORIES ALT_INDEX ALT_MOVED は野良 ports 使ってない場合は記述しない感じ。

### Subversion  {#seeade99}
devel/apr-svn

```
env PKGNAMESUFFIX=-svn portupgrade -f devel/apr

```

### Trac  {#if5aac00}
devel/subversion-python

```
env PKGNAMESUFFIX=-python portupgrade -f devel/subversion
```

www/clearsilver-python

```
env PKGNAMESUFFIX=-python portupgrade -f www/clearsilver
```

