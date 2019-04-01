+++
title = "[PukiWiki:freebsd] FreeBSD/Base/Kernel"
date = "2008-11-15T00:00:50Z"
+++


# カーネルの再構築  {#ad70c150}
カーネルの再構築を行えば、消費メモリの削減、起動時間が短くなるなど、いろいろなメリットがあります。
SA の適用などを行う場合は、[ベースシステムの再構築](/archive/freebsd/FreeBSD/Base/World/ "ベースシステムの再構築")に進んでください。

# クリーンアップ  {#j7fecfda}
以前に buildkernel や buildworld した事がある場合、下記のようにして /usr/obj 以下を削除してください。
初めて挑戦される方は必要ありません。


```
# chflags -R noschg /usr/obj/*
# rm -rf /usr/obj/*

```

# ログディレクトリの作成  {#t99af4b5}
ログ出力先ディレクトリを作成します。

```
# mkdir /var/log/world
# chmod 700 /var/log/world
```

# カーネルの再構築  {#n0d74702}

## csh系シェルの場合  {#kae53675}

```
# chdir /usr/src/ && nohup /usr/bin/time -l make -j4 buildkernel installkernel >&! /var/log/world/MakeKernel.log &
```

## sh系シェルの場合  {#obe8de7c}

```
# chdir /usr/src/ && nohup /usr/bin/time -l make -j4 buildkernel installkernel > /var/log/world/MakeKernel.log 2>&1 &
```

# 再起動  {#be00a99b}
初めて再構築する方はドキドキの瞬間です。
正常に起動するよう祈りつつ、下記のコマンドを実行しましょう。


```
# shutdown -r now

```

# 確認作業  {#t8a43d98}
新しいカーネルが有効になっているかどうか、確認しましょう。


```
# uname -i
MYKERNEL
```

こんな感じで出力されていれば成功です。
