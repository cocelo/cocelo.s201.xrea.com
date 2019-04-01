+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Apache_2.2/OpenLDAP"
date = "2008-10-16T04:12:07Z"
+++


# はじめに  {#yd9b4435}
デフォルトの Apache では LDAP 認証を行えないので各自インストール時のオプションを見直してください。

# mod_ldap の設定  {#db43231e}
OpenLDAP を SSL ( ldaps://IP/ 等 ) で起動している場合は CA 証明書の指定を行います。


```
# vi /usr/local/etc/apache22/Includes/mod_ldap.conf

LDAPTrustedGlobalCert CA_BASE64 /usr/local/etc/apache22/ca.crt

<Location /ldap-status>
	SetHandler ldap-status

	Order deny,allow
	Deny from all
	Allow from 192.168.1.0/24

	AuthName "ldap-status"
	AuthType Basic
	AuthBasicProvider ldap
	AuthLDAPURL ldaps://ldap.clx.ath.cx/ou=Users,ou=System,dc=clx,dc=ath,dc=cx?uid
	AuthzLDAPAuthoritative off
	Require valid-user
</Location>
```

