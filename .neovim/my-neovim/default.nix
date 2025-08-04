# shell.nix or inside a larger Nix expression
{ pkgs ? import <nixpkgs> {} }:
let
  # Call the outer function with its arguments
  neovimWrapper = pkgs.callPackage (pkgs.path + "/pkgs/applications/editors/neovim/wrapper.nix") {};

  darcula-dark-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "darcula-dark.nvim";
    version = "2025-05-16";
    src = pkgs.fetchFromGitHub {
      owner = "xiantang";
      repo = "darcula-dark.nvim";
      rev = "5e8edf8b2aff3bf3d5110799713d29649cb87bbb";
      sha256 = "jTRd2rGAkOWSplTcOF52T2ttt4GLIgaZhUBoxSIUsHI=";
    };
    meta.homepage = "https://github.com/xiantang/darcula-dark.nvim";
  };

  # Import prerequisite packages
  prereqPkgs = import ./prereq-pkgs.nix { inherit pkgs; };

  # Pass neovim-unwrapped and your config
  neovimWrapped = neovimWrapper pkgs.neovim-unwrapped {
    wrapRc = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Language Server and More
      { plugin = nvim-lspconfig; } # default Nvim LSP client configurations
      { plugin = nvim-treesitter.withAllGrammars; } # from: https://nixos.wiki/wiki/Treesitter
      { plugin = plenary-nvim; }
      { plugin = mini-nvim; }

      # General
      { plugin = vim-lastplace; } # remember cursor location (even for folds)
      { plugin = nvim-ufo; } # FOLD/COLLAPSE: z+R, z+M, z+o, z+c, z+f
      #{ plugin = lspsaga-nvim; } # Peek Definitions # broken
      { plugin = ctrlp-vim; } # Ctrl+p to switch between files (conflict with barbar?)

      # GO language
      { plugin = vim-go; }

      # Nix language
      { plugin = vim-nix; }

      # Markdown language
      { plugin = markdown-nvim; } # markdown
      { plugin = nvim-treesitter-parsers.markdown; }
      { plugin = nvim-treesitter-parsers.markdown_inline; }
      { plugin = markdown-preview-nvim; } # markdown preview
      { plugin = img-clip-nvim; } # copy paste img to markdown # :checkhealth img-clip
      
      # UI
      { plugin = barbar-nvim; } # TABS: C+1, C+p
      { plugin = neo-tree-nvim; } # FILE BROWSER: <leader>e, C+w p, C+p, <, >

      # GIT
      { plugin = neogit; } # GIT integration that cannot handle worktrees
      { plugin = lazygit-nvim; } # Git integration
      { plugin = gitsigns-nvim; } # GIT SYMBOLS
      { plugin = diffview-nvim; } # View diffs

      # THEME
      { plugin = darcula-dark-nvim; }

      # AI integration
      { plugin = claude-code-nvim; }
    ];

    luaRcContent = ''
      -- include the system-wide .vimrc written in vimScript
      -- this makes the neovim config impure
      vim.cmd('source $HOME/.vimrc')

      -- we want to make sure this is set no matter what .vimrc does
      vim.api.nvim_command('filetype plugin indent on')

    ''+((import ./barbar.nix) {})+''
    ''+((import ./neo-tree.nix) {})+''
    ''+((import ./ufo.nix) {})+''

    ''+((import ./neogit.nix) {})+''
    ''+((import ./gitsigns.nix) {})+''
    ''+((import ./diffview.nix) {})+''
    ''+((import ./lazygit.nix) {})+''
    ''+((import ./treesitter.nix) {})+''
    ''+((import ./claude-code.nix) {})+''

      -- custom color scheme
      vim.cmd.colorscheme("darcula-dark")

    '';
  };
  
  # Create final package with prerequisite packages in PATH
  myNeovim = pkgs.symlinkJoin {
    name = "neovim-with-deps";
    paths = [ neovimWrapped ] ++ prereqPkgs;
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --prefix PATH : ${pkgs.lib.makeBinPath prereqPkgs}
    '';
  };
in
myNeovim
