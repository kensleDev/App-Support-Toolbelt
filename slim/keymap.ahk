cmd(cmd, shiftCmd, altCmd) {

  if GetKeyState("Shift", cmd) {
    Send % shiftCmd 
  } else If (GetKeyState("Alt", cmd)) {
    Send % altCmd
  } else {
    Send % cmd  
  }
}


; Caps modifier / Escape 
#Persistent
SetCapsLockState, AlwaysOff
capslock::Escape

; Symbols 
CapsLock & ?::cmd("\",  "", "")
CapsLock & #::cmd("|",  "", "")
CapsLock & '::cmd("``", "", "")

; Utilities
CapsLock & z::cmd("^z",         "^+z",                            "")
CapsLock & x::cmd("^x",         "^+x",                            "")
CapsLock & c::cmd("^c",         "^+c",                            "")
CapsLock & v::cmd("^v",         "^+v",                            "")
CapsLock & s::cmd("^s",         "^+s",                            "")
CapsLock & a::cmd("^a",         "^+a",                            "")
CapsLock & d::cmd("{Delete}",   "{Shift Down}{Delete}{Shift Up}", "")
Capslock & Tab::cmd("{Click}",  "",                               "")
Capslock & q::cmd("{Enter}",    "",                               "")

; Navigation
CapsLock & h::cmd("{Left}",   "{Shift Down}{Left} {Shift Up}",  "")
CapsLock & j::cmd("{Down}",   "{Shift Down}{Down} {Shift Up}",  "")
CapsLock & k::cmd("{Up}",     "{Shift Down}{Up}   {Shift Up}",  "")
CapsLock & l::cmd("{Right}",  "{Shift Down}{Right}{Shift Up}",  "")

Capslock & y::cmd("{Home}", "{Shift Down}{Home}{Shift Up}", "")
CapsLock & o::cmd("{End}",  "{Shift Down}{End}{Shift Up}",  "")
CapsLock & u::cmd("{PgDn}", "{Shift Down}{PgDn}{Shift Up}", "")
CapsLock & i::cmd("{PgUp}", "{Shift Down}{PgUp}{Shift Up}", "")

; instant alt tab
CapsLock & e::cmd("{Alt Down}{Esc}{Alt Up}", "", "")
CapsLock & w::cmd("{Alt Down}{Shift Down}{Esc}{Alt Up}{Shift Up}", "", "")

; Applications
CapsLock & p::cmd("{LWin Down}{Ctrl Down}k{LWin Up}{Ctrl Up}", "", "")

; Num Keys
CapsLock & 1::cmd("{F1}",   "", "")
CapsLock & 2::cmd("{F2}",   "", "")
CapsLock & 3::cmd("{F3}",   "", "")
CapsLock & 4::cmd("{F4}",   "", "")
CapsLock & 5::cmd("{F5}",   "", "")
CapsLock & 6::cmd("{F6}",   "", "")
CapsLock & 7::cmd("{F7}",   "", "")
CapsLock & 8::cmd("{F8}",   "", "")
CapsLock & 9::cmd("{F9}",   "", "")
CapsLock & 0::cmd("{F10}",  "", "")
CapsLock & -::cmd("{F11}",  "", "")
CapsLock & =::cmd("{F12}",  "", "")
; --|

