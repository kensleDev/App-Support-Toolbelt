SendMode Input ; superior speed and reliability.
SetTitleMatchMode 2 ;allow partial match to window titles

; FUNCTIONS

  smoothPager(direction) {
    if(direction == "Up") {
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
      send, {Up}
    } else {
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
      send, {Down}
    }
  }

; --|

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

; Ditto Clipboard manager (Move to center and launch)
  CapsLock & c::
    x := (A_ScreenWidth // 2 - 200)
    y := (A_ScreenHeight // 2 - 200)
    mousemove, x, y
    Send, #!c
  Return
; --|

; General
  Capslock & Space::Escape
  Capslock & >::Delete
  Capslock & <::BackSpace

  CapsLock & h::Left
  CapsLock & j::Down
  CapsLock & k::Up
  CapsLock & l::Right

  Capslock & u::Home
  CapsLock & i::smoothPager("Up")
  Capslock & o::smoothPager("Down")
  CapsLock & p::End
; --|

