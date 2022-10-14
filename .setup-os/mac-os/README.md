## Mac OS Checklist

- !! First !! (order is important):
  - Install from App Store: Magnet, Velja, Dropover, Hidden Bar, Pure Paste, Key Codes
  - Change keyboard settings
    (reason: slow repeating keys and auto correction is annoying)
  - [Install iterm2](https://iterm2.com/)
    - iterm2: increase font size
      (Profiles -> Text -> 16)
    - iterm2: enable Status Bar
      (Profiles -> Session -> Status bar enabled -> configure Status Bar
      -> Hostname -> Fixed size spacer - Clock (HH:mm  dd.MM.YY))
    - iterm2: Appearance -> Status bar location: Bottom  
    - iterm2: Appearance -> Tabs -> Show tab bar even when there is only one tab
      -> enabled
    - iterm2: Appearance -> Panes: Separate status bar per pane -> enable  
    - iterm2: General -> Magic -> Advanced GPU Settings -> Uncheck Disable GPU
      renderer when disconnected from power
  - [Install homebrew](https://brew.sh/)
  - Change shell: zsh to bash
    (reason: homebrew detect shell and may only install shell extensions for the currently active shell)
    - **zsh to bash**: (Install latest bash version because preinstalled version too old)
    
          brew install bash
          # OPEN A NEW TERMINAL
          bash --version # verification
          sudo bash -c 'echo '"$(which bash)"' >> /etc/shells'
          chsh -s "$(which bash)"
          # OPEN A NEW TERMINAL
          echo "$SHELL"  # verification
          # Fix homebrew path
          echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.bash_profile"
          # Install bash completion for bash 4.2+
          brew install bash-completion@2
          # Reinstall previously installed homebrew packages with bash completion
          # e.g. brew reinstall git
          # try bash completion with git command

  - Copy .vimrc to $HOME/.vimrc (no changes required)
  - iterm2: Keys -> Key Bindings -> set: cmd+w to Send hex code: "0x2 0x64"
    (because ctrl+w does not immediatly put a tmux pane in background when pressed. Fix: This change automatically sends "ctrl+b d" to terminal instead to send the tmux pane immediatly to the background. This is important if you want to quickly close multiple windows and then run "tmux ls" that shows the currently attached windows.)
    (The hexcode can be found it with the App "Key Codes")
  - Copy .bash_profile to $HOME/.bash_profile and improve/fix it
  - Install tabset:
    - brew install npm && npm install -g iterm2-tab-set
      (It is important that iterm2-tab-set is installed globally without nvm enabled. This makes sure that tabset works without nvm.)
    - Rename tab name from terminal: In the profile settings you have to check
    "Application in terminal may change title". 
    - Try with: `tabset` (make sure nvm is enabled)

  - `brew install fzf`
  - `brew install tmux`
    - copy .tmux.conf to $HOME/.tmux.conf (no changes required)
  - ENABLE_TMUX_TAB=true in .bash_profile

  - Install nvm (and install latest npm)
    - `brew install nvm` and do a .bash_profile integration
    - `nvm install node`, now you have a development npm as well.

  - Install pyenv (and install latest python and set it as global)
    - After installation, update .bash_profile 
    - `pyenv install --list`
    - `pyenv install $VERSION`
    - Set global python `pyenv global $VERSION`
    - verification: `pyenv versions`
  - Make the standard terminal commands behave like the linux commands:
    - `brew install iproute2mac` (ip command)
    - `brew install coreutils` (a lot of commands)
      - Make sure to update .bash_profile to overwrite the Mac OS default commands. Otherwise they are prefixed with "g" e.g. "gls".
      - This makes a difference for bash script compatibility between systems.
    - `brew install gnu-sed`
      - update .bash_profile
      - This makes a difference for bash script compatibility between systems.
  - Terminal.app -> Preferences > Profiles > (Select a Profile) > Shell > When the shell exits: Close the window
  - Optionally (not recommended): iterm2 -> Install Shell Integration (not compatible with tmux)
  

- OS X Settings:
  - System Preferences -> View -> Organise Alphabetically
  - Keyboard Settings: Change automatic quotation mark change when you type `"`
  - Keyboard Settings: No auto correction
  - Keyboard Settings: fast, fast
  - Keyboard Settings -> Shortcuts -> Check "Use keyboard navigation to move focus between controls"
  - Bring "Save as" back as default (instead of duplicate):
    - Keyboard Settings -> Shortcuts -> App Shortcuts -> +
    - Applications: All Applications, Menu Title: Save As..., Keyboard Shortcut: Shift+Cmd+S
    - Verify that Duplicate command is shadowed in TextEdit.app
  - Touchpad: Three finger swipe. Faster Speed.
  - Dock & Menu Bar: Uncheck show recent applications
  - Dock & Menu Bar: Position on Screen Left
  - Desktop & Screen Saver -> Screen Saver -> Hot Corners: Change Quick Notes to Desktop
  - Finder -> Preferences -> General -> Check Hard disks
  - Finder -> Preferences -> General -> New Finder windows show: Documents
  - Finder: Drag & Drop Favourites to your likings
  - Finder -> View -> Customize Bar -> Show: Icon and Text
  - Finder -> View -> Customize Bar -> Drag and Drop Airdrop to the Bar
  - Finder -> View -> Show Path Bar
  - Finder -> View -> Show Status Bar
  - Finder -> View -> Show View Options (you can change settings per folder e.g. Downloads folder should always look different)
    - Optionally: Tint the background of common locations slightly to know where you are immediately
  - Finder -> Drag & Drop folders into the Custom Bar e.g. Documents
  - Finder -> Drag & Drop applications you frequently use into the Custom Bar e.g. Box
  - Seach "Airdrop.app" and drag&drop to Dock
  - Accessibility -> Siri -> Check "Enable Type to Siri" (if you like Siri)
  - Icon Bar -> remove icons you don't need by holding CMD and drop them out

- OS X Hidden Preferences:
  - Strg+h: When application hides show to application symbol transparently.
  - [Fast/No Animations](https://apple.stackexchange.com/questions/14001/how-to-turn-off-all-animations-on-os-x)
  - Enable Text Selection in Quick Look:
  `defaults write com.apple.finder QLEnableTextSelection -bool TRUE; killall finder`
  - defaults:

        # defaults read com.apple.dock|grep autohide
        defaults write com.apple.dock autohide-delay -float 0
        defaults write com.apple.dock autohide-time-modifier -float 0
        # add a spacer in the dock
        defaults write com.apple.dock persistent-apps -array-add ' {title-data=  {}; tile-type="spacer-tile";}' && killall Dock
        # Always show the advanced settings for printers when you print    something (untested), reboot required
        defaults write -g PMPrintingExpandedStateForPrint -bool TRUE
        # Show all files (also hidden files)
        defaults write com.apple.finder AppleShowAllFiles True; killall  Finder 
        # Enable repeating keys
        defaults write -g ApplePressAndHoldEnabled -bool false
        # Increase Terminal Cursor speed:
        defaults write NSGlobalDomain KeyRepeat -int 0
        defaults read|grep KeyRepeat

  - Right click on Desktop -> Use Stacks
  - Right click on Desktop -> Show view options -> Show items info
     
- XQuartz (if you plan to do X11 Forwarding: `ssh -X ...`)

- Docker (see `.bash_profile` included in this project)

- Go through `https://privacy.sexy` for Mac OS.
