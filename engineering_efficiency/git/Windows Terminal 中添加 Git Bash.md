> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [blog.csdn.net](https://blog.csdn.net/ccjcjc/article/details/126067146)

> Git Bash 有自动提示补全的功能

*   右键 Git Bash 快捷键，提取出 exe 路径
*   打开 Windows Terminnal 的设置界面，在命令行一栏填写 exe 路径

```
C:\Program Files\Git\git-bash.exe
```

*   在图标栏填写图标路径

```
C:\Program Files\Git\mingw64\share\git\git-for-windows.ico
```

*   随便填写其他字段的名称，点击右下角保存按钮
*   若想要改变 Git Bash 的按钮顺序，那就点击设置界面中的`打开JSON文件`按钮，调整`profiles` - `list`的顺序
*   若想要将 Git Bash 作为选项卡嵌入 Windows Terminal，那就将命令行一栏改为

```
C:\Program Files\Git\bin\bash.exe 
# 该路径位于git-bash.exe的子目录下，该exe与git-bash.exe实现效果一样
```