+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Live_DVD"
date = "2010-12-03T07:03:16Z"
+++


# Live DVDの構築  {#k4e852fb}
FreeBSD 8.1-RELEASEで作業。

# buildworld, buildkernel  {#x903a505}

```
# make -j8 __MAKE_CONF=/dev/null SRCCONF=/dev/null WITHOUT_PROFILE=YES KERNCONF=GENERIC buildworld buildkernel
```

# installworld distrib-dirs distribution installkernel  {#mdc3b6e2}

```
# echo $WORKDIR
/export
# echo $BOOTDIR
/export/boot
# echo $DESTDIR
/export/live
# make __MAKE_CONF=/dev/null SRCCONF=/dev/null WITHOUT_PROFILE=YES INSTALL_NODEBUG=YES KERNCONF=GENERIC installworld distrib-dirs distribution installkernel
```

# $DESTDIR/etc/rc.conf  {#j066b32b}

```
# echo 'hostname="livebsd"' >> $DESTDIR/etc/rc.conf
# echo 'ifconfig_DEFAULT="DHCP"' >> $DESTDIR/etc/rc.conf
# echo 'tcp_drop_synfin="YES"' >> $DESTDIR/etc/rc.conf
# echo 'icmp_drop_redirect="YES"' >> $DESTDIR/etc/rc.conf
# echo 'keymap="us.pc-ctrl"' >> $DESTDIR/etc/rc.conf
# echo 'keyrate="fast"' >> $DESTDIR/etc/rc.conf
# echo 'keybell="off"' >> $DESTDIR/etc/rc.conf
# echo 'update_motd="NO"' >> $DESTDIR/etc/rc.conf
# echo 'ntpd_enable="YES"' >> $DESTDIR/etc/rc.conf
# echo 'ntpd_sync_on_start="YES"' >> $DESTDIR/etc/rc.conf
# echo 'sshd_enable="YES"' >> $DESTDIR/etc/rc.conf
# echo 'sendmail_enable="NO"' >> $DESTDIR/etc/rc.conf
# echo 'sendmail_submit_enable="NO"' >> $DESTDIR/etc/rc.conf
# echo 'sendmail_outbound_enable="NO"' >> $DESTDIR/etc/rc.conf
# echo 'sendmail_msp_queue_enable="NO"' >> $DESTDIR/etc/rc.conf
# echo 'syslogd_enable="NO"' >> $DESTDIR/etc/rc.conf
# echo 'newsyslog_enable="NO"' >> $DESTDIR/etc/rc.conf
# echo 'cron_enable="NO"' >> $DESTDIR/etc/rc.conf
# echo 'crashinfo_enable="NO"' >> $DESTDIR/etc/rc.conf
# echo 'virecover_enable="NO"' >> $DESTDIR/etc/rc.conf
# echo 'cleanvar_enable="NO"' >> $DESTDIR/etc/rc.conf
```

# $DESTDIR/etc/motd  {#k4d6241e}

```
# printf "Welcome to Live FreeBSD\n\n" > $DESTDIR/etc/motd
```

# $DESTDIR/etc/ttys  {#n4f47b6b}

```
# perl -pie 's/^(ttyv[1-8].*)on (.*)/\1off\2/g' $DESTDIR/etc/ttys
```

# $DESTDIR/etc/sysctl.conf  {#n4f47b6b}

```
# echo "hw.syscons.bell=0" >> $DESTDIR/etc/sysctl.conf
# echo "net.inet.tcp.blackhole=2" >> $DESTDIR/etc/sysctl.conf
# echo "net.inet.udp.blackhole=1" >> $DESTDIR/etc/sysctl.conf
# echo "net.inet.icmp.icmplim=50" >> $DESTDIR/etc/sysctl.conf
```

# $DESTDIR/etc/src.conf  {#q3012e12}

```
# echo 'WITHOUT_PROFILE=YES' > $DESTDIR/etc/src.conf
```

# $DESTDIR/etc/ssh/sshd_config  {#s1dc248d}

