+++
title = "[PukiWiki:wiki] BSD/FreeBSD/ices0/module"
date = "2008-12-10T09:33:20Z"
+++

# 目次  {#deb22384}


# はじめに  {#ze08dc3a}
Perl モジュールを使って動的なプレイリスト作成をしてみようという話。
PHP はちょっと使えるけど Perl はダメダメなので何か問題が起きても責任は取りません。

# 必要モジュールのインストール  {#w225efa7}
Perl で ices0 を操作するのにいくつか必要なモジュールがあります。
MP3 なら [MP3::Info](http://search.cpan.org/dist/MP3-Info/ "MP3::Info") が必要ですし、 Ogg Vorbis なら [Ogg::Vorbis::Header::PurePerl](http://search.cpan.org/dist/Ogg-Vorbis-Header-PurePerl/ "Ogg::Vorbis::Header::PurePerl") が必要です。

今回は MP3 でエンコードしたファイルの情報を表示させる為、 [MP3::Info](http://search.cpan.org/dist/MP3-Info/ "MP3::Info") を使用します。


```
# portinstall audio/p5-MP3-Info

```

# Perl モジュールのコピー  {#vcd404ad}
標準なら **/usr/local/etc/modules/ices.pm.dist** にサンプルファイルがあります。
これを **/usr/local/etc/modules/ices.pm** としてコピーします。


```
# cp /usr/local/etc/modules/ices.pm.dist /usr/local/etc/modules/ices.pm

```


```
#!/usr/bin/perl
# At least ices_get_next must be defined. And, like all perl modules, it
# must return 1 at the end.

use strict;
use Encode;
use MP3::Info;

my $dir = '/share/local/MP3';

my $file;

# Function called to initialize your python environment.
# Should return 1 if ok, and 0 if something went wrong.

sub ices_init {
	print "Perl subsystem Initializing:\n";
	return 1;
}

# Function called to shutdown your python enviroment.
# Return 1 if ok, 0 if something went wrong.
sub ices_shutdown {
	print "Perl subsystem shutting down:\n";
	return 1;
}

# Function called to get the next filename to stream.
# Should return a string.
sub ices_get_next {
	my @array = glob("$dir/*.mp3");
	my $index = rand @array;
	$file = $array[$index];

	return $file;
}

# If defined, the return value is used for title streaming (metadata)
sub ices_get_metadata {
	my $tag = get_mp3tag($file);

	my $album = Encode::encode("utf8", $tag->{ALBUM});
	my $artist = Encode::encode("utf8", $tag->{ARTIST});
	my $title = Encode::encode("utf8", $tag->{TITLE});

	return "[$album] $artist - $title";
}

# Function used to put the current line number of
# the playlist in the cue file. If you don't care
# about cue files, just return any integer.
sub ices_get_lineno {
	return 1;
}

return 1;
```
