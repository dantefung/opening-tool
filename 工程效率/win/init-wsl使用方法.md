
### 背景

由于wsl子系统每次重启它的ip都是变化的，为此，提供了如下方法将ip固定下来

**思路:**
新增网卡，构建一个宿主机和wsl子系统之间的局域网.


### 操作步骤

**第一步: 打开终端窗口**

```
# `WSL 2`新增网卡
# - 设置私有IP网段为192.168.33.10
# - 广播地址为192.168.169.15
# - 网卡名称为 eth0
# - 设置网卡标签 eth0:1
wsl -u root ip addr add 192.168.33.10 broadcast 192.168.169.15 dev eth0 label eth0:1

# 设置宿主机网卡`vEthernet (WSL)`地址为 `192.168.33.1`-需要管理员权限
netsh interface ip add address "vEthernet (WSL)" 192.168.33.1 255.255.255.240
```

**第二步: 配置init-wsl.bat脚本**

**2.1、新建init-wsl.bat**
笔者将该脚本文件放置在了D:\software\initwsl\init-wsl.bat

**2.2、设置开启启动执行init-wsl.bat脚本**
Windows键+R，输入regedit打开注册列表，在地址栏输入计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run定位到对应注册表位置，右键新建一个字符串值，键入init-wsl.bat脚本绝对路径即可

![](https://minsonlee.github.io/images/article/regedit-add-init-wsl.png)


### 附录

`init-wsl.bat`脚本:

```

@echo off
:: run task as administrator
%1 %2
ver|find "5.">nul&&goto :Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close)&goto :eof
:Admin

:: set WSL distribution
set distribution=Ubuntu-20.04

:: 设置WSL初始化脚本位置
set initWSL=/etc/init.wsl

:: 配置宿主机私有网络IP、WSL2私有网络IP、广播地址、子网掩码
set hostOSIP=192.168.33.1
set WSL2IP=192.168.33.10
set WSL2Broadcast=192.168.33.15
set subnetMask=255.255.255.240

:: init WSL2 services
wsl -d %distribution% -u root -e %initWSL%
if %ERRORLEVEL% NEQ 0 (
    echo init WSL services error OR Already init WSL!
    pause
) else (
    echo init WSL success!
)

:: set wsl2 ip
wsl -d %distribution% -u root ip addr | findstr "%WSL2IP%" > nul
if !errorlevel! equ 0 (
    echo wsl ip has set!
) else (
    wsl -d %distribution% -u root ip addr add %WSL2IP% broadcast %WSL2Broadcast% dev eth0 label eth0:1
    echo set wsl ip success: %WSL2IP%
)

:: set windows ip
ipconfig | findstr %hostOSIP% > nul
if !errorlevel! equ 0 (
    echo windows ip has set!
) else (
    netsh interface ip add address "vEthernet (WSL)" %hostOSIP% %subnetMask%
    echo set windows ip success: %hostOSIP%
)
```
