## Mac OS Checklist
- Prerequisites:
  - [Install iterm2](https://iterm2.com/)
  - [Install homebrew](https://brew.sh/)
  - Install nvm (and install latest npm)
  - Install pyenv (and install latest python and set it as global)
  

- OS X Settings:
  - Keyboard Settings: Change automatic quotation mark change when you type `"`
  - Keyboard Settings: No auto correction
  - Keyboard Settings: fast, fast  
  - Touchpad: Three finger swipe. Faster Speed.
    

- OS X Hidden Preferences:
  - Strg+h: When application hides show to application symbol transparently.
  - [Fast/No Animations](https://apple.stackexchange.com/questions/14001/how-to-turn-off-all-animations-on-os-x)
  - Enable Text Selection in Quick Look:
  `defaults write com.apple.finder QLEnableTextSelection -bool TRUE; killall finder`
  - Increase Terminal Cursor speed:
  `defaults write NSGlobalDomain KeyRepeat -int 0`
  - Enable repeating keys:
  `defaults write -g ApplePressAndHoldEnabled 0`
  - Show hidden files: `com.apple.finderAppleShowAllFiles YES`
    
  
  

- Terminal:
  - Make terminal disappear on exit.
  - Shell Integration (maybe)
  - Upgrade bash version (because preinstalled one is too old)
```
brew install bash
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash
```
  - `brew install iproute2mac`
  - fzf
```
brew install fzf
$(brew --prefix)/opt/fzf/install
```
  - `brew install coreutils`
  - `brew install gnu-sed --with-default-names`
  - iterm2: enable Status Bar
    (Profiles -> Session -> Status bar enabled -> configure Status Bar
    -> Hostname -> Fixed size spacer - Clock (HH:mm  dd.MM.YY))
  - iterm2: Appearance -> Status bar location: Bottom  
  - iterm2: Appearance -> Tabs -> Show tab bar even when there is only one tab
    -> enabled
  - iterm2: Appearance -> Panes: Separate status bar per pane -> enable  
  - iterm2: Appearance -> Dimming -> Dimming Amount: FULL +
    Appearance -> Dimming affects only text, not background -> enable
  - iterm2: General -> Magic -> Advanced GPU Settings -> Uncheck Disable GPU
    renderer when disconnected from power
  - Rename tab name from terminal: In the profile settings you have to check
    "Application in terminal may change title". 
    Then `npm install -g iterm2-tab-set`.


- XQuartz (if you plan to do X11 Forwarding: `ssh -X ...`)


- Docker (see `.bash_profile` included in this project)


- Go through `https://privacy.sexy` for Mac OS.