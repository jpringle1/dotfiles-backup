-- lua/plugins/editor.lua
-- Treesitter, surround, which-key, yazi, smear-cursor, rainbow-delimiters

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
