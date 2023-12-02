#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#k::   ;; #-> win键   k->字母键k
Send {Up}   ;;输入 上 键
return

#j::
Send {Down}
return

#h::
Send {Left}
return

#l::
Send {Right}
return