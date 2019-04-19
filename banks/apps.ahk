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
        ToolTip
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