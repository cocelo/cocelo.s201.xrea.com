+++
title = "[PukiWiki:freebsd] FreeBSD/Base/NFS"
date = "2009-10-23T19:52:48Z"
+++


# サーバ側の設定  {#idea1c0b}
192.168.1.0/24 のネットワークに属している PC に /usr/ports を root 権限で共有する場合。


```
# vi /etc/exports
```


```
/usr/ports -network 192.168.1 -mask 255.255.255.0 -maproot=root
```

再起動時に自動的に起動するように。


```
# vi /etc/rc.conf
```


```
nfs_server_enable="YES"
nfs_reserved_port_only="YES"
mountd_enable="YES"
rpcbind_enable="YES"
rpc_statd_enable="YES"
rpc_lockd_enable="YES"
```

起動。


```
# /etc/rc.d/nfsserver start
# /etc/rc.d/rpcbind start
# /etc/rc.d/mountd start
# /etc/rc.d/nfsd start
# /etc/rc.d/nfslocking start
```

確認。


```
showmount -e
```

# クライアント側の設定  {#ac465a0d}

```
# vi /etc/rc.conf
```


```
nfs_client_enable="YES"
```


```
# /etc/rc.d/nfsclient start
```


```
# mount -t nfs server:/home /mnt
or
# mount_nfs server:/home /mnt
```
