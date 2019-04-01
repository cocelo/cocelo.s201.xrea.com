+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Utility/vim"
date = "2008-10-16T04:12:13Z"
+++


# vim  {#haf94972}
FreeBSD 付属の nvi は日本語の表示が出来ないので、 vim を導入します。

# インストール  {#e2736491}
ここでは jvim は導入しません。


```
% sudo portinstall editors/vim
% rehash

```

# vim の設定  {#e3d060df}
デフォルトだとバックアップファイルが作られてしまうので、これを無効にします。


```
SECURITY NOTE: The VIM software has had several remote vulnerabilities
discovered within VIM's modeline support.  It allowed remote attackers to
execute arbitrary code as the user running VIM.  All known problems
have been fixed, but the FreeBSD Security Team advises that VIM users
use 'set nomodeline' in ~/.vimrc to avoid the possibility of trojaned
text files.

```

また、上記のように警告が出ているのでその設定も有効にします。


```
% vi ~/.vimrc

set nomodeline
set nobackup

```

次に root の設定を行います。


```
% sudo vi /root/.vimrc

set nomodeline
set nobackup

```

次に新しくユーザーを作る際にもこの設定が有効になるようにします。


```
% sudo vi /usr/share/skel/dot.vimrc

set nomodeline
set nobackup

```

# nvi と vim を置き換える  {#l7d6bb01}
nvi と vim を置き換える為に、 EDITOR と alias を追加します。


```
% vi ~/.cshrc

alias vi	vim

setenv	EDITOR	vim

```

次に root の設定を行います。


```
% sudo vi /root/.cshrc

alias vi	vim

setenv	EDITOR	vim

```

次に新しくユーザーを作る際にもこの設定が有効になるようにします。


```
% sudo vi /usr/share/skel/dot.cshrc

alias vi	vim

setenv	EDITOR	vim
```

