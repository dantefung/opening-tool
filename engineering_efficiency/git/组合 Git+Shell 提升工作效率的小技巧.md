> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/weixin_34067102/article/details/93167314)

## 前言

此篇文章会记录一下我觉得比较实用的 Git+Shell（因为笔者不用 [Sourcetree](https://so.csdn.net/so/search?q=Sourcetree\&spm=1001.2101.3001.7020) 等图形化工具，命令行效率更高，同时通用价值也更高一点）的小技巧，或者也可以说是骚操作，一是为了给自己当备忘录，二是分享给有需要的同学\~

## 技巧

### 批量拉取全部远程分支

平常我们会这样获取所有已追踪的远程分支更新

    git remote update
    git pull --all
    复制代码

如果想获取全部远程分支并在本地创建（有时候拉取 Github 开源项目学习时，经常需要拉取全部分支），以下命令就可以帮你偷个懒。

    for remote in `git branch -r `; do git branch --track $remote; done
    复制代码

### 快速切换分支

有没有一种痛苦，就是切换分支时，一定要写全写对名字才能切换，假如分支名又臭又长的话，那就... 那就只有复制粘贴了！

但是且慢！打开 .gitconfig 文件

    open ~/.gitconfig
    复制代码

在里面输入：

    [alias]
      find-branch = !sh -c \"git branch -a | grep -v remotes | grep $1 | head -n 1 | xargs git checkout\"

> Note:
>
> 1.  通过使用 -v 选项，grep 命令会反向匹配模式，即只输出不匹配模式的行。 grep -v remotes 命令会从输入文本中过滤出不包含字符串 "remotes" 的行，并将符合条件的行输出。查看更多的选项：`grep --help`
>
> 2.  `heand -n 1` head -n 1 命令会从输入中提取出第一行，并将该行作为输出。
>
> 3. xargs命令解释: 
>
> xargs git checkout 是一个使用 xargs 命令的选项组合，它的作用是将从标准输入接收到的参数传递给 git checkout 命令执行。
>
> xargs 命令用于从标准输入或文件中读取数据，并将其作为参数传递给其他命令。通过默认设置，xargs 命令会将输入数据以空白字符（空格、制表符、换行符等）作为分隔符来解析成参数，然后将每个参数依次传递给指定的命令。
>
> 在这个例子中，xargs git checkout 命令会从标准输入中接收参数，并将这些参数依次传递给 git checkout 命令进行执行。这样可以方便地对多个文件或分支进行批量的切换操作。
>
> 以下是一个示例，假设有一个文件 file\_list.txt 内容如下：
> file1.txt
file2.txt
file3.txt
> 如果运行 cat file\_list.txt | xargs git checkout，cat 命令会将文件内容输出到标准输出，然后 xargs 命令会将每一行作为参数传递给 git checkout 命令执行。
> 这将相当于执行了以下命令：
> git checkout file1.txt
git checkout file2.txt
git checkout file3.txt
> 这样就可以批量切换到指定的文件或分支。

>

保存后，此时可以直接在[命令行](https://so.csdn.net/so/search?q=%E5%91%BD%E4%BB%A4%E8%A1%8C\&spm=1001.2101.3001.7020)里输入分支名的前几个字符就行了（只有你确保唯一，否则默认匹配找到的结果的第一个）

如图，直接输入`git find-branch ${shortcut}`这种形式，即可快速风骚切换。

（有心的同学发现了，在. gitconfig 和在. bash\_profile 里发挥想象力，增加各种 alias 别名，可以迅速提高工作效率）

### 批量对部分文件执行 Git 命令

有时候我们需要对某些文件批量进行 Git 操作，而 Git 本身不一定满足这个需求的时候。可以参考以下命令：

    git status -s | grep "README\.md" | sed 's/A //' | while read i; do git reset HEAD $i; done
    git status -s | grep "README\.md" | sed 's/M //' | while read i; do git checkout --ours $i; done

上述命令分为两步，一是将此项目中所有`README.md`文件从暂存区恢复到工作区，二是将此项目中所有`README.md`文件的冲突批量改为保留自己的改动。

上述命令经过一定的修改其实可以满足很多场景的！所以不要被限制住了。

## 小知识

以下摘自互联网，命令具体使用详情可自行检索\~

### xargs

> xargs 命令是给其他命令传递参数的一个过滤器，也是组合多个命令的一个工具。它擅长将标准输入数据转换成命令行参数，xargs 能够处理管道或者 stdin 并将其转换成特定命令的命令参数。

### sh

> sh 命令是 shell 命令语言解释器，执行命令从标准输入读取或从一个文件中读取。

### grep

> grep（global search regular expression(RE) and print out the line，全面搜索正则表达式并把行打印出来）是一种强大的文本搜索工具，它能使用正则表达式搜索文本，并把匹配的行打印出来。

### sed

> sed 可依照脚本的指令来处理、编辑文本文件。用来自动编辑一个或多个文件、简化对文件的反复操作、编写转换程序

想了解更多也可以参考我之前写的这篇：[Shells 命令行学习笔记](https://juejin.im/post/5ccc5004e51d456e39631950)

转载于: <https://juejin.im/post/5d060eff51882502ec1a76b8>
