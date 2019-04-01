+++
title = "[PukiWiki:wiki] Shell/zsh"
date = "2009-12-21T19:57:07Z"
+++


# zsh メモ  {#nd681b15}
zshのメモとか。

[ZSH - THE Z SHELL](http://zsh.sourceforge.net/ "ZSH - THE Z SHELL")

# 関連ファイル  {#tae21a53}

```
/etc/zshenv
$ZDOTDIR/.zshenv
/etc/zprofile
$ZDOTDIR/.zprofile
/etc/zshrc
$ZDOTDIR/.zshrc
/etc/zlogin
$ZDOTDIR/.zlogin
/etc/zlogout
$ZDOTDIR/.zlogout
```

## ログインシェルの場合  {#ya5d5feb}
chshなどでログインシェルをzshにした場合は以下の順序で読み込まれる。

0.  /etc/zshenv
0.  $ZDOTDIR/.zshenv
0.  /etc/zprofile
0.  $ZDOTDIR/.zprofile
0.  /etc/zshrc
0.  $ZDOTDIR/.zshrc
0.  /etc/zlogin
0.  $ZDOTDIR/.zlogin

ログアウト時には以下のファイルが読み込まれる。

0.  /etc/zlogout
0.  $ZDOTDIR/.zlogout

## 対話的シェルの場合  {#nf942c84}
bashやtcshからzshなどと、手動で起動された場合は以下の順序で読み込まれる。

0.  /etc/zshenv
0.  $ZDOTDIR/.zshenv
0.  /etc/zshrc
0.  $ZDOTDIR/.zshrc

## 非対話的シェルの場合  {#yd3f15fe}
シェルスクリプトなどでzshを起動した場合は以下の順序で読み込まれる。

0.  /etc/zshenv
0.  $ZDOTDIR/.zshenv

## まとめると  {#xc81eddb}
zshenvには環境変数の設定など、非対話的な設定のみを記述する。
zprofileにはscreenの起動など、ログイン時に行いたい処理を記述する。
zshrcには補完の設定やプロンプト表示の設定、zsh自体の設定などを記述する。
zloginにはssh-agentの鍵登録など、ログイン時に処理を行う設定を記述する。
zlogoutにはssh-agentによって登録された鍵ファイルの解除など、ログアウト時に処理を行う設定を記述する。
