{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      gcc
      gnumake
      ripgrep
    ];
    # plugins = with pkgs.vimPlugins; [
    #   indent-blankline-nvim
    #   treewalker-nvim
    #   onedarkpro-nvim
    #   nvim-treesitter
    #   which-key-nvim
    #   telescope-nvim
    #   nvim-lspconfig
    #   nvim-autopairs
    #   neo-tree-nvim
    #   gitsigns-nvim
    #   nvzone-minty
    #   conform-nvim
    #   nvzone-typr
    #   nvzone-menu
    #   mason-nvim
    #   nvim-cmp
    # ];
  };
}
