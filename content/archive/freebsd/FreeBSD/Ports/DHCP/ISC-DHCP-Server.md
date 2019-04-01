+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/DHCP/ISC-DHCP-Server"
date = "2008-11-25T14:39:42Z"
+++


# インストール  {#zd83288b}

```
$ sudo portinstall net/isc-dhcp30-server
```

# 設定  {#g45f894b}

```
$ sudo cp /usr/local/etc/dhcpd.conf.sample /usr/local/etc/dhcpd.conf
$ sudoedit /usr/local/etc/dhcpd.conf
```


```
# dhcpd.conf
#
# Sample configuration file for ISC dhcpd
#

# option definitions common to all supported networks...
option domain-name "example.org"; <= 変更
option domain-name-servers ns1.example.org, ns2.example.org; <= 変更

default-lease-time 600;
max-lease-time 7200;

# If this DHCP server is the official DHCP server for the local
# network, the authoritative directive should be uncommented.
authoritative;

# ad-hoc DNS update scheme - set to "none" to disable dynamic DNS updates.
ddns-update-style none;

# Use this to send dhcp log messages to a different log file (you also
# have to hack syslog.conf to complete the redirection).
log-facility local7;

subnet 10.0.0.0 netmask 255.0.0.0 {
        # Gateway.
        option routers 10.0.0.1;

        # Faixa de IPs disponiveis para alocar.
        range 10.0.0.10 10.0.0.20;
}
```

# rc スクリプトの有効化  {#y17466c0}

```
$ sudoedit /etc/rc.conf
```


```
dhcpd_enable="YES"
```

# 起動  {#f6b3904c}

```
$ sudo /usr/local/etc/rc.d/isc-dhcpd start
```
