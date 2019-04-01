+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Kernel"
date = "2008-12-10T09:33:19Z"
+++

# Kernel Memo  {#k50af2fb}


## S2KERNEL  {#d2229d86}
&ref(S2KERNEL);


```
# vi /usr/src/sys/i386/conf/S2KERNEL

```

後はコピペなりなんなり。

### Compile  {#of1f6c7a}

```

# cd /usr/src

# chflags -R noschg /usr/obj/usr
# rm -rf /usr/obj/usr

# make -j4 buildkernel
# make installkernel
# shutdown -r now

# uname -a
```

