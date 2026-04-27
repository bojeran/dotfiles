{ pkgs ? import <nixpkgs> {} }:
let
  extensions = import ./extensions.nix { inherit pkgs; };

  # vscode + extensions baked into the install
  vscodeWithExt = pkgs.vscode-with-extensions.override {
    vscodeExtensions = extensions;
  };

  # Built-in config files (referenced by absolute Nix-store paths in the wrapper)
  settingsFile = ../settings.json;
  keybindingsFile = ../keybindings.json;

  # Dedicated user-data dir so this managed instance does not collide
  # with a user-installed VS Code. Created on each launch.
  userDataSubdir = ".local/share/my-vscode";

  myVscode = pkgs.symlinkJoin {
    name = "my-vscode";
    paths = [ vscodeWithExt ];
    nativeBuildInputs = [ pkgs.makeWrapper ];

    # Replace the bare $out/bin/code with a wrapper that:
    #  - ensures $HOME/.local/share/my-vscode/User exists
    #  - symlinks our built-in settings.json and keybindings.json into it
    #    (overwriting on every launch, so config is always our version)
    #  - launches code with --user-data-dir pointing at that dir
    postBuild = ''
      rm $out/bin/code
      makeWrapper ${vscodeWithExt}/bin/code $out/bin/code \
        --run 'mkdir -p "$HOME/${userDataSubdir}/User" && ln -sfn "${settingsFile}" "$HOME/${userDataSubdir}/User/settings.json" && ln -sfn "${keybindingsFile}" "$HOME/${userDataSubdir}/User/keybindings.json"' \
        --add-flags '--user-data-dir $HOME/${userDataSubdir}'
    '';
  };
in
myVscode
