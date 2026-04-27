# My VS Code configuration

A self-contained VS Code build with extensions and shipped default
settings / keybindings. The VS Code analogue of the `my-neovim`
package.

## What gets bundled

- VS Code (`pkgs.vscode-with-extensions`)
- Marketplace / nixpkgs extensions listed in [`extensions.nix`](./extensions.nix)
- A locally-built extension `bojeran.my-defaults` whose `package.json`
  embeds the contents of [`vscode/settings.json`](../settings.json)
  (under `contributes.configurationDefaults`) and
  [`vscode/keybindings.json`](../keybindings.json)
  (under `contributes.keybindings`)

## How "shipped defaults you can still override" works

VS Code resolves settings in layers (low to high precedence):

1. Built-in defaults
2. `configurationDefaults` contributed by extensions  ← **our layer**
3. User `settings.json`                                ← writable, normally empty
4. Workspace `.vscode/settings.json`

The `bojeran.my-defaults` extension sits at layer 2: every value in
`vscode/settings.json` becomes a default. The user is free to flip
anything via the VS Code UI, which writes to layer 3 and wins. Same
idea for keybindings.

The wrapper points VS Code at a dedicated `--user-data-dir`
(`~/.local/share/my-vscode`) so this Nix-managed install does not
share state with a user-installed VS Code. The directory is fully
writable; settings/keybindings end up there as normal files when the
user changes anything.

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

Then run `code` from the terminal.

## Updating defaults

Edit [`vscode/settings.json`](../settings.json) or
[`vscode/keybindings.json`](../keybindings.json) and rebuild. The
embedded defaults change; user-overridden values in
`~/.local/share/my-vscode/User/{settings,keybindings}.json` are
untouched.

## Caveats

- On macOS, launching VS Code from the Dock or Spotlight bypasses our
  CLI launcher. Start it from a terminal (`code`) to use the managed
  user-data dir.
- VS Code does not officially document support for negative
  unbinding entries (`"command": "-..."`) inside an extension's
  `contributes.keybindings`. If a default unbind from
  `vscode/keybindings.json` does not take effect, move that entry into
  `~/.local/share/my-vscode/User/keybindings.json` instead.
- The previous version of this package symlinked `settings.json` and
  `keybindings.json` from the Nix store, which made VS Code fail when
  the UI tried to persist changes. The new launcher cleans up those
  stale symlinks on first launch so VS Code can write normally.
