

; -------------------------> Init

  Menu, Tray, Icon, img/icon.png

  #Include, lib.ahk

  ; Configure Caps Lock
    #Persistent
    SetCapsLockState, AlwaysOff
    ; Caps Lock Disable
    capslock::return
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

  #Include, banks/apps.ahk

  #Include, banks/utils.ahk

  ; #Include, banks/folders.ahk

  ; #Include, banks/bookmarks.ahk


; --|


; -------------------------> Hotkeys

  ; Navigation

  ; Need Work
  capslock & w::moveToFileExplorerSpot()
  Capslock & Tab::Click
  CapsLock & n::openWindowsNotification()

  ; General
  Capslock & space::Escape
  CapsLock & h::Left
  CapsLock & j::Down
  CapsLock & k::Up
  CapsLock & l::Right

  Capslock & y::Home
  CapsLock & o::End

  CapsLock & u::PgDn
  CapsLock & i::PgUp

  CapsLock & <::BackSpace
  CapsLock & >::Delete

  CapsLock & 1::switchDesktopByNumber(1)
  CapsLock & 2::switchDesktopByNumber(2)
  CapsLock & 3::switchDesktopByNumber(3)
  CapsLock & 4::switchDesktopByNumber(4)
  CapsLock & 5::switchDesktopByNumber(5)

  CapsLock & s::switchDesktopByNumber(CurrentDesktop + 1)
  CapsLock & a::switchDesktopByNumber(CurrentDesktop - 1)

  CapsLock & c::openDitto()
  CapsLock & v::activateSearchMenu()
  CapsLock & d::activateAppsMenu()
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


moveMouseForWindowSwap() {

  WinGet, Program, ProcessName, A
  SplitPath, Program,,,, OutNameNoExt
  StringLower, CleanProgramName, OutNameNoExt

  if (CleanProgramName = "explorer") {
    moveToFileExplorerSpot()
  } else if (CleanProgramName = "chrome") {
    moveToFileExplorerSpot()
  } else if (CleanProgramName = "code") {
    moveToFileExplorerSpot()
  } else {
    MouseMove, 0, 0
  }

}

moveToFileExplorerSpot() {
  MoveMouseX = 250
  MoveMouseY = 140
  MouseMove, %MoveMouseX%, %MoveMouseY%
}

; #IfWinActive ahk_class CabinetWClass ; Windows Explorer
;   #Space::
;       ControlFocus, DirectUIHWND3, A
;       SendInput, {Space}
;       return
; #IfWinActive

; Capslock & t::send, ^{Space}
; Smooth Page up and down
; CapsLock & i::smoothPager("Down")
; CapsLock & u::smoothPager("Up")
;^!c::createVirtualDesktop()
;^!d::deleteVirtualDesktop()
; CapsLock & b:: layoutWindows(1, true)
; CapsLock & g:: fifthsMenu(1)
