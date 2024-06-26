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

    # language servers
    pkgs.rubyPackages.solargraph
    pkgs.nodePackages_latest.typescript-language-server
    pkgs.nodePackages_latest.pyright
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
      # utility
      telescope-nvim
      lualine-nvim
      nvim-web-devicons
      yanky-nvim

      # completion
      plenary-nvim
      nvim-cmp
      codeium-vim

      # highlighting
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars

      # jump to definitions
      nvim-lspconfig
    ];

    extraLuaConfig = ''
      vim.opt.number = true;
      vim.opt.shiftwidth = 2;
      vim.opt.clipboard = "unnamedplus";
      vim.g.mapleader = " ";

      vim.keymap.set('n', '<leader>w', '<C-w>', {})
      vim.keymap.set('n', '<leader>n', ':bnext<CR>', {})
      vim.keymap.set('n', '<leader>x', ':bdelete<CR>', {})

      require('lualine').setup()

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

      require("yanky").setup({})
      vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
      require("telescope").load_extension("yank_history")
      vim.keymap.set("n", "<leader>fc", "<cmd>Telescope yank_history<cr>", {})

      local lspconfig = require('lspconfig')
      lspconfig.solargraph.setup {}
      lspconfig.pyright.setup {}
      lspconfig.tsserver.setup {}

      vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
	  local opts = { buffer = ev.buf }
	  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	end
      })
    '';
  };
}
