{ pkgs ? import <nixpkgs> {} }:
let
  bash_profile =
    pkgs.stdenv.mkDerivation rec {
      pname = "merged-bash-profile";
      version = "1.0.0";

      src = pkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ] ./.;

      buildPhase = ''
        # Copy the merge script from nix-build-utils
        cp "${./nix-build-utils/merge_bash_profile.py}" merge.py

        # Run the merge script
        ${pkgs.python3}/bin/python3 merge.py > merged_bash_profile
      '';

      installPhase = ''
        cp merged_bash_profile $out
        chmod +x $out
      '';

      meta = with pkgs.lib; {
        description = "Self-contained merged bash profile from modular files.";
        license = licenses.mit;
      };
    };

    neovim = (pkgs.callPackage ./.neovim/my-neovim {});

    vimrc = pkgs.writeText "vimrc" (builtins.readFile ./.vimrc);
in
{
  inherit bash_profile neovim vimrc;
}