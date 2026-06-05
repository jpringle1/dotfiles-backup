-- lua/packages.lua
-- All plugin sources. vim.pack.add() is called once here.
-- To add a plugin: append an entry and restart Neovim.

local gh = "https://github.com/"

vim.pack.add({
  -- UI / colour
  {
	  src = gh .. "catppuccin/nvim",
	  name = "catppuccin"
  },
  { src = gh .. "nvim-mini/mini.icons" },
  { src = gh .. "nvim-tree/nvim-web-devicons" },
  { src = gh .. "akinsho/bufferline.nvim" },
  { src = gh .. "nvim-lualine/lualine.nvim" },
  { src = gh .. "sphamba/smear-cursor.nvim" },

  -- Editor behaviour
  { src = gh .. "nvim-treesitter/nvim-treesitter" },
  { src = gh .. "folke/which-key.nvim" },
  { src = gh .. "kylechui/nvim-surround" },
  { src = gh .. "hiphish/rainbow-delimiters.nvim" },
  { src = gh .. "simnalamburt/vim-mundo" },
  { src = gh .. "MeanderingProgrammer/render-markdown.nvim" },

  -- Git
  { src = gh .. "tpope/vim-fugitive" },
  { src = gh .. "junegunn/vim-peekaboo" },

  -- File navigation
  { src = gh .. "mikavilpas/yazi.nvim" },
  { src = gh .. "nvim-lua/plenary.nvim" },
  { src = gh .. "nvim-telescope/telescope.nvim" },
  { src = gh .. "nvim-telescope/telescope-fzf-native.nvim" },

  -- LSP
  { src = gh .. "neovim/nvim-lspconfig" },
  { src = gh .. "mason-org/mason.nvim" },
  { src = gh .. "mason-org/mason-lspconfig.nvim" },
  { src = gh .. "WhoIsSethDaniel/mason-tool-installer.nvim" },

  -- Completion
  { src = gh .. "hrsh7th/nvim-cmp" },
  { src = gh .. "hrsh7th/cmp-nvim-lsp" },
  { src = gh .. "hrsh7th/cmp-buffer" },
  { src = gh .. "hrsh7th/cmp-path" },

  -- Debugging (DAP)
  { src = gh .. "mfussenegger/nvim-dap" },
  { src = gh .. "nvim-neotest/nvim-nio" },
  { src = gh .. "rcarriga/nvim-dap-ui" },
  { src = gh .. "theHamsta/nvim-dap-virtual-text" },

  -- Misc
  { src = gh .. "norcalli/nvim-colorizer.lua" },
  { src = gh .. "kdheepak/lazygit.nvim" },
  { src = gh .. "dstein64/vim-startuptime" },
  { src = gh .. "DrKJeff16/project.nvim" },
  { src = gh .. "folke/persistence.nvim" },
  -- { src = gh .. "lambdalisue/vim-suda" }
  -- { src = gh .. "hedyhli/outline.nvim" }, -- Document symbol windows. TODO: not working, fix or use navbuddy
  -- { src = gh .. "SmiteshP/nvim-navbuddy" }, -- Document symbol windows. TODO: not finished setup. setup or figure out outline
})