```
# perl -pie 's/.*(PermitRootLogin).*/\1 yes/' /etc/ssh/sshd_config
```

# $DESTDIR/etc/ssh/ssh_host*  {#w46cd4b0}

```
# ssh-keygen -t rsa1 -b 1024 -f $DESTDIR/etc/ssh/ssh_host_key -N ''
# ssh-keygen -t dsa -f $DESTDIR/etc/ssh/ssh_host_dsa_key -N ''
# ssh-keygen -t rsa -f $DESTDIR/etc/ssh/ssh_host_rsa_key -N ''
```

# $DESTDIR/etc/master.passwd  {#y95f8788}

```
# echo 'root' | pw -V $DESTDIR/etc usermod root -h 0
```

# $BOOTDIR/{boot,rescue}  {#y0e4b0da}

```
# mv $DESTDIR/boot $BOOTDIR/boot
# mv $DESTDIR/rescue $BOOTDIR/rescue
```

# $BOOTDIR/uzip/system.uzip  {#r3493787}

```
# mkdir $BOOTDIR/uzip
# makefs -t ffs -f 5% -b 5% $WORKDIR/system.img $DESTDIR
# mkuzip -o $BOOTDIR/uzip/system.uzip $WORKDIR/system.img
# rm $WORKDIR/system.img
```

# $BOOTDIR/uzip/src.uzip  {#r3493787}

```
# makefs -t ffs -f 5% -b 5% $WORKDIR/src.img /usr/src
# mkuzip -o $BOOTDIR/uzip/src.uzip $WORKDIR/src.img
# rm $WORKDIR/src.img
```

# $BOOTDIR/uzip/obj.uzip  {#r3493787}

```
# makefs -t ffs -f 5% -b 5% $WORKDIR/obj.img /usr/obj
# mkuzip -o $BOOTDIR/uzip/obj.uzip $WORKDIR/obj.img
# rm $WORKDIR/obj.img
```

# $BOOTDIR/boot/loader.conf  {#b388f4a7}

```
# echo 'autoboot_delay="-1"' > $BOOTDIR/boot/loader.conf
# echo 'geom_uzip_load="YES"' >> $BOOTDIR/boot/loader.conf
# echo 'init_path="/rescue/init"' >> $BOOTDIR/boot/loader.conf
# echo 'init_shell="/rescue/sh"' >> $BOOTDIR/boot/loader.conf
# echo 'init_script="/boot/newroot.rc"' >> $BOOTDIR/boot/loader.conf
# echo 'init_chroot="/newroot"' >> $BOOTDIR/boot/loader.conf
```

# $BOOTDIR/boot/newroot.rc  {#a1ca5188}

```
# vi $BOOTDIR/boot/newroot.rc
```


```
#!/bin/sh
#set -x
PATH=/rescue

mount -u -w /

[ ! -d /cdrom ] && mkdir /cdrom
mount -t cd9660 /dev/acd0 /cdrom || mount -t cd9660 /dev/cd0 /cdrom

[ ! -d /newroot ] && mkdir /newroot
mdmfs -P -F /cdrom/uzip/system.uzip -o ro md.uzip /newroot

[ ! -d /rwroot ] && mkdir /rwroot
mdmfs -s 64m md /rwroot
mount -t unionfs /rwroot /newroot

if [ -f /cdrom/uzip/src.uzip]; then
    mdmfs -P -F /cdrom/uzip/src.uzip -o ro md.uzip /newroot/usr/src
fi

if [ -f /cdrom/uzip/obj.uzip]; then
    mdmfs -P -F /cdrom/uzip/obj.uzip -o ro md.uzip /newroot/usr/obj
fi

[ ! -d /newroot/dev ] && mkdir /newroot/dev
mount -t devfs devfs /newroot/dev

kenv init_shell="/bin/sh"
echo "newroot setup done"
exit 0
```

# build iso  {#c2a3f5db}

```
# mkisofs -b boot/cdboot -no-emul-boot -R -J -V Live_FreeBSD -o $WORKDIR/Live_FreeBSD.iso $BOOTDIR
```
