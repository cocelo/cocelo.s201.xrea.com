+++
title = "[PukiWiki:freebsd] FreeBSD/Utility/fastest_sites"
date = "2009-04-09T17:27:08Z"
+++


# インストール  {#lbaaf719}

```
# cd /usr/ports/ports-mgmt/fastest_sites
# make install clean
```

# distfiles取得先の一覧をファイルに出力  {#yc05ac52}

```
# fastest_sites > /usr/local/etc/ports_sites.conf &
```

# make.confに上記のファイルを読み込むように  {#z6e8ed13}

```
# echo '.include "/usr/local/etc/ports_sites.conf"' >> /etc/make.conf
```
