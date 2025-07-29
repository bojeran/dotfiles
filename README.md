# dotfiles
## Instant Install .bash_profile

```
# Install .bash_profile
nix-build \
  -E "import (builtins.fetchurl { url = \"https://raw.githubusercontent.com/bojeran/dotfiles/refs/heads/master/default.nix\"; })" \
  --arg fetch_git true \
  -o $HOME/.bash_profile
```


## Quick Install .bash_profile
```
# 1. clone project
# 2. cd into project
# 3. run:
nix-build -o $HOME/.bash_profile
```


## Comparison

| Aspect                                                         | ★ This .bash\_profile                                   | Heavyweight framework                                | Stock \~/.bashrc |
|----------------------------------------------------------------|---------------------------------------------------------|------------------------------------------------------|------------------|
| **Cold-start load time**                                       | ★ **Ultra-snappy** (loads almost nothing)               | ✗ Noticeably slower (hundreds of lines of plugins)   | ✓ Fast           |
| **Clean terminal on every launch**                             | ★ Yes – no cruft left behind                            | ◔ Partial (plugins often emit output)                | ✓ Mostly         |
| **Lazy-loading unknown commands**                              | ★ Built-in dynamic search → PATH added *only when used* | ✗ Usually absent (plugins pre-load)                  | ✗ Absent         |
| **Transparent PS1**<br/>*(shows which env/path was pulled in)* | ★ Inline display of real-time PATH & envs               | ◔ Theme-dependent (often hidden)                     | ✗ None           |
| **Monochrome symbol set**<br/>*(eye-friendly ★ ✓ ✗ only)*      | ★ Consistent, no color-bleed                            | ✗ Rainbow themes by default                          | ✓ Minimal        |
| **External dependencies**                                      | ★ **Zero** – pure Bash                                  | ✗ Needs git, curl, sometimes node/python for plugins | ✓ None           |
| **Drop-in deployment speed**                                   | ★ Quick Install → use (seconds)                         | ✗ Clone repo, run install script, update regularly   | ✓ Already there  |
| **Cross-platform (WSL 2 / macOS / Linux)**                     | ★ Works everywhere unmodified                           | ◔ often one platform only (quirks required)          | ✓ Works          |
| **Preserves default shortcuts / muscle-memory**                | ★ 99 % (no common alias overrides)                      | ✗ Many re-mapped keys & aliases                      | ✓ Preserved      |
| **Overall friction**                                           | **★★★★☆ minimal**                                       | ★★☆☆☆                                                | ★★★☆☆            |


## CHUNK included

Because one monorepo for all setups is convenient there is way more in this repo then just a `.bash_profile`.

You will also find setup&config instructions for: mostly macOS, a bit for Windows, little for Linux.

