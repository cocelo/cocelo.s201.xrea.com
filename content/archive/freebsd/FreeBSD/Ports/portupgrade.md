+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/portupgrade"
date = "2008-11-16T12:16:11Z"
+++


# portupgrade って？  {#aeef7aa3}
portupgrade は ports の管理をし易くするものです。

# portupgrade インストール  {#f5393930}
まずは portupgrade をインストールします。

```
# cd /usr/ports/ports-mgmt/portupgrade
# make install clean

```

ログディレクトリとpackage作成時の保存ディレクトリを作成します。

```
# mkdir /var/log/ports
# mkdir /usr/ports/packages

```

コマンドを有効化します。

```
# rehash

```

# portaudit って？  {#f1a1ffaa}
脆弱性のある ports などをインストールする時、警告を出してくれたり、定期的にインストールされているportsの脆弱性をチェックしてくれるportsです。

# portaudit インストール  {#o72d66e9}

```
# cd /usr/ports/ports-mgmt/portaudit
# make install clean

# rehash

```

# pkgtools.conf の設定  {#pkgtools}
pkgtools.conf では Make オプションの指定や、無視するカゴテリなど、 ports に関する包括的な設定が出来ます。
以下はコメントを除いた記述になります。


```
# vi /usr/local/etc/pkgtools.conf

```


