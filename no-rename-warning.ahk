#IfWinActive ahk_class CabinetWClass
While, 1
{
    WinWaitActive, Rename ahk_class #32770
    Send y
}
#IfWinActive
