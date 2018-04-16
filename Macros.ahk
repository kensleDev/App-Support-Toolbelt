; -------------------------> Global

  SETTINGS := "D:\Dev\AHK\MacroTool\Settings.txt"

  ; ---> READ IN SETTINGS


    SETTING := {}
    MENUS := {}

    SETTING.HK1 := readAndFilter(6)
    SETTING.HK2 := readAndFilter(7)
    SETTING.HK3 := readAndFilter(8)
    SETTING.HK4 := readAndFilter(9)
    SETTING.HK5 := readAndFilter(10)
    SETTING.HK6 := readAndFilter(11)

    SETTING.BM1 := readAndFilter(16)
    SETTING.BM2 := readAndFilter(17)
    SETTING.BM3 := readAndFilter(18)
    SETTING.BM4 := readAndFilter(19)
    SETTING.BM5 := readAndFilter(20)
    SETTING.BM6 := readAndFilter(21)

    SETTING.APP1 := readAndFilter(26)
    SETTING.APP2 := readAndFilter(27)
    SETTING.APP3 := readAndFilter(28)
    SETTING.APP4 := readAndFilter(29)
    SETTING.APP5 := readAndFilter(30)
    SETTING.APP6 := readAndFilter(31)

    SETTING.FOLDER1 := readAndFilter(36)
    SETTING.FOLDER2 := readAndFilter(37)
    SETTING.FOLDER3 := readAndFilter(38)
    SETTING.FOLDER4 := readAndFilter(39)
    SETTING.FOLDER5 := readAndFilter(40)
    SETTING.FOLDER6 := readAndFilter(41)

    SETTING.BM_MENU := readAndFilter(46)
    SETTING.APP_MENU := readAndFilter(47)
    SETTING.FOLDER_MENU := readAndFilter(48)

    MENUS.BM := menuSplitter(SETTING.BM_MENU)
    MENUS.APP := menuSplitter(SETTING.APP_MENU)
    MENUS.FOLDER := menuSplitter(SETTING.FOLDER_MENU)

    MENUS.BM := assembleMenu(MENUS.BM)
    MENUS.APP := assembleMenu(MENUS.APP)
    MENUS.FOLDER := assembleMenu(MENUS.FOLDER)


  ; --|

  ; ---> Init

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

    ; Empty trash
      #Del::FileRecycleEmpty ; win + del
      return
    ; --|

    ; Always on Top
      ^SPACE:: Winset, Alwaysontop, , A ; ctrl + space
      Return
    ; --|

    ; Press middle mouse button to move up a folder in Explorer
      #IfWinActive, ahk_class CabinetWClass
      ~MButton::Send !{Up}
      #IfWinActive
      return
    ; --|

  ; --|

  ; ---> General
    CenterImgSrchCoords(File, ByRef CoordX, ByRef CoordY) {
      static LoadedPic
      LastEL := ErrorLevel
      Gui, Pict:Add, Pic, vLoadedPic, %File%
      GuiControlGet, LoadedPic, Pict:Pos
      Gui, Pict:Destroy
      CoordX += LoadedPicW // 2
      CoordY += LoadedPicH // 2
      ErrorLevel := LastEL
    }

    CloseToolTip() {
      ToolTip,
    }

    sendModComboDown(key) {
      Send {Blind}{LControl DownTemp}
      Send {Blind}{LAlt DownTemp}
      Send {Blind}{LShift DownTemp}
      Send {Blind}{%key% DownTemp}
    }

    sendModComboUp(key) {
      Send {Blind}{LControl Up}
      Send {Blind}{LAlt Up}
      Send {Blind}{LShift Up}
      Send {Blind}{%key% Up}
    }


    GroupAdd, BrowserGroup, ahk_class Chrome_WidgetWin_1
    GroupAdd, BrowserGroup, ahk_class MozillaWindowClass
    GroupAdd, BrowserGroup, ahk_class ApplicationFrameWindow
    GroupAdd, BrowserGroup, ahk_class IEFrame
  ; --|

  ; ---> Web
    querySearch(title, type, url ) {

      If (type = "input") {
        InputBox, searchTerm , %title%, "Search", NOPE, Width, 100
        SEARCH_URL = %url%%searchTerm%

        If (searchTerm != "") {
          openURL(SEARCH_URL)
          Return
        }
      }

      If (type = "clipboard") {
        ClipBoard = %ClipBoard%

        SEARCH_URL = %url%%ClipBoard%
        Run, %SEARCH_URL%
        Sleep, 1000
        WinMaximize, A
      }

    }

    openURL(url) {
      Run, %url%
      Sleep, 1000
      WinMaximize, A
      Return
    }

    serviceNowMouseMove() {
      WinWaitActive, SN[L] - Google Chrome
      Click, 1397, 131 Left, 1
      Click, 400, 702, 0
    }
  ; --|

  ; ---> Programs
    RunOrActivate(Target, WinTitle = "", Parameters = "") {
      ; Get the filename without a path
      SplitPath, Target, TargetNameOnly
      SetTitleMatchMode, 2

      IfWinActive, %WinTitle%
      {
        Run %Target%
        Return
      }

      Process, Exist, %TargetNameOnly%
      If ErrorLevel > 0
        PID = %ErrorLevel%
      Else
        Run, %Target% "%Parameters%", , , PID

      ; At least one app (Seapine TestTrack wouldn't always become the active
      ; window after using Run), so we always force a window activate.
      ; Activate by title if given, otherwise use PID.
      If WinTitle <>
      {
        WinWait, %WinTitle%, , 3
        ;TrayTip, , Activating Window Title "%WinTitle%" (%TargetNameOnly%)
        WinActivate, %WinTitle%
      }
      Else
      {
        WinWait, ahk_pid %PID%, , 3
        ;TrayTip, , Activating PID %PID% (%TargetNameOnly%)
        WinActivate, ahk_pid %PID%
      }
      ;SetTimer, RunOrActivateTrayTipOff, 1
    }
  ; --|

  ; ---> Menus
    menuSplitter(menu) {
      ARRAY := StrSplit(menu , ",")
      Return, Array
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

  ; ---> File Ops
    regexer(bank, haystack) {

      If (bank = "Settings")
        RegExMatch(haystack, "(?<=_)[a-zA-Z0-9].*" , output)
      Else If (bank = "none")
        output := haystack
      Return, %output%
    }

    lineReader(lineNum) {
      Global SETTINGS
      FileReadLine, output, %SETTINGS%, %lineNum%
      Return, %output%

    }

    readAndFilter(lineNum) {
      bank := "Settings"
      line := lineReader(lineNum)
      line := regexer(bank, line)
      Return, line
    }

    IniReader(key, value) {
      Global SETTINGS
      IniRead, OUTPUT, %SETTINGS%, %key%, %value%
      Return, %OUTPUT%
    }
  ; --|


; --|

; -------------------------> Banks

  ; ---> Service Now
    s_ServiceNow:
      querySearch("ServiceNow", "input", "https://stepchangeprod.service-now.com/nav_to.do?uri=%2Ftextsearch.do%3Fsysparm_search%3D")
    Return

    l_ServiceNow:
      querySearch("ServiceNow", "input", "https://stepchangeprod.service-now.com/nav_to.do?uri=%2Ftextsearch.do%3Fsysparm_search%3D")
    Return

    d_ServiceNow:
      Send, ^c
      querySearch("ServiceNow", "clipboard", "https://stepchangeprod.service-now.com/nav_to.do?uri=%2Ftextsearch.do%3Fsysparm_search%3D")
      serviceNowMouseMove()
    Return
  ; --|

  ; ---> Search

    searchInputBank() {
      THE_MENU=--Input--`n(a)-Google`n(s)-StackOverFlow`n(d)-Twitter`n(z)-Youtube`n(x)-Reddit`n
      ToolTip, %THE_MENU%

      Input Key, L1
        CloseToolTip()
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
        CloseToolTip()
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

  ; ---> Launch Apps


    appBank() {

      Global SETTINGS
      Global MENUS

      app1 := SETTING.APP1
      app2 := SETTING.APP2
      app3 := SETTING.APP3
      app4 := SETTING.APP4
      app5 := SETTING.APP5
      app6 := SETTING.APP6

      ToolTip % MENUS.APP

      Input Key, L1
        CloseToolTip()
        if Key=a
          RunOrActivate(%app1%, "Visual Studio Code", "")
        Else If Key=s
          RunOrActivate(%app2%, "Chrome", "")
        Else If Key=d
          RunOrActivate(%app3%, "Cmder", "")
        Else If Key=z
          RunOrActivate(%app4%, "Not Assigned", "")
        Else If Key=x
          RunOrActivate(%app5%, "Not Assigned", "")
        Else If Key=c
          RunOrActivate(%app6%, "Not Assigned", "")
      Return
    }

    s_LaunchApp:
      appBank()
    Return

    l_LaunchApp:
      appBank()
    Return

    d_LaunchApp:
      appBank()
    Return

  ; --|

  ; ---> Launch Folders

    folderBank() {

      Global SETTING
      Global MENUS

      folder1 := SETTING.FOLDER1
      folder2 := SETTING.FOLDER2
      folder3 := SETTING.FOLDER3
      folder4 := SETTING.FOLDER4
      folder5 := SETTING.FOLDER5
      folder6 := SETTING.FOLDER6

      ToolTip % MENUS.FOLDER

      Input Key, L1
        CloseToolTip()
        if Key=a
          Run %folder1%
        Else If Key=s
          Run %folder2%
        Else If Key=d
          Run %folder3%
        Else If Key=z
          Run %folder4%
        Else If Key=x
          Run %folder5%
        Else If Key=c
          Run %folder6%
      Return
    }

    s_LaunchFolder:
      folderBank()
    Return

    l_LaunchFolder:
      folderBank()
    Return

    d_LaunchFolder:
      folderBank()
    Return

  ; --|

  ; ---> Launch Bookmarks

    bookmarkBank() {

      Global SETTING
      Global MENUS

      link1 := SETTING.BM1
      link2 := SETTING.BM2
      link3 := SETTING.BM3
      link4 := SETTING.BM4
      link5 := SETTING.BM5
      link6 := SETTING.BM6

      ToolTip % MENUS.BM

      Input Key, L1
        CloseToolTip()
        if Key=a
          link1 := openURL(link1)
        Else If Key=s
          link2 := openURL(link2)
        Else If Key=d
          link3 := openURL(link3)
        Else If Key=z
          link4 := openURL(link4)
        Else If Key=x
          link5 := openURL(link5)
        Else If Key=c
          link6 := openURL(link6)
      Return
    }

    s_BookmarkLauncher:
      bookmarkBank()
    Return

    l_BookmarkLauncher:
      bookmarkBank()
    Return

    d_BookmarkLauncher:
      bookmarkBank()
    Return
  ; --|

  ; ---> Launch Utils
    UtilLauncherClipX:
      sendModComboDown("x")
      sendModComboUp("x")
    Return

    UtilLauncherLintalist:
      sendModComboDown("z")
      sendModComboUp("z")
    Return
  ; --|

; --|

; -------------------------> Hotkeys

  ; Service Now
    CapsLock & q::

      key=q
      shortLabel=s_ServiceNow
      longLabel=l_ServiceNow
      doubleLabel=d_ServiceNow

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

  ; Launch Apps
    CapsLock & a::

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

  ; Launch Folders
    CapsLock & e::

      key=e
      shortLabel=s_LaunchFolder
      longLabel=l_LaunchFolder
      doubleLabel=d_LaunchFolder

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

  ; Launch Bookmarks
    CapsLock & w::

      key=w
      shortLabel=s_BookmarkLauncher
      longLabel=s_BookmarkLauncher
      doubleLabel=s_BookmarkLauncher

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

  ; Launch Utils
    CapsLock & x::

      key=x
      shortLabel=UtilLauncherClipX
      longLabel=UtilLauncherClipX
      doubleLabel=UtilLauncherClipX

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

    CapsLock & z::

      key=z
      shortLabel=UtilLauncherLintalist
      longLabel=UtilLauncherLintalist
      doubleLabel=UtilLauncherLintalist

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

