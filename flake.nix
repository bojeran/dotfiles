{
  description = "bojeran dotfiles: bash profile, neovim, vimrc";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system: f system);
    in {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          dotfiles = import ./. { inherit pkgs; };
        in {
          inherit (dotfiles) bash_profile neovim vimrc;
        });
    };
}
