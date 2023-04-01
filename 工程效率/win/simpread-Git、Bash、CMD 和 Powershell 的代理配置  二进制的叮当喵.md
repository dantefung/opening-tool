> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.agedcat.com](https://www.agedcat.com/post/18a6fa7e)

> Git、Bash、CMD 和 Powershell 的代理配置 Git 设置和取消代理 HTTP/HTTPS 代理 1234567git config --global https.proxy http://......

Git 设置和取消代理
-----------

*   HTTP/HTTPS 代理

```
git config --global https.proxy http://127.0.0.1:1080

git config --global https.proxy https://127.0.0.1:1080

git config --global --unset http.proxy

git config --global --unset https.proxy
```

*   SOCKS5 代理

```
git config --global http.proxy socks5://127.0.0.1:1080

git config --global https.proxy socks5://127.0.0.1:1805

git config --global --unset http.proxy

git config --global --unset https.proxy
```

Bash 设置和取消代理
------------

*   HTTP/HTTPS 代理

```
export http_proxy=http://proxyAddress:port

export http_proxy=http://127.0.0.1:12333
export https_proxy=http://127.0.0.1:12333

unset http_proxy
unset https_proxy
```

*   SOCKS 代理

```
export http_proxy="socks5://127.0.0.1:1805"
export https_proxy="socks5://127.0.0.1:1805"
unset http_proxy
unset https_proxy
```

PowerShell 设置代理
---------------

```
$env:HTTP_PROXY="http://127.0.0.1:1080"
$env:HTTP_PROXY="socks5://127.0.0.1:10808"
```

cmd 设置代理
--------

```
set http_proxy=http://127.0.0.1:1080
```

上述方法都是一次性的方法，还可以直接修改配置文件，但是这个方法不太适合需要对流量进行分流的情况。

最好的办法还是在路由端就设置代理。

版权声明: 本博客所有文章除特别声明外，均采用 [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/) 许可协议。转载请注明来自 [二进制的叮当喵](https://www.agedcat.com/)！