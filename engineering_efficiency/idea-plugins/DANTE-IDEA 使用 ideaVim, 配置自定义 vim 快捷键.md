> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/qq_40250122/article/details/102054921)

.ideavimrc 配置文件  
其实很简单，修改 ideavim 的配置文件 .ideavimrc 即可。默认情况下该文件并不存在，需要自行创建。macOS 或 Linux 下直接在当前用户目录下新建即可。(Windows 下应该也是在用户目录下新建配置文件，不过文件名应该是 _ideavimrc。）

macOS  
![](https://img-blog.csdnimg.cn/20200219231225268.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMjUwMTIy,size_16,color_FFFFFF,t_70)

wim 系统 C:\Users\Administrator 文件夹下创建_ideavimrc, 我这里用的是 win 系统  
需要安装 ideaVim 插件  
![](https://img-blog.csdnimg.cn/20191004093635545.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMjUwMTIy,size_16,color_FFFFFF,t_70)

![](https://img-blog.csdnimg.cn/20191004093331130.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMjUwMTIy,size_16,color_FFFFFF,t_70)

```
let mapleader=' '
" 启用vim surround功能
set surround
" 显示行号
set nu
" 显示相对行号
set rnu
" 高亮搜索
set hlsearch
" 自动定位到输入中的字符串，不需要回车搜索
set incsearch
set ignorecase
set smartcase
" 显示当前的模式
set showmode
set number
" 相对当前行行数显示
" set relativenumber
set scrolloff=3
set history=100000
" 共享系统粘贴板
set clipboard=unnamed

" clear the highlighted search result
" (清除高亮)
nnoremap <Leader>sc :nohlsearch<CR>

nnoremap <Leader>fs :w<CR>



" Quit normal mode
" (保存关闭)
nnoremap <Leader>q  :q<CR>
nnoremap <Leader>Q  :qa!<CR>

" Move half page faster
" (上下翻页)
nnoremap <Leader>d  <C-d>
nnoremap <Leader>u  <C-u>

" 快速进入vim模式
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kk <Esc>

" Quit visual mode
vnoremap v <Esc>


" Redo
nnoremap U <C-r>

" 以下是一些vim使用方法 -----------------
" viw  vaw  ciw caw diw daw vi' va' ci' ca' di' da' vi( va( ci( ca( di( da( ...

" ###### vim宏：normal模式下 qr 带表给r标记宏 然后vim操作。  @r 重复一次宏 10@r重复10次宏 注意（idea的提示功能干扰，可以在字符串里面先写好然后在复制黏贴）

" ###### 7.2 替换
"           :s/old/new - 用new替换当前行第一个old。
"           :s/old/new/g - 用new替换当前行所有的old。
"           :n1,n2s/old/new/g - 用new替换文件n1行到n2行所有的old。
"           :%s/old/new/g - 用new替换文件中所有的old。
"           :%s/^/xxx/g - 在每一行的行首插入xxx，^表示行首。
"           :%s/$/xxx/g - 在每一行的行尾插入xxx，$表示行尾。
"           有替换命令末尾加上c，每个替换都将需要用户确认。 如：%s/old/new/gc，加上i则忽略大小写(ignore)。
"           有一种比替换更灵活的方式，它是匹配到某个模式后执行某种命令，
"           法为 :[range]g/pattern/command
"           如 :%g/^ xyz/normal dd。
"           示对于以一个空格和xyz开头的行执行normal模式下的dd命令。
"           于range的规定为：
"           果不指定range，则表示当前行。
"           ,n: 从m行到n行。
"           : 最开始一行（可能是这样）。
"           $: 最后一行
"           .: 当前行
"           %: 所有行

" 以上是一些vim使用方法 -----------------

" 以下是自定义快捷键-----------------

" 复制单个单词到寄存器a并标记到o (使用快捷键 空格+y)
" 注释:（mo => 标记o）,(+yiw =>复制当前单词到系统剪切板),("a => 寄存器a) ,("ayiw => 复制当前单词到寄存器a)
nnoremap <Leader>y mo"+yiw"ayiw

" 剪切单个单词到寄存器a并标记到o (使用快捷键 空格+x)
" 注释:（mo => 标记o[标记为的是使用''来回跳标记]）,(+yiw =>复制当前单词到系统剪切板),("a => 寄存器a) ,("ayiw => 复制当前单词到寄存器a),(diw =>删除当前单词)
nnoremap <Leader>x mo"+yiw"ayiwdiw

" 删除单个字符串并黏贴寄存器a的内容并来回标记o和p  (使用快捷键 空格+v)
" 注释：（mp => 标记p）,(viw => 选中当前单词),（"a => 寄存器a）,(p => 将寄存器a内容黏贴到选中的单词),（'o => 跳回标记o）,('p =>跳回标记p[标记为的是使用''来回跳标记])
nnoremap <Leader>v mpviw"ap'o'p

" idea内置快捷键alt+F1 (使用快捷键 空格+m)
nnoremap <Leader>m :action SelectIn<CR>

" idea内置快捷键control+E (使用快捷键 空格+e)
nnoremap <Leader>e :action RecentFiles<CR>

"生成get set方法  (使用快捷键 空格+cc)
nnoremap <Leader>cc :action Generate<CR>

" shift+h--zz(向上翻页)(使用快捷键 空格+h)
nnoremap <Leader>h <S-h>zz

" shift+l--zz(向下翻页)(使用快捷键 空格+l)
nnoremap <Leader>l <S-l>zz

" 以上是自定义快捷键-----------------

" quit ==> close current window
nnoremap <Leader>q <C-W>w

" Window operation
" (关于窗口操作)
nnoremap <Leader>ww <C-W>w
nnoremap <Leader>wd <C-W>c
nnoremap <Leader>wj <C-W>j
nnoremap <Leader>wk <C-W>k
nnoremap <Leader>wh <C-W>h
nnoremap <Leader>wl <C-W>l
nnoremap <Leader>ws <C-W>s
nnoremap <Leader>w- <C-W>s
nnoremap <Leader>wv <C-W>v
nnoremap <Leader>w\| <C-W>v

" Tab operation
" (切换标签)
nnoremap tn gt
nnoremap tp gT

" ==================================================
" Show all the provided actions via `:actionlist`
" ==================================================

" project search
"相当于IDEA的两次shift按钮
nnoremap <Leader>se :action SearchEverywhere<CR>

"查找用法
nnoremap <Leader>fu :action FindUsages<CR>

"打断点
nnoremap <Leader>bb :action ToggleLineBreakpoint<CR>

"查看所有断点
nnoremap <Leader>br :action ViewBreakpoints<CR>

"DUG启动
nnoremap <Leader>cd :action ChooseDebugConfiguration<CR>

"跳转到Action
nnoremap <Leader>ga :action GotoAction<CR>

"跳转到实体类
nnoremap <Leader>gc :action GotoClass<CR>

"跳转到声明
nnoremap <Leader>gd :action GotoDeclaration<CR>

"跳转到文件
nnoremap <Leader>gf :action GotoFile<CR>

"跳转到实现类
nnoremap <Leader>gi :action GotoImplementation<CR>

"跳转到测试类(没有则自动建立)
nnoremap <Leader>gt :action GotoTest<CR>

"显示当前文件路径
nnoremap <Leader>fp :action ShowFilePath<CR>

"激活maven窗口
"nnoremap <Leader>mv :action ActivateMavenProjectsToolWindow<CR>

"修改所有的关联名字
nnoremap <Leader>re :action RenameElement<CR>

"修改当前文件的文件名
nnoremap <Leader>rf :action RenameFile<CR>

"显示用法
nnoremap <Leader>su :action ShowUsages<CR>

"关闭活动显示板
nnoremap <Leader>tc :action CloseActiveTab<CR>

"以下是不常用

"打开命令管理器
nnoremap <Leader>tl Vy<CR>:action ActivateTerminalToolWindow<CR>
vnoremap <Leader>tl y<CR>:action ActivateTerminalToolWindow<CR>

" built in search looks better
" (查找字符串)
nnoremap / :action Find<CR>

" but preserve ideavim search
" (vim自带的搜索)
nnoremap <Leader>/ /

"添加注释
nnoremap <Leader>;; :action CommentByLineComment<CR>

"改变视图
nnoremap <Leader>cv :action ChangeView<CR>

"跳转到标致
nnoremap <Leader>gs :action GotoSymbol<CR>

"
nnoremap <Leader>ic :action InspectCode<CR>

nnoremap <Leader>oi :action OptimizeImports<CR>

nnoremap <Leader>pm :action ShowPopupMenu<CR>

"正常启动工程
nnoremap <Leader>rc :action ChooseRunConfiguration<CR>




```

查看 ideaVim 的内置快捷键 使用：进入 vim 模式 actionlist 查看所有快捷键

![](https://img-blog.csdnimg.cn/20200108185917179.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMjUwMTIy,size_16,color_FFFFFF,t_70)  
如上图黑光标按：再输入 actionlist 查看所有 ideavim 的内置快捷键  
![](https://img-blog.csdnimg.cn/20200108185846797.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMjUwMTIy,size_16,color_FFFFFF,t_70)

快捷键查看

![](https://img-blog.csdnimg.cn/20200108190228147.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQwMjUwMTIy,size_16,color_FFFFFF,t_70)

使用方式  
nnoremap m :action SelectIn