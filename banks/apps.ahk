
appBank() {

  APP_1_NAME=Visual Studio Code
  APP_2_NAME=Chrome

  THE_MENU := assembleMenu([APP_1_NAME, APP_2_NAME])

  ToolTip % THE_MENU

  Input Key, L1
    ToolTip
    if Key=a
      RunOrActivate(APP_1_NAME)
    Else If Key=s
      RunOrActivate(APP_2_NAME)
    ; Else If Key=d
    ;   RunOrActivate()
    ; Else If Key=z
    ;   RunOrActivate()
    ; Else If Key=x
    ;   RunOrActivate()
    ; Else If Key=c
    ;   RunOrActivate()
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
