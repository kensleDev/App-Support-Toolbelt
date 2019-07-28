# Windows Helper

- This script works by disabling the caps lock keys functionaily and using it as a modifer key.

- The Caps lock key can still be enabled by pressing shift + Capslock which saves me alot of frustration not being able to hit Caps by mistake.

- The placement of the caps key makes it for me the most erganomic modifer key and feels very natural to use

- Caps & {key} can then be used to do anything auto hot key can

- Current features are app launching and the ability to search websites from anywhere on your computer

- Also includes navgation shortcuts that I find handy for keyboard focused operation of windows

- Has functionailty to map double and long presses

## Requirements / Setup
- Requires [Auto Hot Key](https://www.autohotkey.com/)

- Make a shortcut to WindowsHelper.ahk and place in your startup folder (type shell:startup in windows explorer bar)

- HAS TO BE RUN AS ADMIN - otherwise disabling capslock does not work


## The Magic

This is what makes caps a modifier, for your own scripts

```
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
```


# Hotkeys
## Navigation
| Key | Command |
| :-------- | :-------- |
| Capslock & Space | Escape |
| Capslock & > | Delete |
| Capslock & < | BackSpace |
| CapsLock & h | Left |
| CapsLock & j | Down |
| CapsLock & k | Up |
| CapsLock & l | Right |
| Capslock & y | Home |
| CapsLock & u | smoothPager("Up") |
| Capslock & i | smoothPager("Down") |
| CapsLock & o | End |

## Menus
| Key | Command |
| :-------- | :-------- |
| CapsLock & Tab | showHotkeyMenu() |
| CapsLock & Tabup | hideHotkeyMenu() |
| CapsLock & f | searchMenu() |

## Apps
| Key | Command |
| :-------- | :-------- |
| CapsLock & c | openDitto() |
| CapsLock & q | taskbarApp(1) |
| CapsLock & w | taskbarApp(2) |
| CapsLock & e | taskbarApp(3) |
| CapsLock & r | taskbarApp(4) |
| CapsLock & t | taskbarApp(5) |

## Remaps
| Key | Command |
| :-------- | :-------- |
| CapsLock & / | sendKey(backslash) |
| CapsLock & `; | sendKey(backtick) |
| CapsLock & ' | sendKey(pipe) |

<!--- HotkeyEnd -->

# Auto docs
- running npm start in the autodocs folder will read the defined hotkeys in the code and insert a markdown table into README.md

