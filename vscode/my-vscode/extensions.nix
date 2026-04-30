{ pkgs }:
(with pkgs.vscode-extensions; [
  # Vim emulation (matches the .vimrc / .ideavimrc setup)
  vscodevim.vim

  # LaTeX (settings.json configures latex-workshop recipes)
  james-yu.latex-workshop

  # Go (settings.json sets go.toolsManagement.autoUpdate)
  golang.go

  # Godot (settings.json sets godotTools.editorPath.godot4)
  geequlim.godot-tools

  # Nix language support (syntax, formatting, LSP via nil/nixd)
  jnoortheen.nix-ide
])
++
# Extensions not in nixpkgs - fetched from the VS Code Marketplace.
# To bump a version: get the latest tag from the marketplace, then run
#   nix store prefetch-file --hash-type sha256 \
#     "https://<publisher>.gallery.vsassets.io/_apis/public/gallery/publisher/<publisher>/extension/<name>/<version>/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
pkgs.vscode-utils.extensionsFromVscodeMarketplace [
  {
    # "Darcula Theme from IntelliJ" - referenced by settings.json's workbench.colorTheme
    name = "vscode-theme-darcula";
    publisher = "rokoroku";
    version = "1.2.3";
    sha256 = "sha256-tlI+3DyDPo9tTOVTrEHoOtVTnEYSjgu9wojTXmEvv4E=";
  }
  {
    # "Claude Code for VS Code" - Anthropic's official VS Code integration
    name = "claude-code";
    publisher = "anthropic";
    version = "2.1.123";
    sha256 = "sha256-8vJHvwYdCdQb0kHNbM6KNp27BJh8RGrBmw++Zz7nLf4=";
  }
]
