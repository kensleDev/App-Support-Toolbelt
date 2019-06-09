
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

; -------------------------> Banks

  #Include, banks/search.ahk

  #Include, banks/apps.ahk

  #Include, banks/utils.ahk

  ; #Include, banks/folders.ahk

  ; #Include, banks/bookmarks.ahk


; --|


; -------------------------> Hotkeys

  ; Navigation

    ; Need Work
    Capslock & q::send, ^#k
    CapsLock & n::openWindowsNotification()

    ; General
    Capslock & space::Escape
    CapsLock & h::Left
    CapsLock & j::Down
    CapsLock & k::Up
    CapsLock & l::Right

    ; Smooth Page up and down
    CapsLock & x::smoothPager("Up")
    CapsLock & z::smoothPager("Down")

    CapsLock & 1::switchDesktopByNumber(1)
    CapsLock & 2::switchDesktopByNumber(2)
    CapsLock & 3::switchDesktopByNumber(3)
    CapsLock & 4::switchDesktopByNumber(4)
    CapsLock & 5::switchDesktopByNumber(5)

    CapsLock & s::switchDesktopByNumber(CurrentDesktop + 1)
    CapsLock & a::switchDesktopByNumber(CurrentDesktop - 1)
    ;^!c::createVirtualDesktop()
    ;^!d::deleteVirtualDesktop()


    CapsLock & b:: layoutWindows(1, true)
    CapsLock & g:: changeFifthsModeValue(1, 2)


  ; --|

  ; Custom

    ; Ditto Clipboard manager (Move to center and launch)
      CapsLock & c::
        x := (A_ScreenWidth // 2 - 200)
        y := (A_ScreenHeight // 2 - 200)
        mousemove, x, y
        Send, #!c
      Return
    ; --|

    ; Search Menu
      CapsLock & v::

        key=s
        shortLabel=s_Search
        longLabel=l_Search
        doubleLabel=d_Search

        KeyWait, %key%, T0.1

          If (ErrorLevel) {
            Gosub, %longLabel% ; Send long
            ; MsgBox, longg
          }
          Else {
            KeyWait, %key%, D T0.1
            if (ErrorLevel)
              Gosub, %shortLabel% ; Send single
              ; MsgBox, Single
            else
              Gosub, %doubleLabel% ; Send double
              ; MsgBox, double
          }
          KeyWait, %key%
      Return
    ; --|

    ; Launch Apps Menu
      CapsLock & d::

        key=a
        shortLabel=s_LaunchApp
        longLabel=l_LaunchApp
        doubleLabel=d_LaunchApp

        KeyWait, %key%, T0.1

          If (ErrorLevel) {
            Gosub, %longLabel% ; Send long
          }
          Else {
            KeyWait, %key%, D T0.1
            if (ErrorLevel)
              Gosub, %shortLabel% ; Send single
            else
              Gosub, %doubleLabel% ; Send double
          }
          KeyWait, %key%
      Return
    ; --|

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


