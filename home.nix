{ pkgs, ... }: {
  nixpkgs.config = {
    allowUnfree = true; # Codeium completion
  };

  home.username = "jerry";
  home.homeDirectory = "/home/jerry";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  home.packages = [
    pkgs.curl
    pkgs.wget
    pkgs.ripgrep
    pkgs.fd
    pkgs.xclip 
    pkgs.kubectl
  ];

  programs.git = {
    enable = true;
    userName = "Jerry Wohlgemuth";
    userEmail = "wohlgejm@gmail.com";
    aliases = {
      co = "checkout";
      st = "status";
      br = "brach";
    };
    extraConfig.init.defaultBranch = "main";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # completion
      plenary-nvim
      nvim-cmp
      codeium-vim

      pkgs.vimPlugins.nvim-treesitter.withAllGrammars

      telescope-nvim
    ];

    extraLuaConfig = ''
      vim.opt.number = true;
      vim.opt.shiftwidth = 2;
      vim.opt.clipboard = "unnamedplus";
      vim.g.mapleader = " ";

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    '';
  };
}
