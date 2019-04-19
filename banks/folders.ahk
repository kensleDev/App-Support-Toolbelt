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
        ToolTip
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