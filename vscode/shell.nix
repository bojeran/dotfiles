# Use this shell to develop the nix package you want
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    (pkgs.callPackage ./my-vscode {})
  ];
}
