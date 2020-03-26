
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

path=E:\Dev\repos\Windows-Helper\settings.ini

; cmd(Caps, Caps with Shift, Caps with Alt  )
; top row 

Capslock & Tab::cmd("{Click}", "", "")

Capslock & q::cmd("{Enter}", "#{Up}", "")
CapsLock & w::cmd("!+{Escape}", "#{Left}", "")
CapsLock & e::cmd("!{Escape}", "#{Right}", "")

Capslock & y::cmd("{Home}", "+{Home}", "!{Home}")
CapsLock & o::cmd("{End}", "+{End}", "!{Home}")
CapsLock & u::cmd("{PgDn}", "+{PgDn}", "!{Home}")
CapsLock & i::cmd("{PgUp}", "+{PgUp}", "!{Home}")

CapsLock & p::cmd("!{Space}", "", "")
CapsLock & [::cmd("!^'", "", "")
CapsLock & #::cmd("|", "", "")

; second row 

CapsLock & a::cmd("^a", "^+a", "")
CapsLock & s::cmd("^s", "^+s", "")
CapsLock & d::cmd("{Delete}", "+{Delete}", "")
CapsLock & f::cmd("{Backspace}", "+{Backspace}", "")

CapsLock & h::cmd("{Left}", "+{Left}", "!{Left}")
CapsLock & j::cmd("{Down}", "+{Down}", "!{Down}")
CapsLock & k::cmd("{Up}", "+{Up}", "!{Up}")
CapsLock & l::cmd("{Right}", "+{Right}", "!{Right}")

CapsLock & '::cmd("``", "", "")

; third row 
CapsLock & z::cmd("^z", "^+z", "")
CapsLock & x::cmd("^x", "^+x", "")
CapsLock & c::cmd("^c", "^+c", "")
CapsLock & v::cmd("^v", "^+v", "")

CapsLock & .::cmd("!{F4}", "", "")
CapsLock & ?::cmd("\", "", "")

; bottom row
Appskey::Media_Play_Pause 

; Num Keys
CapsLock & 1::cmd("{F1}", "+{F1}", "!{F1}")
CapsLock & 2::cmd("{F2}", "+{F2}", "!{F2}")
CapsLock & 3::cmd("{F3}", "+{F3}", "!{F3}")
CapsLock & 4::cmd("{F4}", "+{F4}", "!{F4}")
CapsLock & 5::cmd("{F5}", "+{F5}", "!{F5}")
CapsLock & 6::cmd("{F6}", "+{F6}", "!{F6}")
CapsLock & 7::cmd("{F7}", "+{F7}", "!{F7}")
CapsLock & 8::cmd("{F8}", "+{F8}", "!{F8}")
CapsLock & 9::cmd("{F9}", "+{F9}", "!{F9}")
CapsLock & 0::cmd("{F10}", "+{F10}", "!{F10}")
CapsLock & -::cmd("{F11}", "+{F11}", "!{F11}")
CapsLock & =::cmd("{F12}", "+{F12}", "!{F12}")
; --|

