
# The Hidden Modifer

- This script works by disabling the caps lock keys functionaily and using it as a modifer key.

- The Caps lock key can still be enabled by pressing shift + Capslock which saves me alot of frustration not being able to hit Caps by mistake.

- The placement of the caps key makes it for me the most erganomic modifer key and feels very natural to use

- Caps & {key} can then be used to do anything auto hot key can

- Current features are app launching and the ability to search websites from anywhere on your computer

- Also includes navgation shortcuts that I find handy for keyboard focused operation of windows

- Has functionailty to map double and long presses

## Requirements / Setup
- Requires [Auto Hot Key](https://www.autohotkey.com/)

- make a shortcut to WindowsHelper.ahk and place in your startup folder (type shell:startup in windows explorer bar)

- Currently everything is hardcoded (go to the corrosponding file in the banks folder to update config atm) and I plan to add a config file/ gui for picking what apps / folers are launched.


## Keymap

  |  **Combo** | **Launch Mode** | **Action** |
  |  :------ | :------ | :------ |
  |  CAPS+Q | Single | Trigger Search |
  |   |  |  |
  |  CAPS+D | Single | Launch Apps |
  |   |  |  |
  |  CAPS+Z | Double | Launch Search |
  |   |  |  |
  |  CAPS+Z | Single | Launch Ditto |
  |   |  |  |
  |  CAPS+S | Single | Next Virtual Desktop |
  |   |  |  |
  |  CAPS+A | Single | Previous Virtual Desktop |
  |   |  |  |


## Navigation

  |  **Combo** | **Launch Mode** | **Action** |
  |  :------ | :------ | :------ |
  |  CAPS+Space | Single | Escape |
  |   |  |  |
  |  CAPS+H | Single | Left |
  |   |  |  |
  |  CAPS+J | Single | Down |
  |   |  |  |
  |  CAPS+K | Single | Up |
  |   |  |  |
  |  CAPS+L | Single | Right |
  |   |  |  |



# Todo

- Style Menus
- Add features back in slowly
- Extract settings to ini files for easier config
- Finish documentation
