

; -------------------------> Init

  Menu, Tray, Icon, img/icon.png

  #Include, lib.ahk

  ; Configure Caps Lock
    #Persistent
    SetCapsLockState, AlwaysOff
    ; Caps Lock Disable
    capslock::Escape
    ; Caps Lock with shift+caps


    +Capslock::
      If GetKeyState("CapsLock", "T") = 1
          SetCapsLockState, AlwaysOff
      Else
          SetCapsLockState, AlwaysOn
    Return
  ; --|

; --|

; -------------------------> Imports

  #Include, banks/search.ahk

  ; #Include, banks/apps.ahk

  ; #Include, banks/utils.ahk

  ; #Include, banks/folders.ahk

  ; #Include, banks/bookmarks.ahk

; --|


; -------------------------> Hotkeys

  ; Utilities
  CapsLock & z::Send, ^z
  CapsLock & x::Send, ^x
  CapsLock & c::Send, ^c
  CapsLock & v::Send, ^v
  CapsLock & s::Send, ^s
  CapsLock & a::Send, ^a
  CapsLock & d::Delete
  CapsLock & b::activateSearchMenu()
  Capslock & Tab::Click
  Capslock & q::Enter
  ; CapsLock & l::Send, ^l

  ; Navigation
  CapsLock & h::Left
  CapsLock & j::Down
  CapsLock & k::Up
  CapsLock & l::Right

  Capslock & y::Home
  CapsLock & o::End
  CapsLock & u::PgDn
  CapsLock & i::PgUp

  ; instant alt tab
  CapsLock & e::Send,{Alt Down}{Esc}{Alt Up}
  CapsLock & w::Send,{Alt Down}{Shift Down}{Esc}{Alt Up}{Shift Up}

  ; Wox
  CapsLock & p::Send,{Alt Down}{Space}{Alt Up}

  CapsLock & 1::Send, F1
  CapsLock & 2::Send, F2
  CapsLock & 3::Send, F3
  CapsLock & 4::Send, F4
  CapsLock & 5::Send, F5
  CapsLock & 6::Send, F6
  CapsLock & 7::Send, F7
  CapsLock & 8::Send, F8
  CapsLock & 9::Send, F9
  CapsLock & 0::Send, F10
  CapsLock & -::Send, F11
  CapsLock & =::Send, F12


  ; --|

  ; Left hand numpad (Needs to be at the bottom)
    NumpadToggle := false
    CapsLock & BackSpace:: NumpadToggle := !NumpadToggle
    #If (NumpadToggle) ; if this variable has the value "true"
      space::Numpad0
      x::Numpad1
      c::Numpad2
      v::Numpad3
      s::Numpad4
      d::Numpad5
      f::Numpad6
      w::Numpad7
      e::Numpad8
      r::Numpad9

      =::+
      ]::*
      [::/
    return

  ; --|


;--\ 



; moveMouseForWindowSwap() {

;   WinGet, Program, ProcessName, A
;   SplitPath, Program,,,, OutNameNoExt
;   StringLower, CleanProgramName, OutNameNoExt

;   if (CleanProgramName = "explorer") {
;     moveToFileExplorerSpot()
;   } else if (CleanProgramName = "chrome") {
;     moveToFileExplorerSpot()
;   } else if (CleanProgramName = "code") {
;     moveToFileExplorerSpot()
;   } else {
;     MouseMove, 0, 0
;   }

; }

; moveToFileExplorerSpot() {
;   MoveMouseX = 250
;   MoveMouseY = 140
;   MouseMove, %MoveMouseX%, %MoveMouseY%
; }

; CapsLock & 1::switchDesktopByNumber(1)
; CapsLock & 2::switchDesktopByNumber(2)
; CapsLock & 3::switchDesktopByNumber(3)
; CapsLock & 4::switchDesktopByNumber(4)
; CapsLock & 5::switchDesktopByNumber(5)

; Need Work
; CapsLock & c::openDitto()
; capslock & w::moveToFileExplorerSpot()
; CapsLock & n::openWindowsNotification()
; CapsLock & v::activateSearchMenu()
; CapsLock & d::activateAppsMenu()