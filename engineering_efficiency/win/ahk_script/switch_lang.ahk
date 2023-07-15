#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Persistent ;一直运行

; 全局坏境设置 ; {{{1

; 以下环境参数必须设置, 否则快捷键设置失效
#UseHook On
Setkeydelay, -1

; 用于记录搜狗输入法中文状态下是否使用中文标点, 默认不使用
ime_us_cn_point := 0

GetIME() ; {{{1
{ ; 获取当前窗口的活动输入法语言布局ID接口, 该接口是为数不多能个正确的查询到输入法语言状态的接口
    return DllCall("GetKeyboardLayout", "UInt", DllCall("GetWindowThreadProcessId", "UInt", WinActive("A"), "UInt", 0), "UInt")
}

SwitchIME() ; {{{1
{
    global ime_us_cn_point
    if (GetIME() = 0x8040804) ; = 0x8040804 = 中文
        SendMessage, 0x50, 0, 0x00000409, , A
    else
    {
        SendMessage, 0x50, 0, 0x00000804, , A
        if (ime_us_cn_point)
        {
            sleep 50 ; 休眠50ms以保证100%成功率
            Send ^.
        }
    }
}

SetIMEtoEn() ; {{{1
{ ; SendMessage比发送输入法切换快捷键更加的快速稳定, 0x50=WM_INPUTLANGCHANGEREQUEST
    SendMessage, 0x50, 0, 0x00000409, , A
}

SetIMEtoCn() ; {{{1
{ ; SendMessage比发送输入法切换快捷键更加的快速稳定, 0x50=WM_INPUTLANGCHANGEREQUEST
    global ime_us_cn_point
    SendMessage, 0x50, 0, 0x00000804, , A
    if (ime_us_cn_point)
    {
        sleep 50 ; 休眠50ms以保证100%成功率
        Send ^.
    }
}

SwitchUseEnPoint() ; {{{1
{
    global ime_us_cn_point
    if (ime_us_cn_point)
        ime_us_cn_point = 0
    else
        ime_us_cn_point = 1
    ; msgbox % ime_us_cn_point
    Send ^.
}

~esc::
if WinActive("ahk_exe idea64.exe"){
    Send, {ESC}

    ; 下方代码可只保留一个
    MySwitchIME(0x04090409) ; 英语(美国) 美式键盘
    ; SwitchIME(0x08040804) ; 中文(中国) 简体中文-美式键盘
    return
}

MySwitchIME(dwLayout){
    HKL:=DllCall("LoadKeyboardLayout", Str, dwLayout, UInt, 1)
    ControlGetFocus,ctl,A
    SendMessage,0x50,0,HKL,%ctl%,A
}


Shift::SwitchIME() ; 实现Shift按键切换中英输入法
^.::SwitchUseEnPoint() ; 实现 Ctrl+. 切换“中文时使用英文标点”开关效果