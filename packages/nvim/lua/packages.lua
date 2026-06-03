-- lua/packages.lua
-- All plugin sources. vim.pack.add() is called once here.
-- To add a plugin: append an entry and restart Neovim.

vim.pack.add({

  -- UI / colour
  { src = "https://github.com/catppuccin/nvim",         name = "catppuccin" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/sphamba/smear-cursor.nvim" },

  -- Editor behaviour
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/kylechui/nvim-surround" },
  { src = "https://github.com/hiphish/rainbow-delimiters.nvim" },
  { src = "https://github.com/simnalamburt/vim-mundo" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

  -- Git
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/junegunn/vim-peekaboo" },

  -- File navigation
  { src = "https://github.com/mikavilpas/yazi.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

  -- LSP
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },

  -- Completion
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },

  -- Debugging (DAP)
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },


	-- { src = 'https://github.com/lambdalisue/vim-suda' }
  -- { src = "https://github.com/hedyhli/outline.nvim" }, -- Document symbol windows. TODO: not working, fix or use navbuddy
  -- { src = "https://github.com/SmiteshP/nvim-navbuddy" }, -- Document symbol windows. TODO: not finished setup. setup or figure out outline
})
