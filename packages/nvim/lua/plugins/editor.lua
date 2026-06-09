-- lua/plugins/editor.lua

-- Treesitter: auto-enable for every filetype
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Surround
require('nvim-surround').setup({})

-- Which-key
require('which-key').setup({})

-- Smear cursor
-- require('smear_cursor').setup({})

-- Yazi file manager
require('yazi').setup({
  open_for_directories = true,
})

vim.keymap.set('n', '<leader>e', function()
  require('yazi').yazi()
end, { desc = 'Open Yazi file manager' })

vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { silent = true })

require("project").setup()
require("persistence").setup({
  need = 0,
})

require("gitsigns").setup({
	linehl = true,
	numhl = true,
	-- word_diff = true
})

vim.keymap.set("n", "<leader>hP", function()
  require("gitsigns").preview_hunk_inline()
end)
