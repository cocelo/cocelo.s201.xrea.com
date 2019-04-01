+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Japanese/convmv"
date = "2008-10-16T04:12:08Z"
+++


# convmv  {#rda74748}
FreeBSD では日本語のファイル名も扱えますが、使われている文字が Shift-JIS や EUC-JP など、混同している場合、ターミナル上で文字化けが発生してしまいます。
これを解決する手段として convmv を使用して、ファイル名に使われている文字コードを任意の文字コードに変換します。

# インストール  {#s3ca94e3}
ここも sudo でインストールします。


```
% sudo portinstall converters/convmv
% rehash

```

# 使い方  {#ha84dc5b}
下記ではユーザのホームディレクトリにある日本語のファイル名を変換します。
これは変換後どのようになるのか表示されるだけですので、実際に変換は行われません。

- EUC-JP to UTF-8

```
% convmv -r -f euc-jp -t utf-8 *
```

- Shift-JIS to UTF-8

```
% convmv -r -f sjis -t utf-8 *

```

実際に変換を行う場合は最後に **--notest** を付けます。

- EUC-JP to UTF-8

```
% convmv -r -f euc-jp -t utf-8 * --notest
```

- Shift-JIS to UTF-8

```
% convmv -r -f sjis -t utf-8 * --notest
```

