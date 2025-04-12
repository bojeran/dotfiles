{ pkgs ? import <nixpkgs> {}
, ps1Prefix ? ""
, shellPath ? null
}:

let
  fallbackShell = pkgs.mkShell {
    shellHook = ''
      echo "No shell.nix found."
      echo "Start special system-wide nix-shell."
      PS1="(system-wide) $ "
    '';
  };

  # Simple regex check: does shellPath start with `/`
  isAbsolute = shellPath != null && builtins.match "^/.*" shellPath != null;
in
if shellPath == null
then
  # No shellPath was passed at all
  fallbackShell
else if ! isAbsolute
then
  # shellPath is not an absolute path
  fallbackShell
else if ! builtins.pathExists shellPath
then
  # shellPath is absolute but the file doesn't exist
  fallbackShell
else
  # Otherwise, import the user-specified shell and tweak it
  # When you see a double dollar in PS1 you know it is wrapped shell
  (import shellPath { inherit pkgs; })
    .overrideAttrs (old: {
      shellHook = ''
        ${old.shellHook or ""}
        PS1='\$\$ '
      '';
    })