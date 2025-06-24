{ 
  pkgs ? import <nixpkgs> {}, 
  fetch_git ? false, 
  git_ref ? "master",
  # Specific commit hash - overrides git_ref when provided
  rev ? null,
  # Force refresh by appending timestamp to ref (invalidates cache)
  force_refresh ? false
}:

pkgs.stdenv.mkDerivation rec {
  pname = "merged-bash-profile";
  version = "1.0.0";

  # Git cache behavior:
  # - builtins.fetchGit caches based on URL + ref/rev combination
  # - Use 'rev' parameter for exact commits (most reliable, always fetches that commit)
  # - Use 'force_refresh = true' to add timestamp and fetch all refs (invalidates cache)
  # - Manual cache clear: rm -rf ~/.cache/nix && nix-collect-garbage -d
  # Examples:
  #   nix-build --arg fetch_git true --arg rev '"bf1a2fe..."'     # exact commit
  #   nix-build --arg fetch_git true --arg force_refresh true     # force latest
  #   nix-build --arg fetch_git true --arg git_ref '"develop"'    # specific branch
  src = if fetch_git then
    builtins.fetchGit (
      {
        url = "https://github.com/bojeran/dotfiles.git";
      } // 
      (
        if rev != null then {
          inherit rev;
        } else {
          ref = git_ref;
          # Adding allRefs = true when force_refresh is enabled forces cache invalidation
          # by changing the derivation inputs, but requires Nix to fetch all refs
        } // (if force_refresh then {
          allRefs = true; 
          # Add timestamp as a comment to change derivation hash without affecting git fetch
          name = "dotfiles-${toString builtins.currentTime}";
        } else {})
      )
    )
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
}