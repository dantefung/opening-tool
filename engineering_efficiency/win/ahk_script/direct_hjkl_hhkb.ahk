#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;;#k::   ;; #-> win键   k->字母键k
;;Send {Up}   ;;输入 上 键
;;return

#j::
;;Send {Down}
;;return

;;#h::
;;Send {Left}
;;return

;;#l::
;;Send {Right}
;;return

;; win + . 映射为 alt + . idea中跳转到下一个错误
;;#.::!.

;; + 表示与其他键组合是的Shift键 shift + win + . 映射为 shift + alt + .  idea中跳转上一个错误
;;+#.::+!.

;; win + 1 映射为 alt + 1  idea中表示侧边栏是否打开
;;#1::!1

;; win + enter 映射为 alt + enter idea中表示提示建议

;;#Enter::!Enter

;; 左alt和左win键互换
LAlt::LWin
LWin::LAlt
