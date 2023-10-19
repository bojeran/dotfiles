## Mac OS Checklist

- !! First !! (order is important):
  - Install from App Store: BetterSnapTool, Velja, Dropover, Hidden Bar, Pure Paste, Key Codes
  - Change keyboard settings
    (reason: slow repeating keys and autocorrection is annoying)
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
  - Optionally: [Install MacPorts](https://www.macports.org/install.php)
    - Needed for clean `sshpass` installation because homebrew does not allow the installation of homebrew because of politics (forces user to use untrustworthy and unmaintained git repos instead). Note: `sshpass` is needed in some automation scenarios. for example: An `ansible playbook` that uses the `ansible_password` option to connect to the target host. (`ansible_password` might be encrypted with `ansible-vault encrypt_string`). Some targets (such as Windows systems) make it difficult to use `public key authentication` (for example when using free MobaSSH). Consider using `win_openssh` ansible module to install OpenSSH on Windows to be able to use public key authentication instead. (Manual installation can be painful)
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
    (because ctrl+w does not immediately put a tmux pane in background when pressed. Fix: This change automatically sends "ctrl+b d" to terminal instead to send the tmux pane immediately to the background. This is important if you want to quickly close multiple windows and then run "tmux ls" that shows the currently attached windows.)
    (The hexcode can be found with the App "Key Codes")
  - iterm2: Preferences -> Advanced Settings -> Scroll wheel sends arrow keys when in alternate screen mode -> yes
    (this fixes an issue when you scroll with the mouse in a tmux pane that you see the tmux history instead of terminal history)
  - iterm2: Keys -> Key Bindings -> set ALT+. to send Escape sequence: ESC+.
    (This gives you the default readline-based Linux terminal behaviour for alt+. (Meta+.) that some terminal users use (insert last command argument). You could also change it in Profiles -> Keys -> Left Option Key: ESC+ but this destroys writing special characters such as: "~". All keyboard shortcuts: https://en.wikipedia.org/wiki/GNU_Readline)
  - iterm2: Keys -> Key Bindings -> set Alt+b, Alt+c, Alt+d, Alt+f, Alt+r, Alt+u (except Alt+l) to send Escape sequence: ESC+b, ESC+c, ..., ESC+u as this gives you the standard emac shortcuts back (See previous bullet point). Alt+l does unfortunately collide with writing @ on a german mac keyboard layout.
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
    - `brew install pyenv` and if required do a .bash_profile integration
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
  - Optionally (recommended): Allow touchid authentication when running sudo: by prepending `auth sufficient pam_tid.so` to `/etc/pam.d/sudo`.
  - Homebrew casks:
    - `lulu` - simple firewall
    - `keepassxc` - password manager
    - `pycharm-ce` - IDEs
    - `balenaetcher` - tool to flash an OS on a USB stick
    - `calibre` - manage your ebooks
    - `veracrypt` - create encrypted containers
    - `visual-studio-code` - extensible text editor
    - `hex-fiend` - hex editor
    - `inkscape` - vector graphics tools
    - `android-platform-tools` - android debug bridge (adb) when needed
    - `wireshark` - network analytic tools
    - `vlc` - video player
    - `krita` - photo editor / drawing tool (better than gimp)
    - `obsidian` - note-taking
    - `handbrake` - convert video in other formats
    - `keepingyouawake` - prevents macbook sleep
    - `background-music` - per-app volume control (might break audio on your system)
    - Filesystem:
      - `openzfs` - use zpool
      - `macfuse` - successor of osxfuse, mount certain filesystems
  - For `iSCSI` buy `Daemon Tools - iSCSI initiator`. Note: You probably want to block network traffic from Daemon Tools as they might collect data on you.
  

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
  - Desktop & Dock -> Dock: Uncheck show recent applications
  - Desktop & Dock -> Dock: Position on Screen Left
  - Desktop & Dock -> Menu Bar: Recent Documents, applications and servers -> None
  - Desktop & Dock -> Stage Manager: yes and press customize
    - Recent applications -> yes
    - Desktop items -> yes
  - Desktop & Screen Saver -> Screen Saver -> Hot Corners: Change Quick Notes to Desktop
    - Good multi desktop approach: Hold "alt" and put Desktop in all corners (prevents accidental go to desktop)
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
       
        # Disable .DS_Store file creation for network drives
        defaults write com.apple.desktopservices DSDontWriteNetworkStores true

  - Right click on Desktop -> Use Stacks
  - Right click on Desktop -> Show view options -> Show items info
     
- Preferences -> Spotlight -> Exclude: /Volumes

- XQuartz (if you plan to do X11 Forwarding: `ssh -X ...`)

- Docker (see `.bash_profile` included in this project)

- Go through `https://privacy.sexy` for Mac OS.
