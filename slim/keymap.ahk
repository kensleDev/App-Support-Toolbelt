#Include, tooltip.ahk
ToolTipFont("s30", "consolas")
ToolTipColor("Black", "White")

; Configure Caps Lock
  #Persistent
  SetCapsLockState, AlwaysOff
  ; Caps Lock Disable
  capslock::Escape
  ; Caps Lock with shift+caps
  ; +Capslock::
  ;   If GetKeyState("CapsLock", "T") = 1
  ;       SetCapsLockState, AlwaysOff
  ;   Else
  ;       SetCapsLockState, AlwaysOn
  ; Return
      

; --|


cmd(cmd, shiftCmd, altCmd) {

  if GetKeyState("Shift", cmd) {
    Send % shiftCmd 
    displayCommand(shiftCmd)
  } else If (GetKeyState("Alt", cmd)) {
    Send % altCmd 
    displayCommand(altCmd)
  } else {
    Send % cmd  
    displayCommand(cmd)
  }

}

displayCommand(commandName) {
  tooltip, %commandName%, 0, 0
  Sleep, 500
  tooltip
}

; Symbols 
CapsLock & ?::cmd("\", "", "")
CapsLock & #::cmd("|", "", "")
CapsLock & '::cmd("``", "", "")

; Utilities
CapsLock & z::cmd("^z", "^+z", "")
CapsLock & x::cmd("^x", "^+x", "")
CapsLock & c::cmd("^c", "^+c", "")
CapsLock & v::cmd("^v", "^+v", "")
CapsLock & s::cmd("^s", "^+s", "")
CapsLock & a::cmd("^a", "^+a", "")
CapsLock & d::cmd("{Delete}", "", "")
Capslock & Tab::cmd("{Click}", "", "")
Capslock & q::cmd("{Enter}", "", "")


; Navigation
CapsLock & h::cmd("{Left}", "", "")
CapsLock & j::cmd("{Down}", "", "")
CapsLock & k::cmd("{Up}", "", "")
CapsLock & l::cmd("{Right}", "", "")

Capslock & y::cmd("{Home}", "", "")
CapsLock & o::cmd("{End}", "", "")
CapsLock & u::cmd("{PgDn}", "", "")
CapsLock & i::cmd("{PgUp}", "", "")

; instant alt tab
CapsLock & e::cmd("{Alt Down}{Esc}{Alt Up}", "", "")
CapsLock & w::cmd("{Alt Down}{Shift Down}{Esc}{Alt Up}{Shift Up}", "", "")

; Wox
CapsLock & p::cmd("{Alt Down}{Space}{Alt Up}", "", "")

; F Keys
CapsLock & 1::cmd("{F1}", "", "")
CapsLock & 2::cmd("{F2}", "", "")
CapsLock & 3::cmd("{F3}", "", "")
CapsLock & 4::cmd("{F4}", "", "")
CapsLock & 5::cmd("{F5}", "", "")
CapsLock & 6::cmd("{F6}", "", "")
CapsLock & 7::cmd("{F7}", "", "")
CapsLock & 8::cmd("{F8}", "", "")
CapsLock & 9::cmd("{F9}", "", "")
CapsLock & 0::cmd("{F10}", "", "")
CapsLock & -::cmd("{F11}", "", "")
CapsLock & =::cmd("{F12}", "", "")
; --|

; Left hand numpad (Needs to be at the bottom)
  NumpadToggle := false
  CapsLock & BackSpace:: 
    if(!NumpadToggle) 
      ToolTip, NUMPAD MODE, 0, 0
    Else 
      ToolTip
    
    NumpadToggle := !NumpadToggle
  return
  
  #If (NumpadToggle) ; if this variable has the value "true"
    space::Numpad0
    ,::Numpad1
    .::Numpad2
    /::Numpad3
    k::Numpad4
    l::Numpad5
    ;::Numpad6
    i::Numpad7
    o::Numpad8
    p::Numpad9

    =::+
    ]::*
    [::/
  return

; --|
