+++
title = "[PukiWiki:wiki] Shell/bash"
date = "2008-12-10T09:33:22Z"
+++


# bash メモ  {#cac5c1a3}
bash のメモ。

[Manpage of BASH](http://www.linux.or.jp/JM/html/GNU_bash/man1/bash.1.html "Manpage of BASH")
[Bash Reference Manual](http://www.gnu.org/software/bash/manual/html_node/index.html "Bash Reference Manual")

# 読み込まれるファイル  {#b85196e7}
[Manpage of BASH](http://www.linux.or.jp/JM/html/GNU_bash/man1/bash.1.html#lbAH "Manpage of BASH")
[Bash Startup Files - Bash Reference Manual](http://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html#Bash-Startup-Files "Bash Startup Files - Bash Reference Manual")


```
/etc/profile
~/.bash_profile
~/.bash_login
~/.profile
~/.bashrc
~/.bash_logout
```

## /etc/profile  {#f0ec72fe}
システム全体の設定。
ログイン時に一回だけ読み込まれる。

## ~/.bash_profile  {#c6ae2725}
ユーザの設定。
ログイン時に一回だけ読み込まれる。

## ~/.bash_login  {#le139c6e}
ユーザの設定。
**~/.bash_profile**が存在しない場合、ログイン時に一回だけ読み込まれる。

## ~/.profile  {#dbf47ec7}
ユーザの設定。
**~/.bash_profile** と **~/.bash_login** が存在しない場合、ログイン時に一回だけ読み込まれる。
どちらか一方でも存在していれば~/.profileは読まれない。

## ~/.bashrc  {#n9ce86c1}
ユーザの設定。
シェルを起動する度に読み込まれる。

## ~/.bash_logout  {#k8889580}
ユーザの設定。
ログアウト時に一回だけ読み込まれる。

## まとめ  {#pd953eda}
環境変数は~/.bash_profileに記述する。
コマンドのエイリアスは~/.bashrcに記述する。


```
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi
```

例外として起動時にscreenを立ち上げたいって言う時は~/.bash_profileに**だけ**書けばいい。

# シェル変数と環境変数  {#s1a6b13d}
[Variable Index - Bash Reference Manual](http://www.gnu.org/software/bash/manual/html_node/Variable-Index.html#Variable-Index "Variable Index - Bash Reference Manual")

## 環境変数  {#h247addc}
シェルとシェル上で実行されるアプリケーションでも有効な変数。
LANGなど

## シェル変数  {#yd25b450}
動作中のシェルのみに有効な変数。
PROMPT_COMMAND ($PS1)など

# 組み込みコマンド  {#d347a732}
[Builtin Index - Bash Reference Manual](http://www.gnu.org/software/bash/manual/html_node/Builtin-Index.html#Builtin-Index "Builtin Index - Bash Reference Manual")

## Bourne Shell  {#l97e20ad}
[Bourne Shell Builtins - Bash Reference Manual](http://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#Bourne-Shell-Builtins "Bourne Shell Builtins - Bash Reference Manual")
- :
- break
- cd
- continue
- eval
- exec
- exit
- export
- getopts
- hash
- pwd
- readonly
- return
- shift
- test ( **['' **]'' )
- times
- trap
- umask
- unset

## Bash  {#yea8a59d}
[Manpage of BASH](http://www.linux.or.jp/JM/html/GNU_bash/man1/bash.1.html#lbCW "Manpage of BASH")
[Bash Builtins - Bash Reference Manual](http://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#Bash-Builtins "Bash Builtins - Bash Reference Manual")

[一覧表](/archive/wiki/Shell/bash/bash-builtins/ "一覧表")
