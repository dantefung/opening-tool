#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent ;一直运行
~esc::

if WinActive("ahk_exe idea64.exe"){
    Send, {ESC}

    ; 下方代码可只保留一个
    SwitchIME(0x04090409) ; 英语(美国) 美式键盘
    ; SwitchIME(0x08040804) ; 中文(中国) 简体中文-美式键盘
    return
}

#If WinActive  ahk_exe WindowsTerminal.exe idea64.exe
:*:o::
{
	sendinput,{o}
	PostMessage, 0x50, 0, 0x8040804, , A
}
return
#If

#If WinActive  ahk_exe WindowsTerminal.exe idea64.exe
:*:a::
{
	sendinput,{a}
	PostMessage, 0x50, 0, 0x8040804, , A
}
return
#If

#If WinActive  ahk_exe WindowsTerminal.exe idea64.exe
:*:i::
{
	sendinput,{i}
	PostMessage, 0x50, 0, 0x8040804, , A
}
return
#If

SwitchIME(dwLayout){
    HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus,ctl,A
    SendMessage,0x50,0,HKL,%ctl%,A
}