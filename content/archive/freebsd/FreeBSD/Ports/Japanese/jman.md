+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Japanese/jman"
date = "2008-11-16T05:52:52Z"
+++


# 日本語マニュアルの導入  {#s8bb30a8}
FreeBSD は man が充実しているので、日常作業の中で man は多用します。
その man を日本語 man に置き換える事によって、作業の効率化を図ろうというものです。

# インストールの前に  {#rd7105b9}
日本語マニュアルを閲覧するには jless ( Jam less ) か lv が必要になります。
下記のページでは lv の導入方法を解説していますので、別途そちらをご参照下さい。
- [lv の導入](/archive/freebsd/FreeBSD/Ports/Japanese/lv/ "lv の導入")

# 日本語マニュアルについて  {#daf4af4c}
2008 年 10 月 17 日現在の最新の RELEASE は 7.0-RELEASE および、 6.3-RELEASE です。
ports にある日本語マニュアルは 5.4-RELEASE 用と、若干古いものになっています。
そこで、 [有限会社小金丸コンピュータエンジニアリングサービス](http://www.koganemaru.co.jp/ "有限会社小金丸コンピュータエンジニアリングサービス") 様が独自にメンテナンス、配布されている日本語マニュアルを導入します。

# ダウンロード  {#x41a697c}
[有限会社小金丸コンピュータエンジニアリングサービス](http://www.koganemaru.co.jp/ "有限会社小金丸コンピュータエンジニアリングサービス") 様から 6.3-RELEASE 用の日本語マニュアルをダウンロードします。


```
% fetch http://home.jp.freebsd.org/%7Ekogane/JMAN/ja-cat-doc-6.3.20080215.tbz

```

また、 7.0-RELEASE をお使いの方は 7.0-RELEASE 用の日本語マニュアルをダウンロードします。


```
% fetch http://home.jp.freebsd.org/%7Ekogane/JMAN/ja-cat-doc-7.0.20081014.tbz

```

# インストール  {#l9b1f18b}
次に上記でダウンロードしてきた ja-cat-doc をインストールします。


```
% sudo pkg_add ja-cat-doc-6.3.20080215.tbz

```

同様に、 7.0-RELEASE をお使いの方は 7.0-RELEASE 用の日本語マニュアルをインストールします。


```
% sudo pkg_add ja-cat-doc-7.0.20081014.tbz

```

# manpath の変更  {#y68fcfe0}
次にデフォルトの man を置き換える為に **/etc/manpath.config** を編集します。


```
% grep MANPATH_MAP /etc/manpath.config

```


```
# MANPATH_MAP           path_element    manpath_element
MANPATH_MAP     /bin                    /usr/share/man
MANPATH_MAP     /usr/bin                /usr/share/man
MANPATH_MAP     /usr/local/bin          /usr/local/man
MANPATH_MAP     /usr/X11R6/bin          /usr/X11R6/man
```

この中の **/bin** および **/usr/bin** の行の末尾に **/ja** を追記します。


```
% sudo vi /etc/manpath.config

```


```
MANPATH_MAP     /bin                    /usr/share/man/ja
MANPATH_MAP     /usr/bin                /usr/share/man/ja
```

書き換えた後、正常に man が表示出来るかどうか試してください。


```
% man man

```

正常に表示されなかった場合は **/etc/manpath.config** の設定が間違っているか、 **PAGER** に日本語表示の出来ないページャが設定されている可能性があります。
