{ pkgs ? import <nixpkgs> {} }: [
  pkgs.fd        # needed by some nvim plugins
  pkgs.pngpaste  # needed for img-clip.nvim
]
