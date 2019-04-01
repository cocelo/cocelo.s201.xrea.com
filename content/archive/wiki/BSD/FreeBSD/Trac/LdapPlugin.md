+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Trac/LdapPlugin"
date = "2008-12-10T09:33:19Z"
+++

# Trac LdapPlugin Memo  {#bedef24a}


## Link  {#ta1b7108}
- [LdapPlugin - Trac Hacks - Plugins Macros etc. - Trac](http://trac-hacks.org/wiki/LdapPlugin "LdapPlugin - Trac Hacks - Plugins Macros etc. - Trac")
- [LdapPluginTests - Trac Hacks - Plugins Macros etc. - Trac](http://trac-hacks.org/wiki/LdapPluginTests "LdapPluginTests - Trac Hacks - Plugins Macros etc. - Trac")

## Install  {#j6067b42}

```
# portinstall www/trac-ldap

Installed /usr/local/lib/python2.4/site-packages/LdapPlugin-0.5.1dev-py2.4.egg

# cp /usr/local/lib/python2.4/site-packages/LdapPlugin-0.5.1dev-py2.4.egg /usr/local/www/trac/sandbox/plugins/.

```

## Setting  {#m4280cc0}
### Apache Basic Authentication  {#v416f125}

```
# vi /usr/local/etc/apache22/Includes/trac.conf

<Location /trac>
	SetHandler mod_python
	PythonHandler trac.web.modpython_frontend
	PythonOption TracEnvParentDir /usr/local/www/trac
	PythonOption TracUriRoot /trac

	AuthType		Basic
	AuthName		"trac"
	AuthBasicProvider	ldap
	AuthLDAPURL		"ldap://ldap.clx.ath.cx/ou=People,dc=clx,dc=ath,dc=cx?uid"
	AuthzLDAPAuthoritative	off
	Require			valid-user
</Location>

```

### trac Authentication  {#a0a627c3}

```
#[ldap]
# enable LDAP support for Trac
#enable = false
# enable TLS support
#use_tls = false
# LDAP directory host
#host = localhost
# LDAP directory port (default port for LDAPS/TLS connections is 636)
#port = 389
# BaseDN
#basedn = dc=example,dc=com
# Relative DN for users (defaults to none)
#user_rdn = 
# Relative DN for group of names (defaults to none)
#group_rdn = 
# objectclass for groups
#groupname = groupofnames
# dn entry in a groupname
#groupmember = member
# attribute name for a group
#groupattr = cn
# attribute name for a user
#uidattr = uid
# attribute name to store trac permission
#permattr = tracperm
# filter to search for dn with 'permattr' attributes
#permfilter = objectclass=*
# time, in seconds, before a cached entry is purged out of the local cache.
#cache_ttl = 900
# maximum number of entries in the cache
#cache_size = 100
# whether to perform an authenticated bind for group resolution
#group_bind = false
# whether to perform an authenticated bind for permision store operations
#store_bind = false
# user for authenticated connection to the LDAP directory
#bind_user = 
# password for authenticated connection
#bind_passwd =
# global permissions (vs. per-environment permissions)
#global_perms = false
# group permissions are managed as addition/removal to the LDAP directory groups
#manage_groups = true
# whether a group member contains the full dn or a simple uid
#groupmemberisdn = true

# vi /usr/local/www/trac/sandbox/conf/trac.ini

[trac]
# ...
permission_store = LdapPermissionStore

[components]
ldapplugin.* = enabled

[ldap]
enable = true
basedn = dc=clx,dc=ath,dc=cx
user_rdn = ou=People
group_rdn = ou=Group
groupname = groupofnames
groupmember = member
groupattr = cn
uidattr = uid
permattr = tracperm
store_bind = true
bind_user = cn=tracAdmin,ou=People,dc=clx,dc=ath,dc=cx
bind_passwd = passwd
```

