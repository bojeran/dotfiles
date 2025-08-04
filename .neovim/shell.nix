# Use this shell to develop the nix packages you want
# shell.nix or inside a larger Nix expression
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    (pkgs.callPackage ./my-neovim {})
  ];
}
