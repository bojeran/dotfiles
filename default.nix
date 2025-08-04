{ pkgs ? import <nixpkgs> {}, fetch_git ? false, git_ref ? "master" }:
let
  bash_profile =
    pkgs.stdenv.mkDerivation rec {
      pname = "merged-bash-profile";
      version = "1.0.0";

      src = if fetch_git then
        builtins.fetchGit {
          url = "https://github.com/bojeran/dotfiles.git";
          ref = git_ref;
        }
      else
        pkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ] ./.;

      buildPhase = ''
        # Copy the merge script from nix-build-utils
        cp ${if fetch_git then "nix-build-utils/merge_bash_profile.py" else "${./nix-build-utils/merge_bash_profile.py}"} merge.py

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