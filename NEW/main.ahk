SendMode Input ; superior speed and reliability.
SetTitleMatchMode 2 ;allow partial match to window titles
Menu, Tray, Icon, img/icon.png

#Include, lib.ahk

; Configure Caps Lock REQUIRES ADMIN
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


; -> Hotkeys

  ; Navigation

    Capslock & Space::Escape
    Capslock & >::Delete
    Capslock & <::BackSpace

    CapsLock & h::Left
    CapsLock & j::Down
    CapsLock & k::Up
    CapsLock & l::Right

    Capslock & y::Home
    CapsLock & u::smoothPager("Up")
    Capslock & i::smoothPager("Down")
    CapsLock & o::End

  ;---|

  ; Menus
    CapsLock & Tab:: showHotkeyMenu()
    CapsLock & Tab up:: hideHotkeyMenu()
    CapsLock & f::searchMenu()
  ;

  ; Apps

    CapsLock & c:: openDitto()

    ; Rearrange taskbar apps
    CapsLock & q::taskbarApp(1)
    CapsLock & w::taskbarApp(2)
    CapsLock & e::taskbarApp(3)
    CapsLock & r::taskbarApp(4)
    CapsLock & t::taskbarApp(5)

  ;---|

  ; Remaps

    CapsLock & /::sendKey(backslash)
    CapsLock & `;::sendKey(backtick)
    CapsLock & '::sendKey(pipe)

  ;---|

; -<>-|




; --|




