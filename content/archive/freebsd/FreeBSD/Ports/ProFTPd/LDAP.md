+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/ProFTPd/LDAP"
date = "2009-10-23T05:23:21Z"
+++


# はじめに  {#zac5a55b}
ProFTPd で LDAP 認証をするには WITH_LDAP と、 SSL/TLS over LDAP を使うには WITH_LDAP_TLS が必要です。

# 設定  {#lf231cc3}

```
# vi /usr/local/etc/proftpd.conf
```


```
<IfModule mod_ldap.c>
	LDAPServer		"ldap.example.com:636"
	LDAPUseSSL		on
	LDAPDoAuth		on "dc=example,dc=com"
	LDAPDoUIDLookups	on "ou=People,dc=example,dc=com"
	LDAPDoGIDLookups	on "ou=Group,dc=example,dc=com"
</IfModule>
```
