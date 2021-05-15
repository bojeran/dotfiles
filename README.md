# dotfiles
Symlink the dotfiles you like to your $HOME directory OR find setup
instructions in `.setup`.

Whenever you have to reinstall your system you have to set up and
configure all of your applications all over again. This repository tries
to solve this issue for some common Software and even Operating Systems.

There is a lot of Software out there which do not support the configuration
through a single dotfile. For those applications some manuel instructions
can be found under `.setup`.

**Supported Software Config**:
- [tmux](#tmux)
- [vim](#vimrc)
- [ideavim](#vimrc)

**Supported Software Manuel Setup/Config**:
- [Google Chrome](.setup/google-chrome/README.md)
- [Windows](.setup/windows/README.md)
- [Mac OS](.setup/mac-os/README.md)
- [Linux](.setup/linux/README.md)



# Getting Started
```
git clone https://github.com/bojeran/dotfiles.git
cd dotfiles
```

## tmux
```
ln -s "$(pwd)/.tmux.conf" ~/.tmux.conf
tmux kill-server
```

## vimrc
```
ln -s "$(pwd)/.vimrc" ~/.vimrc
ln -s "$(pwd)/.ideavimrc" ~/.ideavimrc
```

## vscode
Installed Extensions: LaTeX Workshop, Vim, Remote - WSL, Zotero LaTeX.

Put those files in the User Settings Path or in a `.vscode` folder in your project (Workspace Settings).

### Windows
User Settings Path: `%appdata%\Code\User`.

### MacOS
User Settings Path: `~/Library/Application Support/Code/User/`

### Linux
User Settings Path: `~/.config/Code/User`


 
