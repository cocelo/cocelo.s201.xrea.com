+++
title = "[PukiWiki:freebsd] FreeBSD/Base/World"
date = "2010-10-16T21:46:32Z"
+++


# ベースシステムの再構築について  {#ebca6156}
最近では freebsd-update(8) が登場したりと、あまり出番がなくなった buildworld ですが、バイナリパッチということで、システムに適合出来ない場合があると思います。
そういった時の為に buildworld の方法を覚えておきましょう。

# クリーンアップ  {#j7fecfda}
以前に buildkernel や buildworld した事がある場合、下記のようにして /usr/obj 以下を削除してください。
初めて挑戦される方は必要ありません。


```
# chflags -R noschg /usr/obj/*
# rm -rf /usr/obj/*

```

# ソースツリーの更新  {#jc4b49ea}
SA ( Security Advisory ) が出ている場合は下記ページを参考に、ソースツリーの更新を行ってください。
- [ソースツリーの更新](/archive/freebsd/FreeBSD/Base/csup/ "ソースツリーの更新")

# ログディレクトリの作成  {#cb49cd96}
worldのログ出力先ディレクトリを作成します。

```
# mkdir /var/log/world
# chmod 700 /var/log/world
```

# ベースシステムの再構築  {#tc56abf2}
データセンターにサーバを設置している場合は、シングルユーザーモードでの buildworld が出来ません。(シリアルコンソールからログイン出来る場合はその限りではありません。)
よくある例として実家にサーバを置いて、遠隔保守をしている方などはもっぱらこの方法になると思います。

以下の例ではnohupから起動し、バックグラウンドで実行しているので、ログアウト後もmake worldが継続されるようになっています。
ログを閲覧したい場合はtailコマンドで確認出来ます。

## csh系シェルでmake world  {#ud60c434}

```
# cd /usr/src
# nohup /usr/bin/time -l make -j4 buildworld buildkernel >&! /var/log/build.log &
# nohup /usr/bin/time -l make installkernel >&! /var/log/installkernel.log &
# mergemaster -siva
# nohup /usr/bin/time -l make installworld >&! /var/log/installworld.log &
# mergemaster -sivr
```

## sh系シェルでmake world  {#mb23ac2f}

```
# cd /usr/src
# nohup /usr/bin/time -l make -j4 buildworld buildkernel > /var/log/build.log 2>&1 &
# nohup /usr/bin/time -l make installkernel > /var/log/installkernel.log 2>&1 &
# mergemaster -siva
# nohup /usr/bin/time -l make installworld > /var/log/installworld.log 2>&1 &
# mergemaster -sivr
```

# 古いファイルの削除  {#h9c4888f}

```
# make check-old
# make delete-old
```

# 再起動  {#mac61350}

```
# shutdown -r now
```


```
# uname -a
```


```
# head -n 1 /var/log/world/buildworld.log && tail -n 1 /var/log/world/buildworld.log
```

# 参考リンク  {#nebf83c0}
[buildworldのログをのこしてみる \( nohup と time と date\) - 天下泰平 The Whole World is peaceful.](http://d.hatena.ne.jp/taizooo/20060530/1148985036 "buildworldのログをのこしてみる \( nohup と time と date\) - 天下泰平 The Whole World is peaceful.")
