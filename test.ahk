FILENAME := "/Settings.ini"
SETTINGS = %A_WorkingDir%%FILENAME%

; ---> Init

  ; ---> READ IN SETTINGS

    SETTING := {}
    MENUS := {}

    SETTING.HK1 := IniReader("Hotkeys", "1")
    SETTING.HK2 := IniReader("Hotkeys", "2")
    SETTING.HK3 := IniReader("Hotkeys", "3")
    SETTING.HK4 := IniReader("Hotkeys", "4")
    SETTING.HK5 := IniReader("Hotkeys", "5")
    SETTING.HK6 := IniReader("Hotkeys", "6")

    SETTING.BM1 := IniReader("Bookmarks", "1")
    SETTING.BM2 := IniReader("Bookmarks", "2")
    SETTING.BM3 := IniReader("Bookmarks", "3")
    SETTING.BM4 := IniReader("Bookmarks", "4")
    SETTING.BM5 := IniReader("Bookmarks", "5")
    SETTING.BM6 := IniReader("Bookmarks", "6")

    SETTING.APP1 := IniReader("App", "1")
    SETTING.APP2 := IniReader("App", "2")
    SETTING.APP3 := IniReader("App", "3")
    SETTING.APP4 := IniReader("App", "4")
    SETTING.APP5 := IniReader("App", "5")
    SETTING.APP6 := IniReader("App", "6")

    SETTING.FOLDER1 := IniReader("Folder", "1")
    SETTING.FOLDER2 := IniReader("Folder", "2")
    SETTING.FOLDER3 := IniReader("Folder", "3")
    SETTING.FOLDER4 := IniReader("Folder", "4")
    SETTING.FOLDER5 := IniReader("Folder", "5")
    SETTING.FOLDER6 := IniReader("Folder", "6")

    MENUS.BM_1 := IniReader("BMMenu", "1")
    MENUS.BM_2 := IniReader("BMMenu", "2")
    MENUS.BM_3 := IniReader("BMMenu", "3")
    MENUS.BM_4 := IniReader("BMMenu", "4")
    MENUS.BM_5 := IniReader("BMMenu", "5")
    MENUS.BM_6 := IniReader("BMMenu", "6")

    MENUS.BM := assembleMenu([MENUS.BM_1, MENUS.BM_2, MENUS.BM_3, MENUS.BM_4, MENUS.BM_5, MENUS.BM_6])

    MENUS.APP_1 := IniReader("APPMenu", "1")
    MENUS.APP_2 := IniReader("APPMenu", "2")
    MENUS.APP_3 := IniReader("APPMenu", "3")
    MENUS.APP_4 := IniReader("APPMenu", "4")
    MENUS.APP_5 := IniReader("APPMenu", "5")
    MENUS.APP_6 := IniReader("APPMenu", "6")

    MENUS.APP := assembleMenu([MENUS.APP_1, MENUS.APP_2, MENUS.APP_3, MENUS.APP_4, MENUS.APP_5, MENUS.APP_6])

    MENUS.FOLDER_1 := IniReader("FOLDERMenu", "1")
    MENUS.FOLDER_2 := IniReader("FOLDERMenu", "2")
    MENUS.FOLDER_3 := IniReader("FOLDERMenu", "3")
    MENUS.FOLDER_4 := IniReader("FOLDERMenu", "4")
    MENUS.FOLDER_5 := IniReader("FOLDERMenu", "5")
    MENUS.FOLDER_6 := IniReader("FOLDERMenu", "6")

    MENUS.FOLDER := assembleMenu([MENUS.FOLDER_1, MENUS.FOLDER_2, MENUS.FOLDER_3, MENUS.FOLDER_4, MENUS.FOLDER_5, MENUS.FOLDER_6])

  ; ---|

  ; Keyboard Detection

    FileReadLine, keyboardType, C:\Dev\os.txt, 1
    If (%keyboardType% = mac)
      ; MsgBox, %keyboardType%
      ; --> Swap Alt & Win
        ; ;Special remap for LWin & Tab to AltTab |
        ; LWin & Tab::AltTab
        ; ;All other LWin presses will be LAlt
        ; LWin::LAlt
        ; ; Makes the Alt key send a Windows key
        ; LAlt::RWin
      ; --|

      ; --> Media Buttons

        ;next song
        F15::Send {Media_Next}
        return

        ;previous song
        F14::Send {Media_Prev}
        return

        ;play/pause
        F13::Send {Media_Play_Pause}
        return

      ; --|
    ; Else
      ; --> Media Buttons
        ; Ctrl + Numpad1::Send {Media_Play_Pause}
        ; return

        ; Ctrl + Numpad2::Send {Media_Prev}
        ; return

        ; Ctrl + Numpad3::Send {Media_Next}
        ; return
      ; --|
    Return
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

