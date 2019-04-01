+++
title = "[PukiWiki:freebsd] Comment"
date = "2014-04-01T01:13:21Z"
+++


# コメントについて  {#o7951e5b}
記事の内容に誤りがあった場合などこちらのコメントフォームからご連絡下さい。

# 投稿フォーム  {#a7889a42}
## シェルスクリプトのリンク  {#p658d07f}
>[[とおりすがり]] (2010-08-12 (木) 22:30:32)



「PKI自己認証局の構築」のシェルスクリプトですが正しくリンク出来ていないようです。




## ezjail 3.0のパッチを作成してみました。  {#bc21274e}
>[[通りすがり]] (2008-10-22 (水) 13:40:33)



いつもお世話になっております。

パッチ作ってみました。ご高覧願います。


```
---------------cut here---------------------------
--- ezjail-admin.orig	2008-09-26 21:16:42.000000000 +0900
+++ ezjail-admin	2008-10-22 13:25:08.000000000 +0900
@@ -21,6 +21,8 @@
 ezjail_flavours=${ezjail_flavours:-"${ezjail_jaildir}/flavours"}
 ezjail_portscvsroot=${ezjail_portscvsroot:-"freebsdanoncvs@anoncvs.FreeBSD.org:/home/ncvs"}
 ezjail_sourcetree=${ezjail_sourcetree:-"/usr/src"}
+ezjail_makeconf=${ezjail_makeconf:-"/etc/make.conf"}
+ezjail_srcconf=${ezjail_srcconf:-"/etc/src.conf"}
 ezjail_uglyperlhack=${ezjail_uglyperlhack:-"YES"}
 ezjail_default_execute=${ezjail_default_execute:-"/usr/bin/login -f root"}
 
@@ -41,7 +43,7 @@
 ezjail_usage_install="Usage: ${ezjail_admin} install [-mMpPsS] [-h host] [-r release]"
 ezjail_usage_create="Usage: ${ezjail_admin} create [-xbi] [-f flavour] [-r jailroot] [-s size] [-c bde|eli] [-C args] [-a archive] jailname jailip"
 ezjail_usage_delete="Usage: ${ezjail_admin} delete [-w] jailname"
-ezjail_usage_update="Usage: ${ezjail_admin} update [-s sourcetree] [-p] (-b|-i|-u|-P)"
+ezjail_usage_update="Usage: ${ezjail_admin} update [-s sourcetree] [-c make.conf] [-r src.conf] [-p] (-b|-i|-u|-P)"
 ezjail_usage_config="Usage: ${ezjail_admin} config [-r run|norun] [-n newname] [-i attach|detach|fsck] jailname"
 ezjail_usage_console="Usage: ${ezjail_admin} console [-f] [-e command] jailname"
 ezjail_usage_archive="Usage: ${ezjail_admin} archive [-Af] [-a archive] [-d archivedir] jailname [jailname...]"
@@ -659,11 +661,13 @@
   # Clean variables, prevent polution
   unset ezjail_provideports ezjail_installaction
 
-  shift; while getopts :biupPs: arg; do case ${arg} in
+  shift; while getopts :biupPs:c:r: arg; do case ${arg} in
     b) ezjail_installaction="buildworld installworld";;
     i) ezjail_installaction="installworld";;
     u) ezjail_installaction="freebsd-update";;
     s) ezjail_sourcetree=${OPTARG};;
+    c) ezjail_makeconf="${OPTARG}";;
+    r) ezjail_srcconf="${OPTARG}";;
     P) ezjail_provideports="YES"; ezjail_installaction="none";;
     p) ezjail_provideports="YES";;
     ?) exerr ${ezjail_usage_update};;
@@ -696,8 +700,13 @@
     mkdir -p "${ezjail_jailfull}" || exerr "Error: Cannot create temporary Jail directory."
 
     # make and setup our world, then split basejail and newjail
-    cd "${ezjail_sourcetree}" && env DESTDIR="${ezjail_jailfull}" make ${ezjail_installaction} || exerr "Error: The command 'make ${ezjail_installaction}' failed.\n  Refer to the error report(s) above."
-    cd "${ezjail_sourcetree}/etc" && env DESTDIR="${ezjail_jailfull}" make distribution || exerr "Error: The command 'make distribution' failed.\n  Refer to the error report(s) above."
+    if [ `uname -r | sed -e 's/.[0-9]*-.*//'` -gt 7 ]; then
+      cd ${ezjail_sourcetree} && env DESTDIR=${ezjail_jailfull} make __MAKE_CONF=${ezjail_makeconf} ${ezjail_installaction} || exerr "make ${ezjail_installaction} failed.\n  Refer to the error report(s) above."
+      cd ${ezjail_sourcetree}/etc && env DESTDIR=${ezjail_jailfull} make __MAKE_CONF=${ezjail_makeconf} distribution || exerr "make distribution failed.\n  Refer to the error report(s) above."
+    else
+      cd ${ezjail_sourcetree} && env DESTDIR=${ezjail_jailfull} make __MAKE_CONF=${ezjail_makeconf} SRCCONF=${ezjail_srcconf} ${ezjail_installaction} || exerr "make ${ezjail_installaction} failed.\n  Refer to the error report(s) above."
+      cd ${ezjail_sourcetree}/etc && env DESTDIR=${ezjail_jailfull} make __MAKE_CONF=${ezjail_makeconf} SRCCONF=${ezjail_srcconf} distribution || exerr "make distribution failed.\n  Refer to the error report(s) above."
+    fi
     ezjail_splitworld
 
   fi # installaction="none"
-----------------cut here--------------------------------
```

- 申し訳ない。今気づきましたorz とりあえずこちらのパッチ適用して動作確認取れたらアップしようと思います。ありがとうございました。 -- [[cocelo]] &new{2008-11-11 (火) 21:53:16};
- 表示が崩れていたのでpreで囲いました。問題があるようでしたらよろしくお願いします。 -- [[cocelo]] &new{2008-11-11 (火) 21:59:26};

