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
    RunOrActivate(WinTitle = "", Target = "", Parameters = "") {
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

  ; ---> Virtual Desktops - CREDIT NEEDED

    ; Globals
    DesktopCount = 2 ; Windows starts with 2 desktops at boot
    CurrentDesktop = 1 ; Desktop count is 1-indexed (Microsoft numbers them this way)
    ;
    ; This function examines the registry to build an accurate list of the current virtual desktops and which one we're currently on.
    ; Current desktop UUID appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops
    ; List of desktops appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops
    ;
    mapDesktopsFromRegistry() {
      global CurrentDesktop, DesktopCount
      ; Get the current desktop UUID. Length should be 32 always, but there's no guarantee this couldn't change in a later Windows release so we check.
      IdLength := 32
      SessionId := getSessionId()
      if (SessionId) {
        RegRead, CurrentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%SessionId%\VirtualDesktops, CurrentVirtualDesktop
        if (CurrentDesktopId) {
          IdLength := StrLen(CurrentDesktopId)
        }
      }
      ; Get a list of the UUIDs for all virtual desktops on the system
      RegRead, DesktopList, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
      if (DesktopList) {
        DesktopListLength := StrLen(DesktopList)
        ; Figure out how many virtual desktops there are
        DesktopCount := DesktopListLength / IdLength
      } else {
        DesktopCount := 1
      }
      ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
      i := 0
      while (CurrentDesktopId and i < DesktopCount) {
        StartPos := (i * IdLength) + 1
        DesktopIter := SubStr(DesktopList, StartPos, IdLength)
        OutputDebug, The iterator is pointing at %DesktopIter% and count is %i%.
        ; Break out if we find a match in the list. If we didn't find anything, keep the
        ; old guess and pray we're still correct :-D.
        if (DesktopIter = CurrentDesktopId) {
          CurrentDesktop := i + 1
          OutputDebug, Current desktop number is %CurrentDesktop% with an ID of %DesktopIter%.
          break
        }
        i++
      }
    }

    getSessionId() {
      ProcessId := DllCall("GetCurrentProcessId", "UInt")
      if ErrorLevel {
        OutputDebug, Error getting current process id: %ErrorLevel%
        return
      }
      OutputDebug, Current Process Id: %ProcessId%
      DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", SessionId)
      if ErrorLevel {
        OutputDebug, Error getting session id: %ErrorLevel%
        return
      }
      OutputDebug, Current Session Id: %SessionId%
      return SessionId
    }

    switchDesktopByNumber(targetDesktop) {
      global CurrentDesktop, DesktopCount
      ; Re-generate the list of desktops and where we fit in that. We do this because
      ; the user may have switched desktops via some other means than the script.
      mapDesktopsFromRegistry()
      ; Don't attempt to switch to an invalid desktop
      if (targetDesktop > DesktopCount || targetDesktop < 1) {
        OutputDebug, [invalid] target: %targetDesktop% current: %CurrentDesktop%
        return
      }
      ; Go right until we reach the desktop we want
      while(CurrentDesktop < targetDesktop) {
        Send ^#{Right}
        CurrentDesktop++
        OutputDebug, [right] target: %targetDesktop% current: %CurrentDesktop%
      }
      ; Go left until we reach the desktop we want
      while(CurrentDesktop > targetDesktop) {
        Send ^#{Left}
        CurrentDesktop--
        OutputDebug, [left] target: %targetDesktop% current: %CurrentDesktop%
      }
    }

    createVirtualDesktop() {
      global CurrentDesktop, DesktopCount
      Send, #^d
      DesktopCount++
      CurrentDesktop = %DesktopCount%
      OutputDebug, [create] desktops: %DesktopCount% current: %CurrentDesktop%
    }

    deleteVirtualDesktop() {
      global CurrentDesktop, DesktopCount
      Send, #^{F4}
      DesktopCount--
      CurrentDesktop--
      OutputDebug, [delete] desktops: %DesktopCount% current: %CurrentDesktop%
    }



    ; Main
    SetKeyDelay, 75
    mapDesktopsFromRegistry()
    OutputDebug, [loading] desktops: %DesktopCount% current: %CurrentDesktop%
  ; --|

  ; ---> Navigation

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

  ; ---> Window Layout



    writeMonitorWidths() {
      SysGet, mCount, MonitorCount


      Loop %mCount% {
        SysGet, BoundingCoordinates1, MonitorWorkArea, %A_Index%
        MonitorWidth := BoundingCoordinates1Right - BoundingCoordinates1Left
        MonitorHeight := BoundingCoordinates1Bottom - BoundingCoordinates1Top

        IniWrite, %MonitorWidth%,  %A_WorkingDir%/Settings.ini, monitor%A_Index%, Width
        IniWrite, %MonitorHeight%,  %A_WorkingDir%/Settings.ini, monitor%A_Index%, Height

        IniWrite, %mCount%,  %A_WorkingDir%/Settings.ini, layout, MonitorCount
      }
    }

    layoutMenu(monitor) {
      THE_MENU=--Layout Modes--`n(a)-Fifths
      ToolTip, %THE_MENU%

      Input Key, L1
        ToolTip
        If Key=a
          fifthsMenu(monitor)
      Return
    }

    monitorMenu() {
      THE_MENU=--Monitor--`n(a)-1`n(s)-2
      ToolTip, %THE_MENU%

      Input Key, L1
        ToolTip
        If Key=a
          fifthsMenu(1)
        Else If Key=a
          fifthsMenu(2)
      Return
    }

    moveIntoPosition(monitor) {

      IniRead, currentMode, %A_WorkingDir%/Settings.ini, layout, mode

      if (currentMode == "fifths") {

        IniRead, Height, %A_WorkingDir%/Settings.ini, monitor%monitor%, Height

        IniRead, App1Name, %A_WorkingDir%/Settings.ini, monitor%monitor%, AppName1
        IniRead, Win1Width, %A_WorkingDir%/Settings.ini, monitor%monitor%, Window1Width
        IniRead, Win1X, %A_WorkingDir%/Settings.ini, monitor%monitor%, Window1X

        IniRead, App2Name, %A_WorkingDir%/Settings.ini, monitor%monitor%, AppName2
        IniRead, Win2Width, %A_WorkingDir%/Settings.ini, monitor%monitor%, Window2Width
        IniRead, Win2X, %A_WorkingDir%/Settings.ini, monitor%monitor%, Window2X

        ; MsgBox, %App1Name%
        ; MsgBox, %App1Name%, %Win1Width%, %Win1X%

        ; MsgBox, %App2Name%, %Win2Width%, %Win2X%



        WinMove, ahk_exe %App1Name%, , %Win1X%, 0, %Win1Width%, %Height%
        WinMove, ahk_exe %App2Name%, , %Win2X%, 0, %Win2Width%, %Height%
      }

    }

    layoutWindows(monitor, prompt) {

      writeMonitorWidths()

      IniRead, currentMode, %A_WorkingDir%/Settings.ini, layout, mode
      IniRead, currentModeValue, %A_WorkingDir%/Settings.ini, layout, modeValue

      IniRead, MonitorWidth, %A_WorkingDir%/Settings.ini, monitor%monitor%, Width
      IniRead, MonitorHeight, %A_WorkingDir%/Settings.ini, monitor%monitor%, Height

      if (currentMode == "fifths") {
        WindowCount := 2

        Loop %WindowCount% {
          WinWidth := calcFifthWidth(MonitorWidth, currentModeValue, A_Index)
          IniWrite, %WinWidth%,  %A_WorkingDir%/Settings.ini, monitor%monitor%, Window%A_Index%Width

          if (prompt == true) {
            MsgBox, Click on window %A_Index%
            KeyWait, LButton, D
            WinGet, WinProcess, ProcessName, A
            IniWrite, %WinProcess%,  %A_WorkingDir%/Settings.ini, monitor%monitor%, AppName%A_Index%
          }

        }

        IniRead, Win2X, %A_WorkingDir%/Settings.ini, monitor%monitor%, Window1Width

        IniWrite, 0,  %A_WorkingDir%/Settings.ini, monitor%monitor%, Window1X
        IniWrite, %Win2X%,  %A_WorkingDir%/Settings.ini, monitor%monitor%, Window2X

        moveIntoPosition(monitor)

      } else {
        MsgBox, Errors
      }

    }

    ; fifths mode

    fifthsMenu(monitor) {
      THE_MENU=--Input--`n(a)-20-80`n(s)-40-60`n(d)-60-40`n(f)-80-20
      ToolTip, %THE_MENU%

      Input Key, L1
        ToolTip
        If Key=a
          changeFifthsModeValue(monitor, 1)
        Else If Key=s
          changeFifthsModeValue(monitor, 2)
        Else If Key=d
          changeFifthsModeValue(monitor, 3)
        Else If Key=f
          changeFifthsModeValue(monitor, 4)
      Return
    }

    changeFifthsModeValue(monitor, newModeValue) {

      IniWrite, %newModeValue%, %A_WorkingDir%/Settings.ini, layout, modeValue

      layoutWindows(monitor, false)

    }

    calcFifthWidth(MonitorWidth, modeValue, window) {

      Width := 0

      if (window == 1) {

        if (modeValue == 1) {
          Width := MonitorWidth / 5
        }

        if (modeValue == 2) {
          Width := MonitorWidth / 5 * 2
        }

        if (modeValue == 3) {
          Width := MonitorWidth / 5 * 3
        }

        if (modeValue == 4) {
          Width := MonitorWidth / 5 * 4
        }

      }

      if (window == 2) {

        if (modeValue == 1) {
          Width := MonitorWidth / 5 * 4
        }

        if (modeValue == 2) {
          Width := MonitorWidth / 5 * 3
        }

        if (modeValue == 3) {
          Width := MonitorWidth / 5 * 2
        }

        if (modeValue == 4) {
          Width := MonitorWidth / 5 * 1
        }

      }

      return Width

      ; Width := Width
      ; Win2Width := win2Width

    }




  ; --|