; --|


; ---> Utils
  IniReader(key, value) {
    Global SETTINGS
    IniRead, OUTPUT, %SETTINGS%, %key%, %value%
    Return, %OUTPUT%
  }

  assembleMenu(menu) {
    Global SETTING
    Space := " "
    NL := "`n"

    HK1 := assbleMenuItem(SETTING.HK1)
    HK2 := assbleMenuItem(SETTING.HK2)
    HK3 := assbleMenuItem(SETTING.HK3)
    HK4 := assbleMenuItem(SETTING.HK4)
    HK5 := assbleMenuItem(SETTING.HK5)
    HK6 := assbleMenuItem(SETTING.HK6)

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

      MsgBox % SEARCH_URL

      If (searchTerm != "") {
        openURL(SEARCH_URL)
      }

      ; if (newTab = "true") {
      ;   SEARCH_URL = Clipboard
      ;   Send, {Alt down}3{Alt up}
      ;   Click, 1835, 1000 Left, Down
      ;   Send, {Control down}l{Control up}
      ;   Send, {Control down}v{Control up}
      ;   Send, {Enter}
      ; } else {
      ;   If (searchTerm != "") {
      ;     openURL(SEARCH_URL)
      ;   }
      ; }
    }
  }

  openURL(url) {
    Run, %url%
    Sleep, 1000
    WinMaximize, A
  }

; --|


; -------------------------> Banks

  ; ---> Search

    searchInputBank() {
      THE_MENU=--Input--`n(a)-Google`n(s)-StackOverFlow`n(d)-Twitter`n(z)-Youtube`n(x)-Reddit`n
      ToolTip, %THE_MENU%

      Input Key, L1
        ToolTip,
        If Key=a
          querySearch("Google", "input", "http://www.google.com/search?q=")
        Else If Key=s
          querySearch("Stack Overflow", "input", "https://stackoverflow.com/search?q=")
        Else If Key=d
          querySearch("Twitter", "input", "https://twitter.com/search?q=")
        Else If Key=z
          querySearch("YouTube", "input", "https://www.youtube.com/search?q=")
        Else If Key=x
          querySearch("Reddit", "input", "https://www.reddit.com/search?q=")
        Else If Key=c
          ; querySearch("Comm Requests", "input", "http://it32:8081/api/DCS/REQUESTS/")
      Return

    }

    searchClipBank() {
      THE_MENU=--Clipboard--`n(a)-Google`n(s)-StackOverFlow`n(d)-Twitter`n(z)-Youtube`n(x)-Reddit
      ToolTip, %THE_MENU%

      Input Key, L1
        ToolTip,
        If Key=a
          querySearch("Google", "clipboard", "http://www.google.com/search?q=")
        Else If Key=s
          querySearch("Stack Overflow", "clipboard", "https://stackoverflow.com/search?q=")
        Else If Key=d
          querySearch("Twitter", "clipboard", "https://twitter.com/search?q=")
        Else If Key=z
          querySearch("YouTube", "clipboard", "https://www.youtube.com/search?q=")
        Else If Key=x
          querySearch("Reddit", "clipboard", "https://www.reddit.com/search?q=")
        Else If Key=c
          ; querySearch("CommRequests", "clipboard", "http://it32:8081/api/DCS/REQUESTS/")
      Return

    }

    s_Search:
      searchInputBank()
    Return

    l_Search:
      searchInputBank()
    Return

    d_Search:
      Send, ^c
      searchClipBank()
    Return

  ; --|

; --|



; -------------------------> Hotkeys

  ; Search
    CapsLock & s::
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

; --|