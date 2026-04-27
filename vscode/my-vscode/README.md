# My VS Code configuration

A self-contained VS Code build with extensions and `settings.json` /
`keybindings.json` baked in - the VS Code analogue of the `my-neovim`
package.

## What gets bundled

- VS Code (`pkgs.vscode-with-extensions`)
- Extensions listed in [`extensions.nix`](./extensions.nix)
- The repository's [`settings.json`](../settings.json) and
  [`keybindings.json`](../keybindings.json), symlinked from the Nix store
  into a dedicated user-data dir on every launch

## How "built-in config" works

VS Code needs a writable user-data dir for its own state (recent files,
workspace storage, etc.), so the config files cannot live in the
read-only Nix store directly. Instead, the wrapper:

1. Creates `$HOME/.local/share/my-vscode/User/` if missing.
2. Symlinks the Nix-store `settings.json` and `keybindings.json` into
   that directory (`ln -sfn`, refreshed on every launch so a rebuild
   always wins).
3. Launches `code --user-data-dir $HOME/.local/share/my-vscode "$@"`.

This isolates the managed instance from any system-installed VS Code
configuration.

## Installation

VS Code's license is unfree, so allow it for the build:

```bash
export NIXPKGS_ALLOW_UNFREE=1
# or set { allowUnfree = true; } in ~/.config/nixpkgs/config.nix
```

Then:

```bash
# Non-NixOS / one-off
nix-env -i -f default.nix
```

Then run `code` from the terminal. The first launch creates the
managed user-data dir; subsequent launches refresh the symlinks.

## Caveats

- On macOS, launching VS Code from the Dock or Spotlight bypasses our
  CLI wrapper. Start it from a terminal (`code`) to pick up the bundled
  config.
- `settings.json`/`keybindings.json` in the user-data dir are symlinks
  into the Nix store. Editing them through the VS Code UI will fail
  (read-only). Edit the files in this repo and rebuild.
