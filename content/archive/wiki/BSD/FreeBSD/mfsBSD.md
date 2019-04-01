+++
title = "[PukiWiki:wiki] BSD/FreeBSD/mfsBSD"
date = "2009-12-05T12:45:03Z"
+++


# LiveCDでinstallworld,installkernel  {#re184911}
mfsBSDを使うとCDからinstallworld,installkernelができちゃいます。

# buildworld,buildkernel  {#wd36947e}

```
# cd /usr/src
# make -j4 LOADER_ZFS_SUPPORT=YES KERNCONF=GENERIC buildworld buildkernel
```

# インストール  {#i0717472}

```
# cd ~
# wget http://mfsbsd.vx.sk/release/mfsbsd-1.0-rc2.tar.gz
# tar xvf mfsbsd-1.0-rc2.tar.gz
# cd mfsbsd-1.0-rc2
```

# scripts  {#p1768aa2}

```
# vi scripts/mdsrc
```


```
#!/bin/sh

# PROVIDE: mdsrc
# BEFORE: FILESYSTEMS
# REQUIRE: mountcritlocal
# KEYWORD: FreeBSD

. /etc/rc.subr

name="mdsrc"
start_cmd="mdsrc_start"
stop_cmd=":"

mdsrc_start()
{
        file=`find / -maxdepth 0 -type f -name "src*.uzip"`
        [ -f ${file} ] && mdmfs -P -F ${file} -oro md.uzip /usr/src
}

load_rc_config $name
run_rc_command "$1"
```


```
# vi scripts/mdobj
```


```
#!/bin/sh

# PROVIDE: mdobj
# BEFORE: FILESYSTEMS
# REQUIRE: mountcritlocal
# KEYWORD: FreeBSD

. /etc/rc.subr

name="mdobj"
start_cmd="mdobj_start"
stop_cmd=":"

mdobj_start()
{
        file=`find / -maxdepth 0 -type f -name "obj*.uzip"`
        [ -f ${file} ] && mdmfs -P -F ${file} -oro md.uzip /usr/obj
}

load_rc_config $name
run_rc_command "$1"
```

# make iso  {#n2a8cf45}

```
# make CUSTOM=1 LOADER_ZFS_SUPPORT=YES KERNCONF=GENERIC install
# make CUSTOM=1 SCRIPTS="mdinit mdsrc mdobj mfsbsd interfaces packages" \
MFSMODULES="geom_bsd geom_mbr geom_label geom_mirror geom_stripe geom_part_bsd geom_part_gpt geom_part_mbr" \
mfsroot
# makefs -t ffs -f 5% -b 5% src.img /usr/src
# mkuzip -o tmp/disk/src_8.0-RELEASE.uzip src.img
# makefs -t ffs -f 5% -b 5% obj.img /usr/obj
# mkuzip -o tmp/disk/obj_8.0-RELEASE.uzip obj.img
# make iso
```

# やり直したい時  {#yfd73baa}
いかのどれかを削除するとその時点から作り直してくれる。
例えば.install_doneを消した場合はinstallworld,installkernelからやりなおし。
img,iso,tarを作り直したい場合は該当ファイルを削除する。


```
# rm tmp/.extract_done
# rm tmp/.build_done
# rm tmp/.install_done
# rm tmp/.prune_done
# rm tmp/.packages_done
# rm tmp/.config_done
# rm tmp/.genkeys_done
# rm tmp/.usr.uzip_done
# rm tmp/.boot_done
# rm tmp/.mfsroot_done
```
