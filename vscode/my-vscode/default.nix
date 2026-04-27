{ pkgs ? import <nixpkgs> {} }:
let
  # ---------------------------------------------------------------------------
  # Local extension that ships our defaults.
  #
  # contributes.configurationDefaults  -> default values, user settings.json overrides them
  # contributes.keybindings            -> default keybindings, user keybindings.json overrides them
  #
  # This is the official VS Code mechanism for "shipped defaults that the user
  # can still tweak". Settings and keybindings live as normal writable files
  # in the user-data dir; our defaults sit one layer below.
  # ---------------------------------------------------------------------------
  defaultsManifest = {
    name = "my-defaults";
    publisher = "bojeran";
    displayName = "bojeran VS Code defaults";
    description = "Built-in defaults (settings + keybindings) shipped with my-vscode.";
    version = "0.0.1";
    engines = { vscode = "^1.0.0"; };
    contributes = {
      configurationDefaults = builtins.fromJSON (builtins.readFile ../settings.json);
      keybindings = builtins.fromJSON (builtins.readFile ../keybindings.json);
    };
  };

  defaultsPackageJson = pkgs.writeText "package.json" (builtins.toJSON defaultsManifest);

  defaultsExt = pkgs.runCommand "vscode-extension-bojeran-my-defaults-${defaultsManifest.version}" {
    # Attributes read by `vscode-with-extensions` when building
    # the merged `extensions.json` manifest.
    version = defaultsManifest.version;
    vscodeExtUniqueId = "${defaultsManifest.publisher}.${defaultsManifest.name}";
    vscodeExtPublisher = defaultsManifest.publisher;
    vscodeExtName = defaultsManifest.name;
  } ''
    mkdir -p "$out/share/vscode/extensions/$vscodeExtUniqueId"
    cp ${defaultsPackageJson} "$out/share/vscode/extensions/$vscodeExtUniqueId/package.json"
  '';

  # ---------------------------------------------------------------------------
  # vscode + extensions baked into the install
  # ---------------------------------------------------------------------------
  extensions = (import ./extensions.nix { inherit pkgs; }) ++ [ defaultsExt ];

  vscodeWithExt = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
  };

  # ---------------------------------------------------------------------------
  # Launcher
  #
  # Uses a dedicated --user-data-dir so this Nix-managed instance does not
  # collide with a user-installed VS Code. Cleans up settings.json /
  # keybindings.json if they are still symlinks left over from a previous
  # install of this package (the old wrapper used to symlink them read-only
  # into the Nix store, which made VS Code fail when it tried to persist
  # changes via the UI).
  # ---------------------------------------------------------------------------
  launcher = pkgs.writeShellScript "code-launcher" ''
    USER_DATA="$HOME/.local/share/my-vscode"
    mkdir -p "$USER_DATA/User"
    for f in settings.json keybindings.json; do
      if [ -L "$USER_DATA/User/$f" ]; then
        rm -f "$USER_DATA/User/$f"
      fi
    done
    exec ${vscodeWithExt}/bin/code --user-data-dir "$USER_DATA" "$@"
  '';

  myVscode = pkgs.symlinkJoin {
    name = "my-vscode";
    paths = [ vscodeWithExt ];
    postBuild = ''
      rm $out/bin/code
      cp ${launcher} $out/bin/code
      chmod +x $out/bin/code
    '';
  };
in
myVscode