```
module PkgConfig

  ENV['PORTSDIR'] ||= '/usr/ports'
  ENV['PORTS_INDEX'] ||= ENV['PORTSDIR'] + '/INDEX-local'
  ENV['PACKAGES'] ||= sprintf('/export/ports/packages/%s/%s/%s/%s',
                              OS_PKGBRANCH, OS_PLATFORM, 'athlon64', 's1')
  ENV['PKG_PATH'] ||= '/export/ports/packages/local'
  ENV['PKG_BACKUP_DIR'] ||= ENV['PKG_PATH']

  SANITY_CHECK = true

  IGNORE_CATEGORIES = [
    'arabic',
    'chinese',
    'french',
    'german',
    'hebrew',
    'hungarian',
    'korean',
    'polish',
    'portuguese',
    'russian',
    'ukrainian',
    'vietnamese',
  ]

  EXTRA_CATEGORIES = [
  ]

  ALT_INDEX = [
  ]

  ALT_MOVED = [
  ]

  HOLD_PKGS = [
    'bsdpan-*',
    'ja-cat-doc-*',
  ]

  IGNORE_MOVED = [
    'devel/bison',
  ]

  USE_PKGS = [
  ]

  USE_PKGS_ONLY = [
    'ja-cat-doc-*',
  ]

  ALT_PKGDEP = {
    'devel/apr-svn' => 'devel/apr',
    'net/openldap23-client' => 'net/openldap23-sasl-client',
    'net/openldap24-client' => 'net/openldap24-sasl-client',
  }

  MAKE_ARGS = {
    '*' => [
       'WITHOUT_IPV6=yes',
       'WITHOUT_X11=yes',
       'WITHOUT_GUI=yes',
       'WITH_BDB_VER=47',
    ],
    'converters/libiconv' => [
       'WITH_EXTRA_PATCHES=yes',
    ],
    'databases/gdbm' => [
       'WITH_COMPAT=yes',
    ],
    'databases/mysql50*' => [
       'WITH_CHARSET=utf8',
       'WITH_COLLATION=utf8_general_ci',
       'WITH_XCHARSET=all',
       'BUILD_OPTIMIZED=yes',
       'BUILD_STATIC=yes',
    ],
    'databases/php5-sqlite' => [
       'WITH_UTF8=yes',
    ],
    'databases/postgresql83*' => [
       'WITH_ICU=yes',
       'WITH_PAM=yes',
       'WITH_LDAP=yes',
       'WITH_XML=yes',
       'WITH_TZDATA=yes',
       'WITH_OPTIMIZED_CFLAGS=yes',
    ],
    'devel/apr*' => [
       'APR_UTIL_WITH_BERKELEY_DB=yes',
       'APR_UTIL_WITH_GDBM=yes',
       'APR_UTIL_WITH_LDAP=yes',
    ],
    'devel/git' => [
       'WITH_SVN=yes',
       'WITH_GITWEB=yes',
       'WITH_P4=yes',
       'WITH_CVS=yes',
       'WITH_HTMLDOCS=yes',
    ],
    'devel/subversion' => [
       'WITH_APACHE2_APR=yes',
       'WITH_MOD_DAV_SVN=yes',
       'WITH_NEON=yes',
       'WITH_SERF=yes',
       'WITH_SASL=yes',
       'WITH_BDB=yes',
       'WITH_ASVN=yes',
       'WITH_BOOK=yes',
       'WITH_SVNSERVE_WRAPPER=yes',
       'WITH_REPOSITORY_CREATION=yes',
       'SVNREPOS=/export/svnroot/repos/sandbox',
       'SVNFSTYPE=fsfs',
       'SVNUSER=svn',
       'SVNGROUP=svn',
       '_SVNGRPFILES="db locks locks/db.lock locks/db-logs.lock"',
    ],
    'editors/vim' => [
       'WITH_PYTHON=yes',
       'WITH_RUBY=yes',
       'WITH_PERL=yes',
       'WITH_LANG=yes',
       'WITH_CSCOPE=yes',
       'WITH_EXUBERANT_CTAGS=yes',
    ],
    'graphics/php5-gd' => [
       'WITH_JIS=yes',
    ],
    'japanese/mecab*' => [
       'WITH_CHARSET=utf-8',
    ],
    'japanese/trac' => [
       'WITH_SILVERCITY=yes',
       'WITH_DOCUTILS=yes',
       'WITH_PYGMENTS=yes',
       'WITH_TZ=yes',
       'WITH_PGSQL=yes',
    ],
    'lang/perl5.8' => [
       'WITH_THREADS=yes',
       'WITH_GDBM=yes',
       'ENABLE_SUIDPERL=yes',
    ],
    'lang/php5' => [
       'WITH_MAILHEAD=yes',
       'WITH_REDIRECT=yes',
       'WITH_REGEX_TYPE=php',
       'WITH_ZEND_VM=CALL',
       'WITH_MULTIBYTE=yes',
       'WITH_DISCARD=yes',
    ],
    'lang/php5-extensions' => [
       'WITH_BCMATH=yes',
       'WITH_BZ2=yes',
       'WITH_CALENDAR=yes',
       'WITH_CTYPE=yes',
       'WITH_CURL=yes',
       'WITH_DOM=yes',
       'WITH_EXIF=yes',
       'WITH_FILEINFO=yes',
       'WITH_FILTER=yes',
       'WITH_FTP=yes',
       'WITH_GD=yes',
       'WITH_GETTEXT=yes',
       'WITH_HASH=yes',
       'WITH_ICONV=yes',
       'WITH_IMAP=yes',
       'WITH_JSON=yes',
       'WITH_LDAP=yes',
       'WITH_MBSTRING=yes',
       'WITH_MCRYPT=yes',
       'WITH_MHASH=yes',
       'WITH_MING=yes',
       'WITH_MYSQL=yes',
       'WITH_NCURSES=yes',
       'WITH_OPENSSL=yes',
       'WITH_PCNTL=yes',
       'WITH_PCRE=yes',
       'WITH_PDF=yes',
       'WITH_PDO=yes',
       'WITH_SQLITE=yes',
       'WITH_PGSQL=yes',
       'WITH_POSIX=yes',
       'WITH_PSPELL=yes',
       'WITH_READLINE=yes',
       'WITH_RECODE=yes',
       'WITH_SESSION=yes',
       'WITH_SHMOP=yes',
       'WITH_SIMPLEXML=yes',
       'WITH_SNMP=yes',
       'WITH_SOAP=yes',
       'WITH_SOCKETS=yes',
       'WITH_SPL=yes',
       'WITH_SQLITE=yes',
       'WITH_SYSVMSG=yes',
       'WITH_SYSVSEM=yes',
       'WITH_SYSVSHM=yes',
       'WITH_TIDY=yes',
       'WITH_TOKENIZER=yes',
       'WITH_WDDX=yes',
       'WITH_XML=yes',
       'WITH_XMLREADER=yes',
       'WITH_XMLRPC=yes',
       'WITH_XMLWRITER=yes',
       'WITH_XSL=yes',
       'WITH_YAZ=yes',
       'WITH_ZIP=yes',
       'WITH_ZLIB=yes',
    ],
    'lang/python25' => [
       'WITH_HUGE_STACK_SIZE=yes',
       'WITH_FPECTL=yes',
    ],
    'lang/ruby18' => [
       'WITH_PTHREADS=yes',
       'WITH_ONIGURUMA=yes',
       'WITH_GCPATCH=yes',
       'WITH_RDOC=yes',
    ],
    'mail/dovecot' => [
       'WITHOUT_GSSAPI=yes',
       'WITH_SSL=yes',
       'WITH_MANAGESIEVE=yes',
       'WITH_BDB=yes',
       'WITH_LDAP=yes',
       'WITH_PGSQL=yes',
       'WITH_MYSQL=yes',
       'WITH_SQLITE=yes',
    ],
    'mail/postfix' => [
       'WITH_PCRE=yes',
       'WITH_SASL2=yes',
       'WITH_DOVECOT=yes',
       'WITH_TLS=yes',
       'WITH_BDB=yes',
       'WITH_MYSQL=yes',
       'WITH_PGSQL=yes',
       'WITH_OPENLDAP=yes',
       'WITH_CDB=yes',
       'WITH_VDA=yes',
    ],
    'net/isc-dhcp40*' => [
       'WITH_DHCP_LDAP=yes',
    ],
    'net/openldap24*' => [
       'WITHOUT_BDB=yes',
       'WITH_SASL=yes',
       'WITH_PERL=yes',
    ],
    'net/samba3' => [
       'WITH_SYSLOG=yes',
       'WITH_QUOTAS=yes',
       'WITH_PAM_SMBPASS=yes',
       'WITH_FAM_SUPPORT=yes',
       'WITH_ACL_SUPPORT=yes',
       'WITH_AIO_SUPPORT=yes',
       'WITH_CLUSTER=yes',
       'WITH_EXP_MODULES=yes',
    ],
    'ports-mgmt/portupgrade' => [
       'WITH_BDB4=yes',
    ],
    'security/cyrus-sasl2' => [
       'WITHOUT_GSSAPI=yes',
       'WITHOUT_KERBEROS4=yes',
       'WITHOUT_OTP=yes',
       'WITH_BDB=yes',
       'WITH_MYSQL=yes',
       'WITH_PGSQL=yes',
       'WITH_SQLITE=yes',
       'WITH_KEEP_DB_OPEN=yes',
    ],
    'security/sudo' => [
       'WITH_SHELL_SETS_HOME=yes',
    ],
    'shells/zsh' => [
       'WITH_ZSH_PCRE=yes',
    ],
    'sysutils/screen' => [
       'WITH_XTERM_256=yes',
       'WITH_CJK=yes',
       'WITH_SHOWENC=yes',
       'WITH_HOSTINLOCKED=yes',
    ],
    'sysutils/syslog-ng2' => [
       'WITH_TCP_WRAPPERS=yes',
    ],
    'www/apache22' => [
       'WITH_MPM=worker',
       'WITH_THREADS=yes',
       'WITH_MEM_CACHE=yes',
       'WITH_CGID=yes',
       'WITH_SVN=yes',
       'WITH_DBM=bdb',
       'WITH_DBD=yes',
       'WITH_AUTHN_DBD=yes',
       'WITH_MYSQL=yes',
       'WITH_PGSQL=yes',
       'WITH_SQLITE=yes',
       'WITH_LDAP=yes',
       'WITH_AUTHNZ_LDAP=yes',
       'WITH_PROXY=yes',
       'WITH_PROXY_CONNECT=yes',
       'WITH_PROXY_FTP=yes',
       'WITH_PROXY_HTTP=yes',
       'WITH_PROXY_AJP=yes',
       'WITH_PROXY_BALANCER=yes',
       'WITH_SUEXEC=yes',
       'SUEXEC_DOCROOT=/home',
       'WITH_APR_FROM_PORTS=yes',
       'WITH_PCRE_FROM_PORTS=yes',
    ],
    'www/lighttpd' => [
       'WITH_BZIP2=yes',
       'WITH_CML=yes',
       'WITH_FAM=yes',
       'WITH_GDBM=yes',
       'WITH_MAGNET=yes',
       'WITH_MEMCACHE=yes',
       'WITH_MYSQL=yes',
       'WITH_OPENLDAP=yes',
       'WITH_WEBDAV=yes',
    ],
    'www/w3m' => [
       'M17N=yes',
       'JAPANESE=yes',
    ],
  }

  MAKE_ENV = {
  }

  BEFOREBUILD = {
  }

  BEFOREDEINSTALL = {
  }

  AFTERINSTALL = {
    'x11-servers/XFree86-4-Server' => sprintf(
     'cd %s/bin && if [ -x Xwrapper-4 ]; then ln -sf Xwrapper-4 X; fi',
     x11base()),
  }

  PKG_SITES = [
    pkg_site_mirror(),
  ]

  PORTUPGRADE_ARGS = ENV['PORTUPGRADE'] || \
    '-v -D -l /tmp/portupgrade.results ' + \
    '-L /var/log/ports/%s::%s.log -s'

end
```
