
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

  openDitto() {
    x := (A_ScreenWidth // 2 - 200)
    y := (A_ScreenHeight // 2 - 200)
    mousemove, x, y
    Send, #!c
  }

; --|

; SHARED

  !Escape::
    Suspend
  return

  !+Escape::
    Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
    MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
    IfMsgBox, Yes, Edit
  return

; --|