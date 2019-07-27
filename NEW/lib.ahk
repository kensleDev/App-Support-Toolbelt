
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

  ; Search Menu
  #Include, src/search.ahk

  searchMenu() {
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
  }

  ; --|

; ---> SHARED

  !Escape::
    Suspend
  return

  !+Escape::
    Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
    MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
    IfMsgBox, Yes, Edit
  return

  IniReader(key, value) {
    Global SETTINGS
    IniRead, OUTPUT, %SETTINGS%, %key%, %value%
    Return, %OUTPUT%
  }


; --|


; ---> Menus

  assembleMenu(menu) {
    Global SETTING
    Space := " "
    NL := "`n"

    HK1 := assbleMenuItem(IniReader("Hotkeys", "1"))
    HK2 := assbleMenuItem(IniReader("Hotkeys", "2"))
    HK3 := assbleMenuItem(IniReader("Hotkeys", "3"))
    HK4 := assbleMenuItem(IniReader("Hotkeys", "4"))
    HK5 := assbleMenuItem(IniReader("Hotkeys", "5"))
    HK6 := assbleMenuItem(IniReader("Hotkeys", "6"))

    THE_MENU := HK1 Space menu.1  NL HK2 Space menu.2 NL HK3 Space menu.3 NL HK4 Space menu.4 NL HK5 Space menu.5 NL HK6 Space menu.6
    Return, % THE_MENU
  }

  assbleMenuItem(item) {
    O := "("
    C := ") - "

    Return, O item C
  }

; --|


; ---> Web

  querySearch(title, type, url) {

    If (type = "input") {
      openBookmark(url, "true", "input")
    }

    If (type = "clipboard") {
      openBookmark(url, "true", "clipboard")
    }

  }

  openBookmark(url, newTab, input) {
    if (input = "clipboard") {

      ClipBoard = %ClipBoard%
      SEARCH_URL = %url%%ClipBoard%

      If (searchTerm != "") {
        openURL(SEARCH_URL)
      }

    } else {
      InputBox, searchTerm , %title%, "Search", NOPE, Width, 100
      SEARCH_URL = %url%%searchTerm%

      If (searchTerm != "") {
        openURL(SEARCH_URL)
      }

    }

  }

  openURL(url) {
    Run, %url%
    Sleep, 1000
    WinMaximize, A
  }

; --|