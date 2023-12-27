{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      cmp-spell
      cmp-treesitter
      cmp-vsnip
      friendly-snippets
      gitsigns-nvim
      lightline-vim
      lspkind-nvim
      neogit
      nvim-autopairs
      nvim-cmp
      nvim-colorizer-lua
      nvim-lspconfig
      nvim-tree-lua
      nvim-ts-rainbow
      nvim-treesitter
      plenary-nvim
      telescope-fzy-native-nvim
      telescope-nvim
      vim-vsnip
      which-key-nvim
      dashboard-nvim
      nerdtree
      leap-nvim
    ];

    extraPackages = with pkgs; [
      gcc
      ripgrep
      fd
      nil
      rust-analyzer
      wl-clipboard
      clang-tools_16
      lua-language-server
      cmake-language-server
    ];

    extraConfig = let
      luaRequire = module:
        builtins.readFile (builtins.toString
          ./config
          + "/${module}.lua");
      luaConfig = builtins.concatStringsSep "\n" (map luaRequire [
        "init"
        "utils"
        "lspconfig"
        "nvim-cmp"
        "theming"
        "treesitter"
        "which-key"
      	"dashboard"
        "nerdtree"
      ]);
    in ''
      lua << 
      ${luaConfig}
      
    '';
  };

  xdg.configFile."nvim/parser".source = "${pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
      c
      lua
      query
    ])).dependencies;
  }}/parser";
}
