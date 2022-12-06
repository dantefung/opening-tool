#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


#z::
SetFormat, Integer, H
WinID:=WinActive("A")
ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0) 
InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt") 
Clipboard:=InputLocaleID
MsgBox, %InputLocaleID%
return