# Windows Extended Keyboard

The modifier keys are positioned in such a way that you are required to move your hands away from the home row to use them.

Capslock is positioned in a much more convenient spot and gets a lot less use.

This script disables capslock to allow it to be used as a NEW modifier. It means you don't need to be worried about overwriting shortcuts used by other apps.

To consume this new modifier I've created an extended layer that is constantly being adapted as needed. It allows for much faster navigation of the system with minimal moving of your hands.

Using AutoHotKey it's easy to map keystrokes; launch apps; run macros using any key you wish.

The script supports:
```
Caps + key
Caps + Shift + key
Caps + Alt + key
```
I've not included Ctrl as it's awkward to hit while pressing caps but the script could easier be adapter to include it or other modifier combinations.

# 💻 Install

- Move the script folder to where ever you like and create a shortcut to Windows-Helper.ahk. 

- Before moving the shortcut: right click -> properties -> advanced -> run as administrator

- Some keystrokes do not work without admin access, I'm not sure of the extent of it but I know the F keys won't work without.

# ⌨ Keymap

See [keymap](keymap.md)  for all binds

Or to edit the key map do the following:

In keymap.ahk you will see that the actions for each keybind are wrapped in a cmd function:

```
CapsLock & ?::cmd("\",  "", "")

; Function Reference
; cmd(Caps, Caps with Shift, Caps with Alt)
```
The function takes 3 arguments, the first being the action for Caps+key, the second Caps+Shift+key and the last Caps+Alt+key. o
It's wrapping the Autohotkey Send command so accepts anything that Send does - [docs](https://www.autohotkey.com/docs/commands/Send.htm).

To send a macro instead of a key combo remove the cmd function and replace with your macro
```
CapsLock & ?::myMacro()

or 

CapsLock & ?::
  msgBox, this is a test
Return
```

Be aware that you will loose modifier functionality and will have to implement this yourself. This can be easily done by modifying / re-implementing  the cmd function.

# 💞 Dependancies (kind of)

There are a few apps that I use for managing my system:

- Ditto - Clipboard manager
- Wox - Omni launcher - like Alfred or Spotlight on mac 
- Beeftext - Text expander / Snippet manager

The script has hotkeys to launch these apps so they the script technically isn't dependent on them as the script sends the key combo required for launching it.
This means you could change these to whatever you wish. The 3 binds are: 
```
Caplock + p
Capslock + [
Capslock + ]
```

# 📋 Todo

- Possibly add CTRL modifier - as mentioned it can be awkward to press when pressing Caps at the same time which is what i'm trying to stay away from. The issue is that there are alot of standard commands that rely on CTRL.

- Create visual documentation & hotkey - I'm looking at creating a few images to better demonstate the keybinds at glance. This could then be triggered by a hotkey from anywhere.

- User config - initally thinking about a config file which will allow the user to change the hotkeys without knowlegdge of autohotkey. Although I don't think this approach will work if generating an exe which is the ultimate goal. Becuase of this I may look at a GUI config.

# 🐛 Known Issues

- When pressing Capslock + alt, due to Capslock being mapped to escape it will swap apps. To aviod this make sure to press Capslock first. This might be fixed by reconising long presses vs taps.