#!/usr/bin/env perl

use 5.010;
use strict;
use warnings;
use utf8;

use Term::Encoding qw(term_encoding);
my $encoding = term_encoding;
binmode STDIN  => ":encoding($encoding)";
binmode STDOUT => ":encoding($encoding)";
binmode STDERR => ":encoding($encoding)";

use Cwd qw(getcwd);
use File::Path qw(mkpath);

my $type = 'freebsd';
my $path = $ENV{'HOME'} . "/Website/cocelo.s201.xrea.com/wiki/data/$type/wiki";
my $dest = getcwd() . "/content/archive/$type";

if ( ! -d $path ) {
	say 'パスを確認してください。';
	exit;
}

chdir($path);
my @list = glob "*";
my ($src, $dst, $data, $dir, @lines, $date, $bpre, $ipre);
my ($sec, $min, $hour, $day, $mon, $year);
my ($str, $title, $url);
foreach(@list) {
	# 16進数から変換
	$src = $path . '/' . $_;
	$data = $_;
	$data =~ s/([0-9A-F]{2})/chr(hex($1))/ge;

	# PukiWiki標準ファイルは処理スキップ
	next if $data =~ /^:|^Bracket|^Format|^Help|^Inter|^Menu|^Puki|^Recent|^Sand|^Wiki|^Yuki|^[\x65-\x74][\x5f-\x62]/;

	# スペースをアンダーバーに変換
	$data =~ s/ /_/g;
	# .txt拡張子を削除
	$data =~ s/\.txt$//;
	# ディレクトリ作成用変数
	$dir = $dest . '/' . $data;
	# ディレクトリプリフィックス
	$dir =~ s/^/\//;
	# ディレクトリを一階層下に
	$dir =~ s/\/\w+$/\//g;
	# ディレクトリプリフィックス
	$dir =~ s/^\/|\/$//;

	# ディレクトリ作成
	if ( ! -d $dir ) {
		mkpath $dir or die $!;
	}

	# 出力先
	$dst= $dest . '/' . $data . '.md';

	if ( -f $src ) {
		# ソースファイル読み込み
		open(FH, '< :encoding(utf8)', $src) or die $!;
		@lines = <FH>;
		close(FH);

		# ファイル更新日取得
		($sec, $min, $hour, $day, $mon, $year) = localtime((stat $src)[9]);
		$year = $year + 1900;
		$mon++;
		$date = sprintf("%04d-%02d-%02dT%02d:%02d:%02dZ", $year, $mon, $day, $hour, $min, $sec);

		# ファイル書き込み
		open(FH, '> :encoding(utf8)', $dst) or die $!;
		# Front Matter記述
		say FH '+++';
		say FH 'title = "' . "[PukiWiki:$type] " . $data . '"';
		say FH 'date = "' . $date . '"';
		say FH '+++';
		say FH '';
		# preフラグリセット
		$bpre = 0;
		$ipre = 0;
		# PukiWiki記法変換
		for (@lines) {
			# 改行コードを除去
			chomp;
			# コメント行はスキップ
			next if /^\/\//;
			# 目次/フォームはスキップ
			next if /^(#contents|#comment|#article)/;

			# preフラグが立っている場合は文字列をそのまま格納
			if ($bpre == 0) {
				if (/^[^\s]/ and $ipre == 1) {
					$ipre = 0;
					say FH '```';
					say FH '';
				} elsif (/^\s(.*)/ and \$_ == \$lines[-1] and $ipre == 1) {
					$ipre = 0;
					say FH $1;
					say FH '```';
					say FH '';
					next;
				} elsif (/^\s(.*)/ and $ipre == 1) {
					say FH $1;
					next;
				} elsif (/^\s(.*)/ and $ipre == 0) {
					$ipre = 1;
					say FH '';
					say FH '```';
					say FH $1;
					if (\$_ == \$lines[-1]) {
						$ipre = 0;
						say FH '```';
						say FH '';
					}
					next;
				}
			}

			if ($ipre == 0) {
				if (/^\}\}/ and $bpre == 1) {
					$bpre = 0;
					say FH '```';
					next;
				} elsif (\$_ == \$lines[-1] and $bpre == 1) {
					$bpre = 0;
					say FH;
					say FH '```';
					next;
				} elsif ($bpre == 1) {
					say FH;
					next;
				} elsif (/^#pre\{\{/ and $bpre == 0) {
					$bpre = 1;
					say FH '';
					say FH '```';
					next;
				}
			}

			# 見出し
			if (/^\*{1}\s*([^\*].*)\s*\[(#\w+)\]$/) {
				$_ = "# $1 {$2}";
			} elsif (/^\*{2}\s*([^\*].*)\s*\[(#\w+)\]$/) {
				$_ = "## $1 {$2}";
			} elsif (/^\*{3}\s*([^\*].*)\s*\[(#\w+)\]$/) {
				$_ = "### $1 {$2}";
			} elsif (/^\*{4}\s*([^\*].*)\s*\[(#\w+)\]$/) {
				$_ = "#### $1 {$2}";
			} elsif (/^\*{5}\s*([^\*].*)\s*\[(#\w+)\]$/) {
				$_ = "##### $1 {$2}";
			} elsif (/^\*{6}\s*([^\*].*)\s*\[(#\w+)\]$/) {
				$_ = "###### $1 {$2}";
			}

			# 番号なしリスト
			if (/^-{2}([^-].*)$/) {
				$_ = "    " . "- $1";
			} elsif (/^-{3}([^-].*)$/) {
				$_ = "        " . "- $1";
			} elsif (/^-{4}([^-].*)$/) {
				$_ = "            " . "- $1";
			} elsif (/^-{5}([^-].*)$/) {
				$_ = "                " . "- $1";
			} elsif (/^-{6}([^-].*)$/) {
				$_ = "                    " . "- $1";
			}

			# 番号ありリスト
			if (/^\+{1}([^\+].*)$/) {
				$_ = "0. $1";
			} elsif (/^\+{2}([^\+].*)$/) {
				$_ = "    " . "1. $1";
			} elsif (/^\+{3}([^\+].*)$/) {
				$_ = "        " . "2. $1";
			} elsif (/^\+{4}([^\+].*)$/) {
				$_ = "            " . "3. $1";
			} elsif (/^\+{5}([^\+].*)$/) {
				$_ = "                " . "4. $1";
			} elsif (/^\+{6}([^\+].*)$/) {
				$_ = "                    " . "5. $1";
			}

			# ここからインライン要素

			# リンク
			my $count = (() = $_ =~ m/\[\[(.*?)\]\]/g);
			$count++;
			for (my $i = 0; $i < $count; $i++) {
				if (/\[\[(.*?)\]\]/) {
					$str = $&;
					$title = "";
					$url = "";

					# 外部リンク
					if ($1 =~ /^(.*?):((https?|ftps?):\/\/.*)$/) {
						$title = $1;
						$url = $2;
					} elsif ($1 =~ /^WikiPedia\.ja:(.*)$/) {
						$title = "WikiPedia.ja:$1";
						$url = "https:\/\/ja.wikipedia.org\/wiki\/$1";
					} elsif ($1 =~ /^(.*?)>((https?|ftps?):\/\/.*)$/) {
						$title = $1;
						$url = $2;
					# 内部リンク
					} elsif ($1 =~ /^(.*?)>\/(.*)$/) {
						$title = $1;
						$url = $2;
					} elsif ($1 =~ /^(.*?)>(#.*)$/) {
						$title = $1;
						$url = $2;
					} elsif ($1 =~ /^(.*?)>(.*)(#.*)$/) {
						$title = $1;
						$url = "/archive/$type/$2/$3";
					} elsif ($1 =~ /^(.*?)>(.*)$/) {
						$title = $1;
						$url = "/archive/$type/$2/";
					} else {
						say '[Link] Not match: ' . $type . '/' . $data;
					}

					# マッチした文字列を置換
					if ($title ne '' and $url ne '') {
						$title =~ s/\(/\\\(/g;
						$title =~ s/\)/\\\)/g;
						$url =~ s/\s/_/g;
						$_ =~ s/\Q$str\E/[$title]($url "$title")/;
					}
				}
			}

			# 太字
			$_ =~ s/''([^'].*?[^'])''/**$1**/g;

			# 斜体
			$_ =~ s/'''(.*?)'''/*$1*/g;

			# 取り消し
			$_ =~ s/%%(.*?)%%/~~$1~~/g;

			# 改行
			$_ =~ s/~$/\n/;

			say FH;
		}
		close(FH);
	}
}
