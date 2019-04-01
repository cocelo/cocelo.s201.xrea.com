+++
title = "[PukiWiki:wiki] BSD/FreeBSD/ices0"
date = "2008-12-10T09:33:20Z"
+++

# 目次  {#k42dc83f}


# はじめに  {#g572eda0}
- MP3 Vorbis ( ogg ) FLAC AAC をサポート
- リアルタイムエンコードも出来るので音源が Vorbis 等でも WMP で再生できる
- プレイリスト & ファイル名が UTF-8 なら日本語のファイル名でも再生できる

# 配信形式について  {#k8bfff61}
- リアルタイムエンコードする
    -  FLAC だろうが Vorbis だろうが関係なくどのプレイヤーでも再生できる
- リアルタイムエンコードしない
    -  MP3
        -  ストリーミングに対応しているプレイヤー ( Windows Media Player 等) で再生できる
        -  音質が若干低い
    -  Vorbis ( ogg )
        -  一般的なプレイヤー ( Windows Media Player 等) では再生出来ない
        -  音質は MP3 より良い

多少の負荷を我慢できるならリアルタイムエンコードで配信した方が良い。

# 配信時の注意事項  {#o75da017}
- 共通事項
    -  FLAC はメタタグを読み込まない
- foobar2000
    -  MP3 , Vorbis は日本語メタタグが文字化けする
- Winamp
    -  MP3 , Vorbis は英語・日本語共に正常に表示される
- WMP
    -  MP3 , Vorbis , FLAC 共通してタイトルなどのメタタグを表示しない

# インストール  {#u0b289c2}

事前に pkg_tools.conf でオプションを設定しておくと幸せになるかも。


```
# portinstall audio/ices0

To start ices at system boot, copy /usr/local/etc/ices.conf.dist to
/usr/local/etc/ices.conf, modify it to suit your environment and add:

ices0_enable="YES"

to /etc/rc.conf.

```

起動できるように。


```
# vi /etc/rc.conf

ices0_enable="YES"

```

# 設定  {#kf3bfca7}

設定ファイルのコピー。


```
# cp /usr/local/etc/ices.conf.dist /usr/local/etc/ices.conf
# chmod 644 /usr/local/etc/ices.conf

```

とりあえず動くように設定する。


```
# vi /usr/local/etc/ices.conf

```

最低限 <File> <BaseDirectory> <Hostname> <Port> <Password> だけ変更すれば動く。


```
<File>/usr/local/etc/ices-playlist.txt</File>
<BaseDirectory>/var/log/ices</BaseDirectory>
<Hostname>127.0.0.1</Hostname>
<Port>8000</Port>
<Password>password</Password>

```

## 設定例  {#tcb1e9ab}

```
<?xml version="1.0"?>
<ices:Configuration xmlns:ices="http://www.icecast.org/projects/ices">
  <Playlist>
    <!-- This is the filename used as a playlist when using the builtin 
	 playlist handler. -->
    <File>/usr/local/etc/ices-playlist.txt</File>
    <!-- Set this to 0 if you don't want to randomize your playlist, and to
	 1 if you do. -->
    <Randomize>1</Randomize>
    <!-- One of builtin, perl, or python. -->
    <Type>builtin</Type>
    <!-- Module name to pass to the playlist handler if using  perl or python.
	 If you use the builtin playlist handler then this is ignored -->
    <Module>ices</Module>
    <!-- Set this to the number of seconds to crossfade between tracks.
         Leave out or set to zero to disable crossfading (the default).
    <Crossfade>0</Crossfade>
    -->
  </Playlist>

  <Execution>
    <!-- Set this to 1 if you want ices to launch in the background as a
         daemon -->
    <Background>1</Background>
    <!-- Set this to 1 if you want to see more verbose output from ices -->
    <Verbose>0</Verbose>
    <!-- This directory specifies where ices should put the logfile, cue file
	 and pid file (if daemonizing). Don't use /tmp if you have l33t h4x0rz
         on your server. -->
    <BaseDirectory>/var/log/ices</BaseDirectory>
  </Execution>

  <Stream>
    <Server>
      <!-- Hostname or ip of the icecast server you want to connect to -->
      <Hostname>127.0.0.1</Hostname>
      <!-- Port of the same -->
      <Port>8000</Port>
      <!-- Encoder password on the icecast server -->
      <Password>password</Password>
      <!-- Header protocol to use when communicating with the server.
           Shoutcast servers need "icy", icecast 1.x needs "xaudiocast", and
	   icecast 2.x needs "http". -->
      <Protocol>http</Protocol>
    </Server>

    <!-- The name of the mountpoint on the icecast server -->
    <Mountpoint>/example</Mountpoint>
    <!-- The name of the dumpfile on the server for your stream. DO NOT set
	 this unless you know what you're doing.
    <Dumpfile>example.dump</Dumpfile>
    -->
    <!-- The name of you stream, not the name of the song! -->
    <Name>Example</Name>
    <!-- Genre of your stream, be it rock or pop or whatever -->
    <Genre>Other</Genre>
    <!-- Longer description of your stream -->
    <Description>Example Streaming server</Description>
    <!-- URL to a page describing your stream -->
    <URL>http://example.com:8000/</URL>
    <!-- 0 if you don't want the icecast server to publish your stream on
	 the yp server, 1 if you do -->
    <Public>0</Public>

    <!-- Stream bitrate, used to specify bitrate if reencoding, otherwise
	 just used for display on YP and on the server. Try to keep it
	 accurate -->
    <Bitrate>128</Bitrate>
    <!-- If this is set to 1, and ices is compiled with liblame support,
	 ices will reencode the stream on the fly to the stream bitrate. -->
    <Reencode>1</Reencode>
    <!-- Number of channels to reencode to, 1 for mono or 2 for stereo -->
    <!-- Sampe rate to reencode to in Hz. Leave out for LAME's best choice
    <Samplerate>44100</Samplerate>
    -->
    <Channels>2</Channels>
  </Stream>
</ices:Configuration>

```

