  FILENAME := "/Settings.ini"
  SETTINGS = %A_WorkingDir%%FILENAME%

  ; ---> General

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

    IniReader(key, value) {
      Global SETTINGS
      IniRead, OUTPUT, %SETTINGS%, %key%, %value%
      Return, %OUTPUT%
    }

    ; Empty trash
      #Del::FileRecycleEmpty ; win + del
      return
    ; --|

    ; ; Always on Top
    ;   ^SPACE:: Winset, Alwaysontop, , A ; ctrl + space
    ;   Return
    ; ; --|

    ; Press middle mouse button to move up a folder in Explorer
      #IfWinActive, ahk_class CabinetWClass
      ~MButton::Send !{Up}
      #IfWinActive
      return
    ; --|

  ; --|

  ; ---> Web
    querySearch(title, type, url) {

      If (type = "input") {
        openBookmark(url, "true", "input")
        ; InputBox, searchTerm , %title%, "Search", NOPE, Width, 100
        ; SEARCH_URL = %url%%searchTerm%

        ; If (searchTerm != "") {
        ;   openURL(SEARCH_URL)
        ;   Return
        ; }
      }

      If (type = "clipboard") {
        openBookmark(url, "true", "clipboard")
        ; ClipBoard = %ClipBoard%
        ; SEARCH_URL = %url%%ClipBoard%

        ; openBookmark(%SEARCH_URL%, %newTab%)

        ; if (newTab = "true") {
        ;   openBookmark(%SEARCH_URL%, "false")
        ; } else {
        ;   Run, %SEARCH_URL%
        ;   Sleep, 1000
        ;   WinMaximize, A
        ; }


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
