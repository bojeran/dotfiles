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
