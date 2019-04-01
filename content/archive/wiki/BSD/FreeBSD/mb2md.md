+++
title = "[PukiWiki:wiki] BSD/FreeBSD/mb2md"
date = "2008-12-10T09:33:20Z"
+++

# mb2md Memo  {#oa56601c}


## Install  {#w9532c09}

```
# portinstall mail/mb2md
# rehash

```

## spool 内のメールを変換 ( ユーザ毎に実行する )  {#g845e8c1}

```
# mb2md -m
```

## mbox を Maildir 変換 ( ユーザ毎に実行する )  {#td4836d7}

```
# mb2md -s mbox
```

