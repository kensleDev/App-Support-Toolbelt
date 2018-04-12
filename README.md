
# Handy Macros

This script has been developed while doing application support to considerably speed up my workflow. Dispite of that it is extremley handy for day to day use of a windows machine.

Currently everything is hardcoded and I plan to add a config file/ gui for picking what apps / folers are launched.

It has 2 optional dependancies which are:

- Clipx - https://bluemars.org/clipx/ - Adds a histroy to the clipboard. Also allows you to copy and preview images before pasting.

- Lintalist - https://lintalist.github.io/ - This is an open source text/ snippet expander. Most IDE's and editing software have snippet management built in but the reason I use this one is it works everywhere. You can add variables/placeholders into the snippets or even build a multipule choice menus for re-useability. You can either search via the gui or assign an abbreviation to a snippet. It works really well for code snippets but a basic example could be: when you type "signoff" and press tab it could bring up a multipule choice of pre defined formal/ informal goodbyes. Not really that handy you get the point, a common one I use is pressing "@" then tab gives me a choice of emails to paste.

## General Info

- This script works by disabling the caps lock keys functionaily and using it as a modifer key.

- The Caps lock key can still be enabled by pressing shift + Capslock which saves me alot of frustration not being able to hit Caps by mistake.

- Also includes a couple of handy windows shortcuts

- The settings file (included in this directory) is line sensitive. This means that the line numbers cannot change or it will break the application. Bare this in mind when making changes

- The settings file reads you select after the _ . I tried using a space or colon but AHK does not like this. So from the following it will read "a" : `btn1_a`



## Keymap

  |  **Combo** | **Launch Mode** | **Action** |
  |  :------ | :------ | :------ |
  |  CAPS+Q | Single | Search From Input: Service Now |
  |  CAPS+Q | Double | Search From Clipboard: Service Now |
  |   |  |  |
  |  CAPS+W | Single | Launch Bookmarks |
  |   |  |  |
  |  CAPS+A | Single | Launch Apps |
  |   |  |  |
  |  CAPS+E | Double | Launch Folders |
  |   |  |  |
  |  CAPS+S | Single | Search From Input: Favorites |
  |  CAPS+S | Double | Search From Clipboard: Favorites |
  |   |  |  |
  |  CAPS+Z | Single | Launch Clipx |
  |  CAPS+X | Double | Launch Lintalist |
  |   |  |  |
  |  Handy Shortcuts |  |  |
  |   |  |  |
  |  WIN+DELETE | Single | Empty Trash |
  |  CRTL+SPACE | Single | Always on Top Window |
  |  MIDDLE CLICK | Single | Go up one folder Windows Explorer |
  |   |  |  |
  |   |  |  |

# Launch Menus
- Most functions ~~are~~ will be configurable  via the settings file
- All functions have the ability to remap selection buttons
- by Default these are set to a, s, d, z, x, c for optimal one hand use

### __*Apps*__

- (1) - VSCode
- (2) - Chrome
- (3) - Cmder
- (4) - undefined
- (5) - undefined
- (6) - undefined

### __*Folders*__

- (1) - Home
- (2) - Downloads
- (3) - Dev
- (4) - undefined
- (5) - undefined
- (6) - undefined

### __*Search*__

Open the input/clipboard search menu with a single/double press.
- (1) - Google
- (2) - Stack Overflow
- (3) - Twitter
- (4) - Youtube
- (5) - Reddit


### __*Service Now*__
- A single press brings up an input box that searchs the whole of service now. A double press searches directly from the clipboard.

# TODO

- Add menus to settings file
- Change Launch lintalist to MOD+x


