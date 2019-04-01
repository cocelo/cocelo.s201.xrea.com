+++
title = "[PukiWiki:wiki] BSD/FreeBSD/ProFTPD"
date = "2008-12-10T09:33:19Z"
+++

# ProFTPD Memo  {#gbf79bca}


## Link  {#xc62b4e4}
- http://www.proftpd.org/
- http://www.aconus.com/~oyaji/ftp/proftpd_rpm.htm
- http://www.aconus.com/~oyaji/ftp/proftpd_ssl_rpm.htm
- http://www.aconus.com/~oyaji/ftp/proftpd_virtual.htm

## Install  {#qedc9950}

```
# portinstall ftp/proftpd
# rehash

```

## Settings  {#a1aef9f3}

```
# vi /usr/local/etc/proftpd.conf

#
# To have more informations about Proftpd configuration
# look at : http://www.proftpd.org/
#
# This is a basic ProFTPD configuration file (rename it to
# 'proftpd.conf' for actual use.  It establishes a single server
# and a single anonymous login.  It assumes that you have a user/group
# "nobody" and "ftp" for normal operation and anon.

ServerName			"clx.ath.cx FTP Server"
ServerType			standalone
DefaultServer			on
ScoreboardFile			/var/run/proftpd/proftpd.scoreboard

# Port 21 is the standard FTP port.
Port				21

# Umask 022 is a good standard umask to prevent new dirs and files
# from being group and world writable.
Umask				022

# To prevent DoS attacks, set the maximum number of child processes
# to 30.  If you need to allow more than 30 concurrent connections
# at once, simply increase this value.  Note that this ONLY works
# in standalone mode, in inetd mode you should use an inetd server
# that allows you to limit maximum number of processes per service
# (such as xinetd).
MaxInstances			30

CommandBufferSize		512

# Set the user and group under which the server will run.
User				nobody
Group				nogroup

# To cause every FTP user to be "jailed" (chrooted) into their home
# directory, uncomment this line.
DefaultRoot ~ !wheel

# Normally, we want files to be overwriteable.
AllowOverwrite		on

# Bar use of SITE CHMOD by default
<Limit SITE_CHMOD>
  DenyAll
</Limit>

TimesGMT off
IdentLookups off
UseReverseDNS off
ServerIdent off

TransferRate RETR 10.0:1048576 group !wheel

# The maximum number of clients allowed to connect per host.(default none: no limit)
MaxClientsPerHost 1

# The the maximum number of times different hosts.　(default none: no limit)
MaxHostsPerUser 1

# Enable automatic deletion of partially uploaded files (default off)
DeleteAbortedStores on

# Sets the idle connection timeout (default: 600)
TimeoutIdle 600

# Sets the login timeout (default: 300)
TimeoutLogin 300

# Sets the connection without transfer timeout (default: 600)
TimeoutNoTransfer 600

# Sets a timeout for an entire session (default: none)
TimeoutSession none

# Sets the timeout on stalled downloads (default: 0 {no limit})
TimeoutStalled 600

# Logging
LogFormat allinfo "%t :  %u (%a [%h]) : [%s], %T, %m (%f)"
LogFormat write "%t : %u : %F (%a)"
LogFormat read "%t : %u : %F (%a)"
LogFormat auth "%t : %u (%a [%h])"
ExtendedLog /var/log/proftpd/all.log ALL allinfo
ExtendedLog /var/log/proftpd/write.log WRITE write
ExtendedLog /var/log/proftpd/read.log  READ read
ExtendedLog /var/log/proftpd/auth.log AUTH auth

# A basic anonymous configuration, no upload directories.  If you do not
# want anonymous users, simply delete this entire <Anonymous> section.
#########################################################################
#                                                                       #
# Uncomment lines with only one # to allow basic anonymous access       #
#                                                                       #
#########################################################################

#<Anonymous ~ftp>
#   User				ftp
#   Group				ftp

  ### We want clients to be able to login with "anonymous" as well as "ftp"
  # UserAlias			anonymous ftp

  ### Limit the maximum number of anonymous logins
  # MaxClients			10

  ### We want 'welcome.msg' displayed at login, and '.message' displayed
  ### in each newly chdired directory.
  # DisplayLogin			welcome.msg
  # DisplayFirstChdir		.message

  ### Limit WRITE everywhere in the anonymous chroot
  # <Limit WRITE>
  #   DenyAll
  # </Limit>
#</Anonymous>

# proftpd -t -c /usr/local/etc/proftpd.conf

# mkdir /var/log/proftpd

# vi /etc/rc.conf

# proftpd
proftpd_enable="YES"

# /usr/local/etc/rc.d/proftpd start
```

