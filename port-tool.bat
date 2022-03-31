@echo off 
:main
echo ------------------------------
echo 1.全部端口列表
echo 2.查询端口信息
echo 3.查询PID对应进程
echo 4.解除端口占用
echo ------------------------------
	echo.
set /p X=输入数字选择功能:

if %X%==1 (
	goto findAllPort
)else if %x%==2 (
goto mPort
)else if %x%==3 (
goto findPid
)else if %x%==4 (
goto killPort
)

:findAllPort
cls
	echo.	
	netstat -aon
	echo.
	goto main
	
:mPort
cls
    set /p mport=请输入要查找的端口:
	echo.	
	echo   协议   本地地址          	外部地址        	状态           PID
	netstat -aon|findstr %mport%
	echo.
	goto main

:findPid
cls
    set /p mPid=请输入端口对应的PID号:
	tasklist|findstr %mPid%
	echo.
	goto main
	
:killPort
cls
set /p mPid=请输入需要解除端口对应的PID号:

taskkill /f /t /pid %mPid%
	echo.
	goto main
