#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; From https://www.autohotkey.com/boards/viewtopic.php?f=6&t=18519
SetDefaultKeyboard(LocaleID){
	Static SPI_SETDEFAULTINPUTLANG := 0x005A, SPIF_SENDWININICHANGE := 2
	
	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(binaryLocaleID, 4, 0)
	NumPut(LocaleID, binaryLocaleID)
	DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &binaryLocaleID, "UInt", SPIF_SENDWININICHANGE)
	
	WinGet, windows, List
	Loop % windows {
		PostMessage 0x50, 0, % Lan, , % "ahk_id " windows%A_Index%
	}
	initialCapsLockState := GetKeyState("Capslock", "T") ; Getting caps lock state to reset it back. ; Added
	
	SwapToKana(initialCapsLockState)
}

; Swaps to kana automatically
SwapToKana(initialCapsLockState){
	; initialCapsLockState := GetKeyState("Capslock", "T") ; Getting caps lock state to reset it back. 
	Sleep, 200 ; Leave some time for the first change.
    sendinput {Ctrl down}{Capslock}{Ctrl up}
	SetCapsLockState, % initialCapsLockState
}

; Check if the keyboard is in EN or JP, then forces kana if in JP.
; From https://www.autohotkey.com/board/topic/43043-get-current-keyboard-layout/
SwapToKanaOnNewField(){
	initialCapsLockState := GetKeyState("Capslock", "T") ; Getting caps lock state to reset it back. ;Added
	SetFormat, Integer, H
	WinGet, WinID,, A
	ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
	InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
	;MsgBox, %InputLocaleID%
  
	if InputLocaleID=0x4110411
		SwapToKana(initialCapsLockState) 
}

; IME swapping binds to WIN & Space. Change this next line to rebind. Assumes only 2 keyboards are on your system.
#Space::
	State++
	M:=mod(State,2)
	if (M=1)
	{
	   SetDefaultKeyboard(0x0411) ; JP 0x0409
	   Return
	}
	else 
	{
	   SetDefaultKeyboard(0x0409) ; EN 0x0409
	   Return
	}

; Couldn't find a way to specifically check when clicking on a text field, so it check every time you left click.
; Should be fine since it's a fast operation buy yeah, really gross and inefficient
~LButton::
	SwapToKanaOnNewField()
	Return