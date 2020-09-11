# dotfiles
Symlink the dotfiles you like to your $HOME directory.

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