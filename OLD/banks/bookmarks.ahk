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
        ToolTip
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