# ファイル名を UTF-8 に変換  {#jf9a54b2}

プレイリストを作成する前にファイルの文字コードを変換します。

事前に [converters/convmv](/archive/wiki/BSD/FreeBSD/convmv/ "converters/convmv") の導入が必要です。

通常でしたら EUC-JP なファイル名かと思いますが、一応 Shift-JIS を変換する方法も載せておきます。

- EUC-JP to UTF-8

```
# convmv -r -f euc-jp -t utf-8 /share/Music/MP3/
```

- Shift-JIS to UTF-8

```
# convmv -r -f sjis -t utf-8 /share/Music/MP3/

```

これは変換後どのようになるのか表示されるだけですので、実際に変換は行われません。

実際に変換を行う場合は最後に **--notest** を付けます。

- EUC-JP to UTF-8

```
# convmv -r -f euc-jp -t utf-8 /share/Music/MP3/ --notest
```

- Shift-JIS to UTF-8

```
# convmv -r -f sjis -t utf-8 /share/Music/MP3/ --notest

```

# プレイリストの作成  {#y14c9ce8}

次はプレイリストを作成します。


```
# find /share/Music/MP3/*.ogg | nkf -w > /usr/local/etc/ices-playlist.txt

```

これを定期的に cron で回せば CD 買ってきてエンコ→アップでプレイリストに追加されていきます。

# 起動  {#fbf2b0a8}

起動してみる。


```
# /usr/local/etc/rc.d/ices0 start

```

プロセスが上がってるか確認する。


```
# ps -auxww | grep ices

```

icecast の時に開いたページで ices の情報が表示されれば成功。

# シグナル  {#h6620350}
ices がサポートしているシグナルの一覧。

- SIGINT
    -  ices を終了する
- SIGHUP
    -  ices の再起動。プレイリストとログファイルを開きなおす。
- SIGUSR1
    -  現在のトラックスキップして次のトラックを再生する

シグナルの送り方。


```
# kill -USR1 `cat /var/log/ices/ices.pid`

```

phpとかに組み込んだりする場合はどうするんだろう？

# ログローテーション  {#vb87024e}

logrotate を導入している場合は下記のページを参考に logrotate の設定を行えばログローテーションされる。

[ices のログローテーション](/archive/wiki/BSD/FreeBSD/logrotate/ices/ "ices のログローテーション")

# 感想  {#de55f6fd}
大体使ってみた感じ、日本語タグの文字化けさえなんとかなれば普通に使えそうな感じ。

Web 画面では正常に表示されるのでプレイヤー側の問題かなぁと思うんですが･･･。

それと ices は複数起動ができるので ( 設定ファイルとプレイリストも個別に用意 ) 例えば洋楽のみとか邦楽のみ、マイベストストリーミングとかもできます。

ただ、その場合は rc スクリプトを書き換えないとダメっぽいです。

# エンコードソフト  {#ia95c218}
- CD 取り込みは EAC がお勧め
- MP3 エンコードでは沢山ソフトがあるのでお好きなものを
- Vorbis エンコードでは aoTuV が鉄板らしい

## Lame ( MP3 )  {#a91731a1}
- [Sound Player Lilith](http://www.project9k.jp/ "Sound Player Lilith") から lame でエンコード

```
"--preset" "cd" "-q" "0" "%FilePath%%FileName%%FileExt%" "--add-id3v2" %#"--tt" "%>%Title%" %<"--ta" "%>%Artist%" %<"--tl" "%>%Album%" %<"--ty" "%>%Date%" %<"--tc" "%>%Comment%" %<"--tg" "%>%Genre%" %<"--tn" "%>%Track%" %<"%FilePath%%Title%.mp3"

```

## aoTuV ( Vorbis )  {#q040d8e2}
- Q4 ( 128kbs ) でエンコードしても全然聞ける
- 気になるなら Q6 ( 160kbs ) でどうぞ

# リンク  {#d0e66b5c}
- [Icecast.org](http://www.icecast.org/ "Icecast.org")
- [Hiro'sぶろぐ | Lilithで手間なし音声ファイル形式変換](http://n2hiro.dip.jp/~hiro/sb/log/memo/pc/eid147.htm "Hiro'sぶろぐ | Lilithで手間なし音声ファイル形式変換")
- [LAME3.95.1コマンドラインオプション](http://www001.upp.so-net.ne.jp/yama-k/codec/lame3.95option.html "LAME3.95.1コマンドラインオプション")
