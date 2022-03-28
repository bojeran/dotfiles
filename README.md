# dotfiles
Overwhelming information is too much information.

Just copy the **dotfiles** you like and discover the subfolders to dig into my mind.

When the application to be configured cannot be configured via a dotfile you
might find configurations in one of the subfolders.


**Quick jump to the dotfile you need**:
- [tmux](#tmux)
- [vim](#vimrc)
- [ideavim](#vimrc)

**Quick jump to some thoughts**:
- [Windows](.setup-os/windows/README.md)
- [Mac OS](.setup-os/mac-os/README.md)
- [Linux](.setup-os/linux-ubuntu/README.md)


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


 