**Quick jump to the dotfile you need**:
- [tmux](#tmux)
- VIM:
  - [vim](#vimrc)
  - [ideavim](#vimrc)
  - [obsidian-vim](#vimrc)

**Re-/installing a new OS - I got you covered**:
- [Windows](.setup-os/windows/README.md)
- [Mac OS](.setup-os/mac-os/README.md)
- [Linux](.setup-os/linux-ubuntu/README.md)

Just copy the **dotfiles** you like and discover the sub-folders to dig into my mind.

When the application to be configured cannot be configured via a dotfile you might find configurations in one of the sub-folders.


# Classic Installation
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

# replace VAULT_ROOT with the root folder of your vault
ln -s "$(pwd)/.obsidian.vimrc" VAULT_ROOT/.obsidian.vimrc
```

## ansible.cfg
```
ln -s "$(pwd)/.ansible.cfg" ~/.ansible.cfg
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


# Some basics
## bash profile

What startup files are used by the shell depends on two factors:
- **interactive/non-interactive**: Interactive means that the shell 
interactively prompts you for commands to enter (usually whenever you open a 
terminal application). More precisely whenever you use one of the following
options of the bash executable you get non-interactive shell (you
get an interactive shell in all other cases):
  - `bash -c '..'`
  - `echo command|bash`
  - `echo command|bash -s`.
- **login/non-login**: On Linux/Unix systems there exists a `login` command 
which starts the system-wide configured shell (bash in my case) with some 
user-defined config files. Usually those config-files modifies the environment
variables to meet the users requirements. The following config files are
read in order:
  - system-wide startup file (always): `/etc/profile`
  - Either:
    - **when login-shell**: personal initialization files (first found and is 
      readable is used):
      `$HOME/.bash_profile`, `$HOME/.bash_login`, `$HOME/.profile`.
    - **when non-login shell**: personal initialization file:
      `$HOME/.bashrc`.
  - personal logout file: `$HOME/.bash_logout` - runs when the bash builtin 
    `exit` command is executed. (In both interactive and non-interactive 
    shells)

A good indicator that you are in a login shell is a "-" (dash) in the output of "echo $0". However, using the special flags "$-" is better for automation. You can change the redirection of the current shell with for example: `exec > >(tee ${LOG_FILE}) 2>&1` (no arguments). Or you replace the current shell with a different command `exec command`. Sometimes it is better to scope the redirection for some commands with: `{ command1; ...; } > >(tee ${LOG_FILE}) 2>&1`.

Some examples to try out:
```
# Automated way to find out the SHELL type:
if ! echo $-|grep -q i; then echo -n "non-"; fi; echo -n "interactive "; \
if shopt login_shell|grep -q off; then echo -n "non-"; fi; echo login shell

# A non interactive shell, non login shell:
bash -c 'echo $-;shopt login_shell'

# A non interactive, login shell:
bash --login -c 'echo $-;shopt login_shell'
# OR (most of the time)
ssh localhost 'echo $-;shopt login_shell'

# Open an interactive non-login-shell and make it a login shell
bash
login
```

There are also some special files:
 - `/etc/motd`: Define a message of the day. (Often seen as first welcoming message.)
 - `/etc/nologin`: Disallows logins (Seen frequently with no login users).
 - `/var/run/utmpx`: Contains ALL current logins!!
 - `/var/mail/user`: Seen with self-hosted email servers.
 - `${HOME}/.hushlogin`: Create this empty file to make the login quiet.
 - `/etc/pam.d/login`: PAM config

## Some interesting examples

Example to start an interactive non login shell and then log in while
preserving the environment variables set previously:
```
# Just typing bash starts a bash shell without logging in.
bash
bash-5.1$ ABC="OKOK"; export ABC
# login preserving the current environment variables
bash-5.1$ login -p
```

Execute a script when starting a non-interactive shell
```
bash-5.1$ BASH_ENV="/tmp/helloworld"
bash-5.1$ export BASH_ENV
bash-5.1$ bash -c ''
hello world
```


## Typical Binary locations Linux/Unix

- `/bin`: Early boot apps e.g. `cat`. Binaries needed before `/usr` path exists
.
- `/sbin`: Early boot apps needing root privileges e.g. `ping`.
- `/usr/bin`: System-wide binaries e.g. `unzip`.
- `/usr/sbin`: System-wide binaries needing root privileges e.g. `tcpdump`.
- `/usr/local/bin`: Your own scripts which are system-wide available.
- `/usr/local/sbin`: Your own scripts needing root privileges.
- `$HOME/bin`: Your own user scoped scripts. Consider using `$HOME/.local/bin`
instead.
- `${HOME}/.local/bin`: Your own user scoped scripts for SHELL invocation purposes. By using this path you maintain compatibility with systemd. This is something you might want for most user scoped scripts as systemd is very common nowadays. Recommending using this folder on macOS / FreeBSD systems as well (requires to add this folder to the PATH):
 
      mkdir -p "${HOME}/.local/bin"
      ln -s "/path/to/third-party/binary" "${HOME}/.local/bin"
      echo 'export PATH="${PATH}:${HOME}/.local/bin"' >> "${HOME}/.bash_profile"
 
- `$HOME/.local/lib/*/bin`: Binaries that are not intended for SHELL invocation
and are not on the PATH. Maintaining compatibility with systemd specs.
- XDG Base Directory Specification (Version 0.8) (used by a lot of programs)
  - `$XDG_DATA_HOME` defaults to `$HOME/.local/share`.
  - `$XDG_CONFIG_HOME` defaults to `$HOME/.config`.
  - `$XDG_STATE_HOME` defaults to `$HOME/.local/state`.
  - There are more environment variables that an application has to use and look for when this standard is implemented.

## Debug Shell Start

- Simply start a new shell with -x enabled:
  ```
  bash -xl
  ```