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